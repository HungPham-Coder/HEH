// ignore: file_names
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:heh_application/Login%20page/login.dart';
import 'package:heh_application/Member%20page/navigation_main.dart';
import 'package:heh_application/Physiotherapist%20Page/navigation_main.dart';
import 'package:heh_application/models/exercise_resource.dart';
import 'package:heh_application/models/medical_record.dart';
import 'package:heh_application/models/result_login.dart';
import 'package:heh_application/models/sign_up_user.dart';
import 'package:heh_application/services/auth.dart';
import 'package:heh_application/services/firebase_firestore.dart';
import 'package:provider/provider.dart';
import '../models/physiotherapist.dart';
import '../services/stream_test.dart';

ResultLogin? sharedResultLogin;
SignUpUser? sharedCurrentUser;
MedicalRecord? sharedMedicalRecord;
Physiotherapist? sharedPhysiotherapist;
ExerciseResource? sharedExerciseResource;

class LandingPage extends StatelessWidget {
  LandingPage({Key? key, this.msg}) : super(key: key);
  String? msg;
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    final stream = StreamTest.instance;
    return StreamBuilder<ResultLogin?>(
      stream: stream.loginUserStream,
      builder: (context, snapshot) {
        // if (snapshot.connectionState == ConnectionState.active) {
        // final ResultLogin? user = snapshot.data;
        // final SignUpUser? user = snapshot.data;

        if (snapshot.data == null || snapshot.data!.userID == 'signout') {
          return LoginPage(
            msg: msg,
          );
        } else if (snapshot.data!.role!.name == "Admin" ||
            snapshot.data!.role!.name == "Staff") {
          return LandingPage(
            msg: 'Account của bạn không có quyền truy cập vào app',
          );
        } else {
          sharedResultLogin = snapshot.data;
          Future<SignUpUser> futureCurrentUser =
              auth.getCurrentUser(sharedResultLogin!);
          return FutureBuilder<SignUpUser>(
              future: futureCurrentUser,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  sharedCurrentUser = snapshot.data;
                  if (sharedCurrentUser!.role!.name == "Member") {
                    return Provider<FirebaseFirestoreBase>(
                      create: (context) => FirebaseFirestores(),
                      child: Navigation_Bar(),
                    );
                  } else {
                    return Provider<FirebaseFirestoreBase>(
                      create: (context) => FirebaseFirestores(),
                      child: const PhyNavigation_bar(),
                    );
                  }
                } else {
                  print("khong data");

                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              });
        }
      },
    );

    // return const Navigation_Bar();
  }
  // }
  // return const Center(
  //   child: CircularProgressIndicator(),
  // );
}
