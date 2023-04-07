import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChooseClockPage extends StatefulWidget {
  const ChooseClockPage({Key? key}) : super(key: key);

  @override
  State<ChooseClockPage> createState() => _ChooseClockPageState();
}

class _ChooseClockPageState extends State<ChooseClockPage> {
  final TextEditingController _date = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Chọn khung giờ",
          style: TextStyle(fontSize: 23),
        ),
        elevation: 10,
        backgroundColor: const Color.fromARGB(255, 46, 161, 226),
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [],
          )),
    );
  }
}

class TimeMenu extends StatelessWidget {
  const TimeMenu({Key? key, required this.timeStart, required this.label})
      : super(key: key);
  final DateTime timeStart;
  final String label;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(label),
            const Text(" *"),
          ],
        ),
        TextField(
            decoration: const InputDecoration(
              hintText: "Giờ bắt đầu",
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black)),
            ),
            onTap: () async {
              DateTime? pickeddate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1960),
                  lastDate: DateTime(2030));
              if (pickeddate != null) {
                String timeStart = DateFormat('yyyy-MM-dd').format(pickeddate);
              }
            })
      ],
    );
  }
}
