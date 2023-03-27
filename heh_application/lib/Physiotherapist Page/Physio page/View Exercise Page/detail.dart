import 'package:flutter/material.dart';

import 'package:heh_application/Member%20page/Home%20page/favorite.dart';
import 'package:heh_application/Physiotherapist%20Page/Physio%20page/View%20Exercise%20Page/landscape.dart';
import 'package:video_player/video_player.dart';

class ExerciseDetail extends StatefulWidget {
  const ExerciseDetail({Key? key}) : super(key: key);

  @override
  State<ExerciseDetail> createState() => _ExerciseDetailState();
}

class _ExerciseDetailState extends State<ExerciseDetail> {
  late VideoPlayerController _vidController;
  // int _currentIndex = 0;

  // void _playVideo({int index = 0, bool init = false}) {
  //   if (index < 0 || index >= videos.length) return;

  //   _vidController = VideoPlayerController.network(videos[_currentIndex].url)
  //     ..addListener(() => setState(() {}))
  //     ..setLooping(true)
  //     ..initialize().then((value) => _vidController.play());
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   _playVideo(init: true);
  // }

  // @override
  // void dispose() {
  //   _vidController.dispose();
  //   super.dispose();
  // }

  String _videoDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return [if (duration.inHours > 0) hours, minutes, seconds].join(':');
  }

  @override
  void initState() {
    loadVideoPlayer();
    super.initState();
  }

  loadVideoPlayer() {
    _vidController = VideoPlayerController.asset('assets/videos/video.mp4');
    _vidController.addListener(() {
      setState(() {});
    });
    _vidController.initialize().then((value) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            "Kéo giãn cơ tứ đầu",
            style: TextStyle(fontSize: 23),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  MaterialPageRoute(builder: (context) => const FavoritePage());
                },
                icon: Image.asset("assets/icons/favorite_white.png")),
          ],
          elevation: 10,
          backgroundColor: const Color.fromARGB(255, 46, 161, 226),
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            const SizedBox(height: 10),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Center(
                          child: Text(
                            "Thông tin bài tập",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        const Text(
                          "Nằm sấp: Sử dụng một cái khăn (hoặc băng thun) gắn 1 đầu khăn vào bàn chân cần kéo giãn và kéo gót chân đến mông của bạn. Giữ khoảng 1 phút, lặp lại 3 lần.",
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 20),
                        Center(
                          child: Image.asset(
                            "assets/images/Exer.png",
                            height: 200,
                            width: 300,
                          ),
                        ),
                      ],
                    )),
                  ],
                )),
            const SizedBox(height: 20),
            Container(
              color: const Color.fromARGB(255, 46, 161, 226),
              height: MediaQuery.of(context).size.height / 2.3,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: _vidController.value.isInitialized
                    ? Column(children: <Widget>[
                        const SizedBox(height: 10),
                        const Text("Video hướng dẫn",
                            style:
                                TextStyle(fontSize: 20, color: Colors.white)),
                        const SizedBox(height: 10),
                        Stack(
                          children: [
                            SizedBox(
                              height: 200,
                              child: VideoPlayer(_vidController),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () {
                                  if (_vidController.value.isPlaying) {
                                    _vidController.pause();
                                  } else {
                                    _vidController.play();
                                  }
                                },
                                icon: Icon(
                                  _vidController.value.isPlaying
                                      ? Icons.pause
                                      : Icons.play_arrow,
                                  size: 30,
                                ),
                                color: Colors.white,
                              ),
                              ValueListenableBuilder(
                                  valueListenable: _vidController,
                                  builder:
                                      (context, VideoPlayerValue value, child) {
                                    return Text(
                                      _videoDuration(value.position),
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    );
                                  }),
                              Expanded(
                                  child: SizedBox(
                                      height: 20,
                                      child: VideoProgressIndicator(
                                          _vidController,
                                          allowScrubbing: true,
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 0, horizontal: 7)))),
                              Text(
                                  _videoDuration(_vidController.value.duration),
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 16)),
                              IconButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => LandScapePage(
                                          controller: _vidController)));
                                },
                                icon: const Icon(
                                  Icons.fullscreen,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                            ],
                          ),
                        )
                      ])
                    : const Center(
                        child: CircularProgressIndicator(color: Colors.white),
                      ),
              ),
            ),
          ],
        )));
  }
}
