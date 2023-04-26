import 'package:flutter/material.dart';
import 'package:heh_application/Member%20page/Exercise%20Page/resource.dart';

import 'package:heh_application/common_widget/menu_listview.dart';
import 'package:heh_application/models/exercise_model/exercise_detail.dart';
import 'package:heh_application/models/exercise_resource.dart';
import 'package:heh_application/services/auth.dart';
import 'package:heh_application/services/call_api.dart';
import 'package:provider/provider.dart';

import '../../common_widget/search_delegate.dart';

class ExerciseDetail extends StatefulWidget {
  ExerciseDetail({Key? key, this.exerciseID}) : super(key: key);
  String? exerciseID;
  @override
  State<ExerciseDetail> createState() => _ExerciseDetailState();
}

class _ExerciseDetailState extends State<ExerciseDetail> {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Bài tập cụ thể",
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
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(
          children: [
            FutureBuilder<List<ExerciseDetail1>>(
                future:
                    CallAPI().getExerciseDetailByExerciseID(widget.exerciseID!),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        print(snapshot.data![index].detailName);
                        return MenuListView(
                          icon:
                              "https://firebasestorage.googleapis.com/v0/b/healthcaresystem-98b8d.appspot.com/o/icon%2Fbackache.png?alt=media&token=d725e1f5-c106-41f7-9ee5-ade77c464a54",
                          text: "${snapshot.data![index].detailName}",
                          press: () async {
                            List<ExerciseDetail1> exerciseDetailList =
                                await CallAPI().getExerciseDetailByExerciseID(
                                    snapshot.data![index].exerciseID);
                            List<ExerciseResource> exerciseResource =
                                await CallAPI()
                                    .getExerciseResourceByExerciseDetailID(
                                        snapshot.data![index].exerciseDetailID);
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              if (exerciseDetailList != null) {
                                return ExerciseResources(
                                  detailID: widget.exerciseID!,
                                  // exerciseDetail: snapshot.data![index],
                                  // exerciseResource: exerciseResource,
                                );
                              } else {
                                return ExerciseResources(
                                  detailID: widget.exerciseID!,
                                );
                              }
                            }));
                          },
                        );
                      },
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                }),
          ],
        ),
      ),
    );
  }
}
