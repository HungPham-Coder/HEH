import 'package:flutter/material.dart';

class SlideDot extends StatelessWidget {
  bool isActive;
  SlideDot(this.isActive);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      height: isActive ? 12 : 8,
      width: isActive ? 12 : 8,
      decoration: BoxDecoration(
          color: isActive ? Theme.of(context).primaryColor : Colors.green,
          borderRadius: const BorderRadius.all(Radius.circular(12))),
    );
  }
}
