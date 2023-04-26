import 'package:flutter/material.dart';
import 'package:heh_application/Member%20page/Exercise%20Page/resourceDetail.dart';
import 'package:heh_application/common_widget/menu_listview.dart';
import 'package:heh_application/models/exercise_model/exercise_detail.dart';
import 'package:heh_application/models/exercise_resource.dart';
import 'package:heh_application/services/call_api.dart';

import '../../Login page/landing_page.dart';
import '../../common_widget/search_delegate.dart';

class ExerciseResources extends StatefulWidget {
  ExerciseResources({
    Key? key,
    required this.detailID,
    this.exerciseDetail,
    this.exerciseResource,
  }) : super(key: key);

  String? detailID;
  ExerciseDetail1? exerciseDetail;
  List<ExerciseResource>? exerciseResource;
  @override
  State<ExerciseResources> createState() => _ExerciseResourcesState();
}

class _ExerciseResourcesState extends State<ExerciseResources> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey,
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  showSearch(context: context, delegate: MySearchDelegate());
                },
                icon: const Icon(Icons.search)),
          ],
          centerTitle: true,
          title: const Text(
            // widget.exerciseDetail!.detailName!,
            "Các loại tài nguyên",
            style: TextStyle(
              fontSize: 23,
              color: Colors.white,
              // fontFamily: "Times New Roman",
            ),
          ),
          backgroundColor: const Color.fromARGB(255, 46, 161, 226),
        ),
        body: CustomScrollView(
          physics: const ScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  const SizedBox(height: 5),
                  FutureBuilder<List<ExerciseResource>?>(
                      future: CallAPI().getExerciseResourceByExerciseDetailID(
                          widget.detailID!),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              print(snapshot.data![index].exerciseResourceID);
                              return ResourceListView(
                                icon: snapshot.data![index].imageURL!,
                                text: widget.exerciseResource![index].imageURL!,
                                press: () async {
                                  List<ExerciseResource> exerciseResource =
                                      await CallAPI()
                                          .getExerciseResourceByExerciseDetailID(
                                              snapshot.data![index]
                                                  .exerciseDetailID);
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    if (exerciseResource != null) {
                                      return ExerciseResourcesDetail(
                                        exerciseID: widget.detailID!,
                                        // exerciseDetail: snapshot.data![index],
                                        exerciseResource: exerciseResource,
                                      );
                                    } else {
                                      return ExerciseResourcesDetail(
                                        exerciseID: widget.detailID!,
                                      );
                                    }
                                  }));
                                },
                              );
                            },
                          );
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      }),
                ],
              ),
            )
          ],
        ));
  }
}
