import 'package:flutter/material.dart';
import 'package:heh_application/Main%20page/Home%20page/Favorite.dart';

class AdviseSession extends StatefulWidget {
  const AdviseSession({Key? key}) : super(key: key);

  @override
  State<AdviseSession> createState() => _AdviseSessionState();
}

class _AdviseSessionState extends State<AdviseSession> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Tư vấn một buổi",
          style: TextStyle(fontSize: 23),
        ),
        actions: [
          IconButton(
              onPressed: () {
                showSearch(context: context, delegate: MySearchDelegate());
              },
              icon: const Icon(Icons.search)),
        ],
        centerTitle: true,
        elevation: 10,
        backgroundColor: const Color.fromARGB(255, 46, 161, 226),
      ),
      body: Column(children: [TextButton(onPressed: () {}, child: Column())]),
    );
  }
}
