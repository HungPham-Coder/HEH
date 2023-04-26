import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:heh_application/models/exercise_model/exercise_detail.dart';
import 'package:heh_application/models/exercise_resource.dart';
import 'package:video_player/video_player.dart';

class ExerciseResourcesDetail extends StatefulWidget {
  ExerciseResourcesDetail(
      {Key? key,
      this.exerciseDetail,
      this.exerciseResource,
      required String exerciseID})
      : super(key: key);
  ExerciseDetail1? exerciseDetail;
  List<ExerciseResource>? exerciseResource;
  @override
  State<ExerciseResourcesDetail> createState() =>
      _ExerciseResourcesDetailState();
}

class _ExerciseResourcesDetailState extends State<ExerciseResourcesDetail> {
  late VideoPlayerController _vidController;
  ChewieController? chewieController;

  String _videoDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return [if (duration.inHours > 0) hours, minutes, seconds].join(':');
  }

  @override
  void initState() {
    initPlayer();
    // loadVideoPlayer();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _vidController.dispose();
    chewieController?.dispose();
    // chewieController?.dispose();
  }

  // loadVideoPlayer() {
  //   widget.exerciseResource!.forEach((element) {
  //     _vidController = VideoPlayerController.network(element.videoURL!);
  //     _vidController.addListener(() {
  //       setState(() {});
  //     });
  //     _vidController.initialize().then((value) {
  //       setState(() {});
  //     });
  //   });
  // }

  void initPlayer() async {
    widget.exerciseResource!.forEach((element) {
      _vidController = VideoPlayerController.network(element.videoURL!);
      _vidController.addListener(() {
        setState(() {});
      });
      _vidController.initialize().then((value) {
        setState(() {});
      });
    });
    chewieController = ChewieController(
      videoPlayerController: _vidController,
      aspectRatio: 16 / 9,
      // autoInitialize: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.exerciseDetail == null || widget.exerciseResource == null) {
      return Scaffold(
        body: Container(
          child: const Text("Khong co exercise cụ thể nào"),
        ),
      );
    } else {
      return Scaffold(
          backgroundColor: Colors.white,
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                actions: const [
                  Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Icon(Icons.favorite_border, size: 30),
                  )
                ],
                toolbarHeight: 45,
                title: Text(
                  widget.exerciseDetail!.detailName!,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    // fontFamily: "Times New Roman",
                  ),
                ),
                backgroundColor: const Color.fromARGB(255, 46, 161, 226),
                expandedHeight: 20,
              ),
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
                          const Center(
                            child: Text(
                              "Thông tin bài tập",
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          Text(
                            widget.exerciseDetail!.description,
                            style: const TextStyle(fontSize: 16),
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: widget.exerciseResource!.length,
                            itemBuilder: (context, index) => SizedBox(
                              child: Padding(
                                  padding: const EdgeInsets.only(bottom: 0),
                                  child: Image.network(widget
                                      .exerciseResource![index].imageURL!)),
                            ),
                          ),
                          // Container(
                          //   color: const Color.fromARGB(255, 46, 161, 226),
                          //   height: MediaQuery.of(context).size.height / 2.5,
                          //   child:
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 0, vertical: 0),
                            child: _vidController.value.isInitialized
                                ? Column(
                                    children: <Widget>[
                                      const SizedBox(height: 10),
                                      const Text("Video hướng dẫn",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.black)),
                                      const SizedBox(height: 10),
                                      Stack(
                                        children: [
                                          SizedBox(
                                              height: 200,
                                              child: Chewie(
                                                  controller:
                                                      chewieController!)),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      // SizedBox(
                                      //   child: Row(
                                      //     crossAxisAlignment:
                                      //         CrossAxisAlignment.center,
                                      //     children: [
                                      //       IconButton(
                                      //         onPressed: () {
                                      //           if (_vidController
                                      //               .value.isPlaying) {
                                      //             _vidController.pause();
                                      //           } else {
                                      //             _vidController.play();
                                      //           }
                                      //         },
                                      //         icon: Icon(
                                      //           _vidController.value.isPlaying
                                      //               ? Icons.pause
                                      //               : Icons.play_arrow,
                                      //           size: 30,
                                      //         ),
                                      //         color: Colors.black,
                                      //       ),
                                      //       ValueListenableBuilder(
                                      //           valueListenable: _vidController,
                                      //           builder: (context,
                                      //               VideoPlayerValue value,
                                      //               child) {
                                      //             return Text(
                                      //               _videoDuration(
                                      //                   value.position),
                                      //               style: const TextStyle(
                                      //                   color: Colors.black,
                                      //                   fontSize: 16),
                                      //             );
                                      //           }),
                                      //       Expanded(
                                      //           child: SizedBox(
                                      //               height: 15,
                                      //               child: VideoProgressIndicator(
                                      //                   _vidController,
                                      //                   allowScrubbing: true,
                                      //                   padding:
                                      //                       const EdgeInsets
                                      //                               .symmetric(
                                      //                           vertical: 0,
                                      //                           horizontal:
                                      //                               5)))),
                                      //       Text(
                                      //           _videoDuration(_vidController
                                      //               .value.duration),
                                      //           style: const TextStyle(
                                      //               color: Colors.black,
                                      //               fontSize: 16)),
                                      //       IconButton(
                                      //         onPressed: () {
                                      //           Navigator.of(context).push(
                                      //               MaterialPageRoute(
                                      //                   builder: (context) =>
                                      //                       LandScapePage(
                                      //                           controller:
                                      //                               _vidController)));
                                      //         },
                                      //         icon: const Icon(
                                      //           Icons.fullscreen,
                                      //           color: Colors.black,
                                      //           size: 30,
                                      //         ),
                                      //       ),
                                      //     ],
                                      //   ),
                                      // ),
                                    ],
                                  )
                                : const Center(
                                    child: CircularProgressIndicator(
                                        color: Colors.white),
                                  ),
                          ),
                          // ),
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
}
