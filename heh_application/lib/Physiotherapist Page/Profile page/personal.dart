import 'package:flutter/material.dart';

class PhysioPersonalPage extends StatefulWidget {
  const PhysioPersonalPage({Key? key}) : super(key: key);

  @override
  State<PhysioPersonalPage> createState() => _PhysioPersonalPageState();
}

class _PhysioPersonalPageState extends State<PhysioPersonalPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Tài khoản của bạn",
          style: TextStyle(fontSize: 23),
        ),
        elevation: 10,
        backgroundColor: const Color.fromARGB(255, 46, 161, 226),
      ),
    );
  }
}
