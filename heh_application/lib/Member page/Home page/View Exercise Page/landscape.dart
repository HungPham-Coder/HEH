import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class LandScapePage extends StatefulWidget {
  const LandScapePage({Key? key, required this.controller}) : super(key: key);
  final VideoPlayerController controller;

  @override
  State<LandScapePage> createState() => _LandScapePageState();
}

class _LandScapePageState extends State<LandScapePage> {
  Future _landscapeMode() async {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  Future _setAllOrientation() async {
    await SystemChrome.setPreferredOrientations(DeviceOrientation.values);
  }

  @override
  void initState() {
    super.initState();
    _landscapeMode();
  }

  @override
  void dispose() {
    _setAllOrientation();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => VideoPlayer(widget.controller);
}
