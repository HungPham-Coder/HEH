import 'package:flutter/material.dart';

import 'package:agora_uikit/agora_uikit.dart';

class VideoCallScreen extends StatefulWidget {
  const VideoCallScreen({Key? key}) : super(key: key);

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  final AgoraClient client = AgoraClient(
      agoraConnectionData: AgoraConnectionData(
          appId: "1405b81aefdb475a94c00cc139ed7450",
          channelName: "video",
          uid: 0,
          username: "abc",
          tempToken:
              "007eJxTYEi6Ly6vaPJ6+9xGwxM5xneUa9M09jJk/9A+dF21auttu+cKDIYmBqZJFoaJqWkpSSbmpomWJskGBsnJhsaWqSnmJqYGl6+YpzQEMjJ4evxnYWSAQBCflaEsMyU1n4EBAFQTH/U="));

  @override
  void initState() {
    super.initState();
    initAgora();
  }

  Future<void> initAgora() async {
    await client.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Text("Gọi Video"),
          ),
          body: SafeArea(
              child: Stack(children: [
            AgoraVideoViewer(
              client: client,
              layoutType: Layout.floating,
            ),
            AgoraVideoButtons(
              client: client,
              enabledButtons: const [
                BuiltInButtons.callEnd,
                BuiltInButtons.toggleCamera,
                BuiltInButtons.toggleMic,
                BuiltInButtons.switchCamera,
              ],
            )
          ])),
        ));
  }
}
