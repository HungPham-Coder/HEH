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
  const LandingPage({Key? key}) : super(key: key);

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
          print(context);
          return const LoginPage();
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
                  } else if (sharedCurrentUser!.role!.name ==
                      "Physiotherapist") {
                    return Provider<FirebaseFirestoreBase>(
                      create: (context) => FirebaseFirestores(),
                      child: const PhyNavigation_bar(),
                    );
                  } else {
                    return const LoginPage();
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
