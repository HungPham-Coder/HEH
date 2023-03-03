import 'package:flutter/material.dart';

class Physiotherapist extends StatefulWidget {
  const Physiotherapist({Key? key}) : super(key: key);

  @override
  State<Physiotherapist> createState() => _PhysiotherapistState();
}

class _PhysiotherapistState extends State<Physiotherapist> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(
            "Chuyên viên",
            style: TextStyle(fontSize: 23),
          ),
          elevation: 10,
          backgroundColor: const Color.fromARGB(255, 46, 161, 226),
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            Row(),
          ],
        )));
  }
}
