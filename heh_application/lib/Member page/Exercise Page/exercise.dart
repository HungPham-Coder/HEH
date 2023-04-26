import 'package:flutter/material.dart';
import 'package:heh_application/Login%20page/landing_page.dart';
import 'package:heh_application/Member%20page/Exercise%20Page/detail.dart';

import 'package:heh_application/common_widget/menu_listview.dart';
import 'package:heh_application/models/exercise_model/exercise.dart';
import 'package:heh_application/services/auth.dart';
import 'package:provider/provider.dart';

import '../../common_widget/search_delegate.dart';

class ExercisePage extends StatefulWidget {
  ExercisePage({Key? key, required this.categoryID}) : super(key: key);
  String categoryID;
  @override
  State<ExercisePage> createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Vấn đề của bạn",
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
            FutureBuilder<List<Exercise>?>(
                future: auth.getListExerciseByCategoryID(
                    widget.categoryID, sharedResultLogin!.accessToken!),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        print(snapshot.data![index].exerciseName);
                        return MenuListView(
                          icon:
                              "https://firebasestorage.googleapis.com/v0/b/healthcaresystem-98b8d.appspot.com/o/icon%2Fbackache.png?alt=media&token=d725e1f5-c106-41f7-9ee5-ade77c464a54",
                          text: "${snapshot.data![index].exerciseName}",
                          press: () async {
                            // List<ExerciseDetail1> exerciseDetailList = await CallAPI()
                            //     .getExerciseDetailByExerciseID(
                            //         snapshot.data![index].exerciseID);
                            // ExerciseResource exerciseResource = await CallAPI()
                            //     .getExerciseResourceByExerciseDetailID(
                            //         exerciseDetail.exerciseDetailID);
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return ExerciseDetail(
                                exerciseID: snapshot.data![index].exerciseID,
                              );
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


// class MySearchDelegate extends SearchDelegate {
//   List<String> searchResults = ['a', 'b']; //danh sach tim kiem
//   @override
//   List<Widget>? buildActions(BuildContext context) => [
//         IconButton(
//             onPressed: () {
//               if (query.isEmpty) {
//                 close(context, null);
//               } else {
//                 query = '';
//               }
//             },
//             icon: const Icon(Icons.clear))
//       ];
//
//   @override
//   Widget? buildLeading(BuildContext context) => IconButton(
//       onPressed: () => close(context, null),
//       icon: const Icon(Icons.arrow_back));
//
//   @override
//   Widget buildResults(BuildContext context) => Center(
//         child: Text(query, style: const TextStyle(fontSize: 64)),
//       );
//
//   @override
//   Widget buildSuggestions(BuildContext context) {
//     List<String> suggestions = searchResults.where((searchResult) {
//       final result = searchResult.toLowerCase();
//       final input = query.toLowerCase();
//
//       return result.contains(input);
//     }).toList();
//
//     return ListView.builder(
//         itemCount: suggestions.length,
//         itemBuilder: (context, index) {
//           final suggestion = suggestions[index];
//
//           return ListTile(
//             title: Text(suggestion),
//             onTap: () {
//               query = suggestion;
//               showResults(context);
//             },
//           );
//         });
//   }
// }
