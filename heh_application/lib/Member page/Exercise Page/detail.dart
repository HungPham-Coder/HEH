import 'package:flutter/material.dart';
import 'package:heh_application/Video%20setting/landscape.dart';
import 'package:heh_application/models/exercise_model/exercise_detail.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import '../../services/firebase_firestore.dart';

class ExerciseDetail extends StatefulWidget {
   ExerciseDetail({Key? key, this.exerciseDetail1}) : super(key: key);
  ExerciseDetail1? exerciseDetail1;
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

  @override
  void dispose() {
    super.dispose();
    _vidController.dispose();
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
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
                toolbarHeight: 45,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [Icon(Icons.favorite_border, size: 40)],
                ),
                bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(0),
                    child: Container(
                      color: const Color.fromARGB(255, 46, 161, 226),
                      child:  Center(
                          child: Text(
                        widget.exerciseDetail1!.detailName!,
                        style: TextStyle(
                          fontSize: 23,
                          color: Colors.white,
                          // fontFamily: "Times New Roman",
                        ),
                      )),
                      width: double.maxFinite,
                      padding: const EdgeInsets.only(top: 5, bottom: 10),
                    )),
                backgroundColor: const Color.fromARGB(255, 46, 161, 226),
                pinned: true,
                expandedHeight: 200,
                flexibleSpace: FutureBuilder<String>(
                  future:FirebaseFirestores().getImage('lung1.png') ,
                  builder: (context, snapshot)
                   {
                     if (snapshot.hasData){
                       return FlexibleSpaceBar(
                         //     background: Image.asset(
                         //   "assets/images/Exer.png",
                         //   width: double.maxFinite,
                         //   fit: BoxFit.cover,
                         // )
                         background: Image.network(snapshot.data!),
                       );
                     }
                    return CircularProgressIndicator();
                  }
                )),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(height: 10),
                         Center(
                          child: Text(
                            "Thông tin bài tập",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                         Text(
                          widget.exerciseDetail1!.description,
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          color: const Color.fromARGB(255, 46, 161, 226),
                          height: MediaQuery.of(context).size.height / 2.5,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 0, vertical: 0),
                            child: _vidController.value.isInitialized
                                ? Column(children: <Widget>[
                                    const SizedBox(height: 10),
                                    const Text("Video hướng dẫn",
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.white)),
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              if (_vidController
                                                  .value.isPlaying) {
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
                                              builder: (context,
                                                  VideoPlayerValue value,
                                                  child) {
                                                return Text(
                                                  _videoDuration(
                                                      value.position),
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16),
                                                );
                                              }),
                                          Expanded(
                                              child: SizedBox(
                                                  height: 20,
                                                  child: VideoProgressIndicator(
                                                      _vidController,
                                                      allowScrubbing: true,
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 0,
                                                          horizontal: 7)))),
                                          Text(
                                              _videoDuration(_vidController
                                                  .value.duration),
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16)),
                                          IconButton(
                                            onPressed: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          LandScapePage(
                                                              controller:
                                                                  _vidController)));
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
                                    child: CircularProgressIndicator(
                                        color: Colors.white),
                                  ),
                          ),
                        ),
                      ],
                    )),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
