import 'package:flutter/material.dart';

class MessageText extends StatefulWidget {
  const MessageText({Key? key}) : super(key: key);

  @override
  State<MessageText> createState() => _MessageTextState();
}

class _MessageTextState extends State<MessageText> {
  String? _messageContent;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: TextField(
      textAlignVertical: TextAlignVertical.center,
      textCapitalization: TextCapitalization.sentences,
      textInputAction: TextInputAction.send,
      onChanged: (value) => _messageContent = value,
      decoration: InputDecoration(
          suffixIcon:
              const IconButton(onPressed: _sendMessage, icon: Icon(Icons.send)),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          hintText: "Nhắn tin"),
    ));
  }
}

void _sendMessage() async {}
