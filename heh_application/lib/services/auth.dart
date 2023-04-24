import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:heh_application/models/exercise_model/exercise_detail.dart';
import 'package:heh_application/models/result_login.dart';
import 'package:heh_application/models/role.dart';
import 'package:heh_application/services/call_api.dart';

import '../models/exercise_model/exercise.dart';
import '../models/sign_up_user.dart';

abstract class AuthBase {
  Stream<User?> authStateChanges();
  Future<User?> signInWithGoogle();
  Future<User> signInWithFacebook();
  Future<List<Exercise>?> getListExerciseByCategoryID(
      String categoryID, String accessToken);
  // Future<User?> signInWithPhoneAndPassword(String phoneNumber, String password);

  // Future<User> signInWithEmailAndPassword (String username, String password);
  // Future<User> signUpWithEmailAndPassword (String username, String password);
  void verifyUserPhoneNumber(String phoneNumber);
  // Future<void> addLoginUserStream(ResultLogin resultLogin) ;
  // Future<void> addSignUpUserStream(SignUpUser? signUpUser);
  Future<bool> checkUserExistInPostgre(String email);
  Future<void> checkUserExistInFirebase(SignUpUser signUpUser);
  Future<SignUpUser> getCurrentUser(ResultLogin resultLogin);
  Future<void> signInAnonymously();
  // User? get currenUser;
  // Stream<ResultLogin> get userLoginStream;
  // Stream<SignUpUser> get userSignUpStream;
  void dispose();

  Future<void> signOut(BuildContext context);
}

class Auth implements AuthBase {
  // StreamController<ResultLogin> userStreamController = StreamController<
  //     ResultLogin>.broadcast();
  // StreamController<SignUpUser> signUpUserStreamController = StreamController<
  //     SignUpUser>.broadcast();
  //
  // @override
  // Stream<ResultLogin> get userLoginStream => userStreamController.stream;
  //
  // Stream<SignUpUser> get userSignUpStream => signUpUserStreamController.stream;
  CallAPI _callAPI = CallAPI();

  // ignore: override_on_non_overriding_member
  // @override
  // User? get currenUser => FirebaseAuth.instance.currentUser;

  @override
  Stream<User?> authStateChanges() => _firebaseAuth.authStateChanges();

  final _firebaseAuth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  @override
  Future<User> signInWithGoogle() async {
    final googleSignIn = GoogleSignIn();
    //call google sign in method
    final googleUser = await googleSignIn.signIn();

    //request sign in from device to google
    if (googleUser != null) {
      final googleAuth = await googleUser.authentication;

      //get authentication of google
      if (googleAuth.idToken != null) {
        final userCredential = await _firebaseAuth.signInWithCredential(
            GoogleAuthProvider.credential(
                idToken: googleAuth.idToken,
                accessToken: googleAuth.accessToken));
        // pass idtoken and access token to firebase to sign in with google

        return userCredential.user!;
        //firebase return google account
      } else {
        throw FirebaseAuthException(
            code: 'ERROR_MISSING_GOOGLE_ID_TOKEN',
            message: 'Missing Google ID Token');
        //throw exception when idtoken is null
      }
    } else {
      print("User null");

      throw FirebaseAuthException(
          code: 'ERROR_ABORTED_BY_USER', message: 'Sign in aborted by user');
      //can not sign in
    }
  }

  @override
  Future<User> signInWithFacebook() async {
    final fb = FacebookLogin();
    final respronse = await fb.logIn(permissions: [
      FacebookPermission.publicProfile,
      FacebookPermission.email
    ]);
    // ignore: avoid_print
    print("responese ${respronse.status}");
    switch (respronse.status) {
      case FacebookLoginStatus.success:
        final accessToken = respronse.accessToken;
        final userCredential = await _firebaseAuth.signInWithCredential(
          FacebookAuthProvider.credential(accessToken!.token),
        );
        return userCredential.user!;
      case FacebookLoginStatus.cancel:
        throw FirebaseAuthException(
          code: 'ERROR_ABORTED_BY_USER',
          message: 'Sign In Abort By User',
        );

      case FacebookLoginStatus.error:
        throw FirebaseAuthException(
          code: "ERROR_FACEBOOK_LOGIN_FAILED",
          message: respronse.error!.developerMessage,
        );
      default:
        throw UnimplementedError();
    }
  }

