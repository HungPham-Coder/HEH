import 'package:flutter/material.dart';

Widget messageBubble(
    {required String chatContent,
    required EdgeInsetsGeometry? margin,
    Color? color,
    Color? textColor}) {
  return Container(
    padding: const EdgeInsets.all(10),
    constraints: const BoxConstraints(maxWidth: 225),
    margin: margin,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Text(
      chatContent,
      style: TextStyle(fontSize: 16, color: textColor),
    ),
  );
}
