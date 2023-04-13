import 'package:flutter/material.dart';

class MessageBubble extends StatefulWidget {
  const MessageBubble(
      {Key? key,
      this.profileImageUrl,
      required this.message,
      required this.date})
      : super(key: key);
  final String? profileImageUrl;
  final String message, date;
  @override
  State<MessageBubble> createState() => _MessageBubbleState();
}

class _MessageBubbleState extends State<MessageBubble> {
  @override
  Widget build(BuildContext context) {
    final isReciever = widget.profileImageUrl != null;
    return Row(
      mainAxisAlignment:
          isReciever ? MainAxisAlignment.start : MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (isReciever)
          Padding(
            padding: const EdgeInsets.all(8),
            child: CircleAvatar(
              backgroundColor: Colors.grey[200],
              foregroundImage: NetworkImage(widget.profileImageUrl!),
            ),
          ),
        Flexible(
            child: Column(
          crossAxisAlignment:
              isReciever ? CrossAxisAlignment.start : CrossAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              constraints: const BoxConstraints(maxHeight: 275),
              decoration: BoxDecoration(
                  color: isReciever ? Colors.green : Colors.blue,
                  borderRadius: BorderRadius.circular(10)),
              child: Text(
                widget.message,
                style: const TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.date,
              style: const TextStyle(fontSize: 10),
            )
          ],
        )),
        if (!isReciever) const SizedBox(width: 12),
      ],
    );
  }
}
