import 'package:flutter/material.dart';
Widget errorContainer() {
  return Container(
    clipBehavior: Clip.hardEdge,
    child: Image.asset(
      'assets/images/img_not_available.jpeg',
      height: 200,
      width: 200,
    ),
  );
}