  // Future<User?> signInWithPhoneAndPassword(String phoneNumber, String password) async {
  //   UserCredential? userCredential;
  //    await _firebaseAuth.verifyPhoneNumber(
  //       phoneNumber: phoneNumber,
  //       verificationCompleted: (PhoneAuthCredential credential) async{
  //
  //   },
  //       verificationFailed: (FirebaseException e) {
  //         if (e.code == 'invalid-phone-number'){
  //           print('The provided phone number is not valid ');
  //     }
  //   },
  //       codeSent: (String verificationId, int? resendToken) async{
  //         String smsCode = "abc";
  //         PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);
  //         userCredential = await _firebaseAuth.signInWithCredential(credential);
  //
  //         },
  //       codeAutoRetrievalTimeout: (String verificationId) {});
  //
  //   if (userCredential != null) {
  //     return userCredential!.user;
  //   }
  //   else {
  //     throw FirebaseAuthException(
  //       code: "ERROR_PHONE_LOGIN_FAIL",
  //       message: "Please input again",
  //     );
  //   }
  // }

  // Future<User> signInWithEmailAndPassword (String username, String password) async {
  //
  //   final userCredential = await _firebaseAuth.signInWithCredential(EmailAuthProvider.credential(email: username, password: password));
  //   return userCredential.user!;
  // }
  // @override
  // Future<User> signUpWithEmailAndPassword(String username, String password) async {
  //   final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(email: username, password: password);
  //   return userCredential.user!;
  // }

  void verifyUserPhoneNumber(String phoneNumber) {
    _firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _firebaseAuth.signInWithCredential(credential).then(
              (value) => print('Logged in success'),
            );
      },
      verificationFailed: (FirebaseAuthException e) {
        print(e.message);
      },
      codeSent: (verificationId, forceResendingToken) {
        String receiveID = verificationId;
      },
      codeAutoRetrievalTimeout: (verificationId) {},
    );
  }

  // @override
  // Future<void> addLoginUserStream(ResultLogin? resultLogin) async  {
  //   // TODO: implement testStream
  //   userStreamController.sink.add(resultLogin!);
  // }

  @override
  Future<bool> checkUserExistInPostgre(String email) async {
    // TODO: implement checkUserExist
    SignUpUser? user = await _callAPI.getUserByEmail(email);

    if (user == null) {
      print("false");
      return false;
    } else {
      print("true");
      return true;
    }
  }

  @override
  Future<void> signOut(BuildContext context) async {
    final googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    final facebookLogin = FacebookLogin();
    await facebookLogin.logOut();
    await _firebaseAuth.signOut();

    // userStreamController.close();
    // Navigator.of(context).pop();
  }

  // void dispose() {
  //   userStreamController.close();
  // }

  @override
  Future<void> checkUserExistInFirebase(SignUpUser signUpUser) async {
    // TODO: implement checkUserExistInFirebase
    if (signUpUser != null) {
      final QuerySnapshot<Map<String, dynamic>> result = await _firestore
          .collection('user')
          .where('id', isEqualTo: signUpUser.userID)
          .get();
      final List<DocumentSnapshot> documents = result.docs;
      if (documents.length == 0) {
        _firestore.collection('user').doc(signUpUser.userID).set({
          'nickname': signUpUser.firstName,
          'photoUrl': '',
          'id': signUpUser.userID
        });
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  Future<SignUpUser> getCurrentUser(ResultLogin resultLogin) async {
    SignUpUser? signUpUser;
    if (resultLogin.lastName == "google" ||
        resultLogin.lastName == "facebook") {
      signUpUser = await _callAPI.getUserByEmail(resultLogin.userID!);
      print("login google ");
    } else {
      signUpUser = await _callAPI.getUserById(resultLogin.userID!);
    }

    // Role? role = await _callAPI.getUserRole(signUpUser!.userID!);
    print("auth ${signUpUser!.firstName}");
    return signUpUser;
  }

  @override
  Future<List<Exercise>?> getListExerciseByCategoryID(
      String categoryID, String accessToken) async {
    // TODO: implement getExerciseByCategoryID
    List<Exercise> list =
        await _callAPI.getListExerciseByCategoryID(categoryID);

    return list;
  }

  @override
  Future<void> signInAnonymously() async {
    // TODO: implement signInAnonymously
    await _firebaseAuth.signInAnonymously();
  }

  // @override
  // Future<void> addSignUpUserStream(SignUpUser? signUpUser)  async {
  //   // TODO: implement addSignUpUserStream
  //    signUpUserStreamController.sink.add(signUpUser!);
  //   // userSignUpStream.listen((event) {print('${event.firstName} auth');});
  //
  // }

// TODO: implement userSignUpStream
}
