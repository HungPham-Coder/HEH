import 'package:flutter/material.dart';

class PhysioMessenger extends StatefulWidget {
  const PhysioMessenger({Key? key}) : super(key: key);

  @override
  State<PhysioMessenger> createState() => _PhysioMessengerState();
}

class _PhysioMessengerState extends State<PhysioMessenger> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Tin nhắn",
          style: TextStyle(fontSize: 23),
        ),
        elevation: 10,
        backgroundColor: const Color.fromARGB(255, 46, 161, 226),
      ),
    );
  }
}
