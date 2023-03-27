import 'package:flutter/material.dart';

class PhysioHistoryPage extends StatefulWidget {
  const PhysioHistoryPage({Key? key}) : super(key: key);

  @override
  State<PhysioHistoryPage> createState() => _PhysioHistoryPageState();
}

class _PhysioHistoryPageState extends State<PhysioHistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Lịch sử giao dịch",
          style: TextStyle(fontSize: 23),
        ),
        centerTitle: true,
        elevation: 10,
        backgroundColor: const Color.fromARGB(255, 46, 161, 226),
      ),
    );
  }
}
