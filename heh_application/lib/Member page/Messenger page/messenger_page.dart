import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:heh_application/Login%20page/login.dart';
import 'package:heh_application/constant/firestore_constant.dart';
import 'package:heh_application/services/auth.dart';
import 'package:heh_application/services/chat_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../common_widget/chat_image.dart';
import '../../common_widget/message_bubble.dart';
import '../../models/chat_model/chat_messages.dart';
import '../../models/chat_model/message_type.dart';

class MessengerPage extends StatefulWidget {
  const MessengerPage(
      {Key? key,
      required this.oponentID,
      required this.oponentAvartar,
      required this.oponentNickName,
      required this.userAvatar,
      required this.currentUserID})
      : super(key: key);
  final String oponentID;
  final String oponentAvartar;
  final String oponentNickName;
  final String? userAvatar;
  final String currentUserID;
  @override
  State<MessengerPage> createState() => _MessengerPageState();
}

class _MessengerPageState extends State<MessengerPage> {
  String groupChatID = '';
  int _limit = 20;
  final int _limitIncrement = 20;
  File? imageFile;
  bool isLoading = false;
  String imageURL = '';
  final FocusNode focusNode = FocusNode();
  List<QueryDocumentSnapshot> listMessages = [];

  final ScrollController scrollController = ScrollController();
  TextEditingController textEditingController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readLocal();
    scrollController.addListener(_scrollController);
  }

  Widget buildMessageInput() {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: Row(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 46, 161, 226),
              borderRadius: BorderRadius.circular(10),
            ),
            child: IconButton(
              onPressed: getImage,
              icon: const Icon(Icons.camera_alt, size: 30),
              color: Colors.white,
            ),
          ),
          Flexible(
              child: TextField(
            decoration: InputDecoration(
                hintText: "Tin nhắn...",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10))),
            focusNode: focusNode,
            textInputAction: TextInputAction.send,
            keyboardType: TextInputType.text,
            textCapitalization: TextCapitalization.sentences,
            controller: textEditingController,
            onSubmitted: (value) {
              onSendMessage(textEditingController.text, MessageType.text);
            },
          )),
          Container(
            margin: const EdgeInsets.only(left: 4),
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 46, 161, 226),
                borderRadius: BorderRadius.circular(30)),
            child: IconButton(
              onPressed: () =>
                  onSendMessage(textEditingController.text, MessageType.text),
              icon: const Icon(Icons.send_rounded),
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildItem(int index, DocumentSnapshot? documentSnapshot) {
    if (documentSnapshot != null) {
      ChatMessages chatMessages = ChatMessages.fromDocument(documentSnapshot);
      if (chatMessages.idFrom == widget.currentUserID) {
        // right side (my message)
        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                chatMessages.type == MessageType.text
                    ? messageBubble(
                        chatContent: chatMessages.content,
                        color: Colors.lightGreenAccent,
                        textColor: Colors.white,
                        margin: const EdgeInsets.only(right: 10),
                      )
                    : chatMessages.type == MessageType.image
                        ? Container(
                            margin: const EdgeInsets.only(right: 10, top: 10),
                            child: chatImage(
                                imageSrc: chatMessages.content, onTap: () {}),
                          )
                        : const SizedBox.shrink(),
                isMessageSent(index)
                    ? Container(
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Image.network(
                          widget.userAvatar!,
                          width: 40,
                          height: 40,
                          fit: BoxFit.cover,
                          loadingBuilder: (BuildContext ctx, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                color: Colors.blueAccent,
                                value: loadingProgress.expectedTotalBytes !=
                                            null &&
                                        loadingProgress.expectedTotalBytes !=
                                            null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            );
                          },
                          errorBuilder: (context, object, stackTrace) {
                            return const Icon(
                              Icons.account_circle,
                              size: 35,
                              color: Colors.grey,
                            );
                          },
                        ),
                      )
                    : Container(
                        width: 35,
                      ),
              ],
            ),
            isMessageSent(index)
                ? Container(
                    margin: const EdgeInsets.only(right: 50, top: 6, bottom: 8),
                    child: Text(
                      DateFormat('dd MMM yyyy, hh:mm a').format(
                        DateTime.fromMillisecondsSinceEpoch(
                          int.parse(chatMessages.timestamp),
                        ),
                      ),
                      style: const TextStyle(
                          color: Colors.lightGreen,
                          fontSize: 12,
                          fontStyle: FontStyle.italic),
                    ),
                  )
                : const SizedBox.shrink(),
          ],
        );
      } else {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                isMessageReceived(index)
                    // left side (received message)
                    ? Container(
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Image.network(
                          widget.oponentID,
                          width: 40,
                          height: 40,
                          fit: BoxFit.cover,
                          loadingBuilder: (BuildContext ctx, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                color: Colors.lightBlueAccent,
                                value: loadingProgress.expectedTotalBytes !=
                                            null &&
                                        loadingProgress.expectedTotalBytes !=
                                            null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            );
                          },
                          errorBuilder: (context, object, stackTrace) {
                            return const Icon(
                              Icons.account_circle,
                              size: 35,
                              color: Colors.grey,
                            );
                          },
                        ),
                      )
                    : Container(
                        width: 35,
                      ),
                chatMessages.type == MessageType.text
                    ? messageBubble(
                        color: Colors.lightBlueAccent,
                        textColor: Colors.white,
                        chatContent: chatMessages.content,
                        margin: const EdgeInsets.only(left: 10),
                      )
                    : chatMessages.type == MessageType.image
                        ? Container(
                            margin: const EdgeInsets.only(left: 10, top: 10),
                            child: chatImage(
                                imageSrc: chatMessages.content, onTap: () {}),
                          )
                        : const SizedBox.shrink(),
              ],
            ),
            isMessageReceived(index)
                ? Container(
                    margin: const EdgeInsets.only(left: 50, top: 6, bottom: 8),
                    child: Text(
                      DateFormat('dd MMM yyyy, hh:mm a').format(
                        DateTime.fromMillisecondsSinceEpoch(
                          int.parse(chatMessages.timestamp),
                        ),
                      ),
                      style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                          fontStyle: FontStyle.italic),
                    ),
                  )
                : const SizedBox.shrink(),
          ],
        );
      }
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget buildListMessage() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 1.35,
      child: Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.black)),
        child: Flexible(
          child: groupChatID.isNotEmpty
              ? StreamBuilder<QuerySnapshot>(
                  stream: ChatProvider().getChatMessage(groupChatID, _limit),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      listMessages = snapshot.data!.docs;
                      if (listMessages.isNotEmpty) {
                        return ListView.builder(
                            padding: const EdgeInsets.all(10),
                            itemCount: snapshot.data?.docs.length,
                            reverse: true,
                            controller: scrollController,
                            itemBuilder: (context, index) =>
                                buildItem(index, snapshot.data?.docs[index]));
                      } else {
                        return const Center(
                          child: Text('No messages...'),
                        );
                      }
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.lightBlueAccent,
                        ),
                      );
                    }
                  })
              : const Center(
                  child: CircularProgressIndicator(
                    color: Colors.lightBlueAccent,
                  ),
                ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.call),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.video_call),
              )
            ],
          )
        ],
        automaticallyImplyLeading: true,
        title: const Text(
          "Chăm sóc khách hàng",
          style: TextStyle(fontSize: 18),
        ),
        elevation: 10,
        backgroundColor: const Color.fromARGB(255, 46, 161, 226),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            children: [
              buildListMessage(),
              const SizedBox(height: 10),
              buildMessageInput(),
            ],
          ),
        ),
      ),
    );
  }

  void readLocal() {
    final chatProvider = Provider.of<ChatProviderBase>(context, listen: false);
    if (widget.currentUserID.isNotEmpty) {
      groupChatID = '${widget.currentUserID}';
    } else {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ),
        (Route<dynamic> route) => false,
      );
    }
    chatProvider.upLoadFirestoreData(
        FirestoreConstants.pathUserCollection,
        widget.currentUserID,
        {FirestoreConstants.chattingWith: widget.oponentID});
  }

  void _scrollController() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      setState(() {
        _limit += _limitIncrement;
      });
    }
  }

  bool isMessageSent(int index) {
    if (index > 0 &&
            listMessages[index - 1].get(FirestoreConstants.idFrom) !=
                widget.currentUserID ||
        index == 0) {
      return true;
    } else {
      return false;
    }
  }

  bool isMessageReceived(int index) {
    if (index > 0 &&
            listMessages[index - 1].get(FirestoreConstants.idFrom) ==
                widget.currentUserID ||
        index == 0) {
      return true;
    } else {
      return false;
    }
  }

  void onSendMessage(String content, int type) {
    if (content.trim().isNotEmpty) {
      textEditingController.clear();
      ChatProvider().sendChatMessage(
          groupChatID, content, type, widget.currentUserID, widget.oponentID);
      scrollController.animateTo(0,
          duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    } else {
      Fluttertoast.showToast(
          msg: 'Nothing to send', backgroundColor: Colors.grey);
    }
  }

  Future getImage() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? pickedFile;
    pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      if (imageFile != null) {
        setState(() {
          isLoading = true;
        });
        uploadImageFile();
      }
    }
  }

  void uploadImageFile() async {
    final chatProvider = Provider.of<ChatProviderBase>(context, listen: false);
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    UploadTask uploadTask = chatProvider.upLoadImageFile(imageFile!, fileName);
    try {
      TaskSnapshot snapshot = await uploadTask;
      imageURL = await snapshot.ref.getDownloadURL();
      setState(() {
        isLoading = false;

        onSendMessage(imageURL, MessageType.image);
      });
    } on FirebaseException catch (e) {
      setState(() {
        isLoading = false;
      });
      Fluttertoast.showToast(msg: e.message ?? e.toString());
    }
  }
}