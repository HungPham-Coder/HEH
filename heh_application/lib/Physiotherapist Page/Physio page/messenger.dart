import 'package:flutter/material.dart';

class PhysioMessengerPage extends StatefulWidget {
  const PhysioMessengerPage({Key? key}) : super(key: key);

  @override
  State<PhysioMessengerPage> createState() => _PhysioMessengerPageState();
}

class _PhysioMessengerPageState extends State<PhysioMessengerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Tin nhắn ",
          style: TextStyle(fontSize: 23),
        ),
        backgroundColor: const Color.fromARGB(255, 46, 161, 226),
      ),
    );
  }
}
