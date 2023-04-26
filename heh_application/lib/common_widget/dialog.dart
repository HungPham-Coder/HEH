import 'package:flutter/material.dart';

class dialog extends StatelessWidget {
  dialog({
    Key? key,
    required this.text,
    required this.des,
  }) : super(key: key);

  String text, des;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(text),
      actions: <Widget>[
        description(label: des),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              child: const Text('Hủy'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Đồng ý'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget description({
    label,
    obscureText = false,
  }) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(
              label,
              style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Colors.black87),
            ),
          ],
        ),
        const SizedBox(height: 10),
        TextFormField(
          obscureText: obscureText,
          // controller: controller,
          decoration: const InputDecoration(
              hintText: "Yêu cầu",
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey))),
        ),
        const SizedBox(height: 10)
      ],
    );
  }
}
