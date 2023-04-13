import 'package:flutter/material.dart';
import 'package:heh_application/Member%20page/Home%20page/Video%20call%20page/views/videoscreen.dart';
import 'package:heh_application/Member%20page/Home%20page/Video%20call%20page/widgets/messageBubble.dart';
import 'package:heh_application/Member%20page/Home%20page/Video%20call%20page/widgets/message_text.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => VideoCallScreen(),
                    )),
                icon: const Icon(Icons.video_call))
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
                  padding: const EdgeInsets.only(bottom: 16),
                  itemBuilder: (context, index) => messages[index],
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 16),
                  itemCount: messages.length),
            ),
            const MessageText(),
          ],
        ));
  }
}

const messages = <MessageBubble>[
  MessageBubble(
      profileImageUrl:
          "https://firebasestorage.googleapis.com/v0/b/healthcaresystem-98b8d.appspot.com/o/icon%2Fperson.png?alt=media&token=c5c521dc-2f27-4fb9-ba76-b0241c2dfe19",
      message: "ABCSASD",
      date: "11:30 13/04/2023"),
  MessageBubble(message: "ABCSASD12", date: "12:30 13/04/2023"),
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
