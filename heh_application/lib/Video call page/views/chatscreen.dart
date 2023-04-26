import 'package:flutter/material.dart';
import 'package:heh_application/Video%20call%20page/views/videoscreen.dart';
import 'package:heh_application/Video%20call%20page/widgets/messageBubble.dart';
import 'package:heh_application/Video%20call%20page/widgets/message_text.dart';
import 'package:agora_chat_sdk/agora_chat_sdk.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class AgoraChatConfig {
  static const String appKey = "61943435#1102339";
  static const String userId = "1";
  static const String agoraToken =
      "007eJxTYFDlCCmf8VmTm6ey4c8yyUW+ZV8uf5SfuiOgrXe2COfzFfcVGAxNDEyTLAwTU9NSkkzMTRMtTZINDJKTDY0tU1PMTUwNOiSdUhoCGRma6twZGRlYGRiBEMRXYTBOtLRINbAw0E01MDDUNTRMTdFNsjQ00TVPsTA0tzQwN0gxNAQAEbMlhQ=="; //user token
}

class _ChatScreenState extends State<ChatScreen> {
  ScrollController scrollController = ScrollController();
  String? _messageContent, _chatId;

  @override
  void initState() {
    super.initState();

    // _addChatListener();
  }

  @override
  void dispose() {
    ChatClient.getInstance.chatManager.removeEventHandler("UNIQUE_HANDLER_ID");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        actions: [
          IconButton(
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const VideoCallScreen(),
                  )),
              icon: const Icon(Icons.video_call)),
        ],
        title: const Text(
          "Tin nhắn",
          style: TextStyle(fontSize: 23, color: Colors.white),
        ),
        elevation: 10,
        backgroundColor: const Color.fromARGB(255, 46, 161, 226),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
                reverse: true,
                padding: const EdgeInsets.only(bottom: 10, top: 20),
                itemBuilder: (context, index) => messages[index],
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 16),
                itemCount: messages.length),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: MessageText(),
          ),
        ],
      ),
    );
  }
}

// const messages = <MessageBubble>[];
const messages = <MessageBubble>[
  MessageBubble(
      profileImageUrl:
          "https://firebasestorage.googleapis.com/v0/b/healthcaresystem-98b8d.appspot.com/o/icon%2Fperson.png?alt=media&token=c5c521dc-2f27-4fb9-ba76-b0241c2dfe19",
      message: "A",
      date: "11:30 13/04/2023"),
  MessageBubble(
      message:
          "ABCSASD12ABCSASD12ABCSASD12ABCSASD12ABCSASD12ABCSASD12ABCSASD12ABCSASD12ABCSASD12ABCSASD12ABCSASD12 ",
      date: "12:30 13/04/2023"),
  MessageBubble(message: "ABCSASD34", date: "13:30 13/04/2023"),
  MessageBubble(
      profileImageUrl:
          "https://firebasestorage.googleapis.com/v0/b/healthcaresystem-98b8d.appspot.com/o/icon%2Fperson.png?alt=media&token=c5c521dc-2f27-4fb9-ba76-b0241c2dfe19",
      message: "ABCSASD56",
      date: "14:30 13/04/2023"),
  MessageBubble(message: "ABCSASD", date: "11:30 13/04/2023"),
  MessageBubble(
      profileImageUrl:
          "https://firebasestorage.googleapis.com/v0/b/healthcaresystem-98b8d.appspot.com/o/icon%2Fperson.png?alt=media&token=c5c521dc-2f27-4fb9-ba76-b0241c2dfe19",
      message: "ABCSASD12",
      date: "12:30 13/04/2023"),
  MessageBubble(message: "ABCSASD34", date: "13:30 13/04/2023"),
  MessageBubble(
      profileImageUrl:
          "https://firebasestorage.googleapis.com/v0/b/healthcaresystem-98b8d.appspot.com/o/icon%2Fperson.png?alt=media&token=c5c521dc-2f27-4fb9-ba76-b0241c2dfe19",
      message: "ABCSASD56",
      date: "14:30 13/04/2023"),
  MessageBubble(message: "ABCSASD", date: "11:30 13/04/2023"),
  MessageBubble(
      profileImageUrl:
          "https://firebasestorage.googleapis.com/v0/b/healthcaresystem-98b8d.appspot.com/o/icon%2Fperson.png?alt=media&token=c5c521dc-2f27-4fb9-ba76-b0241c2dfe19",
      message: "ABCSASD12",
      date: "12:30 13/04/2023"),
];
