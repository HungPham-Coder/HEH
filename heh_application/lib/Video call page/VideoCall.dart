import 'package:flutter/material.dart';
import 'package:heh_application/Video%20call%20page/views/chatscreen.dart';

class VideoCallPage extends StatefulWidget {
  const VideoCallPage({Key? key}) : super(key: key);

  @override
  State<VideoCallPage> createState() => _VideoCallPageState();
}

class _VideoCallPageState extends State<VideoCallPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Video Call",
      theme: ThemeData(
          primaryColor: const Color.fromARGB(255, 46, 161, 226),
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
              color: Colors.white,
              titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 23,
                  fontWeight: FontWeight.w600)),
          iconTheme: IconThemeData(color: Colors.black)),
      builder: (context, child) => Unfocus(child: child!),
      home: ChatScreen(),
    );
  }
}

class Unfocus extends StatelessWidget {
  const Unfocus({Key? key, required this.child}) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: child,
    );
  }
}
