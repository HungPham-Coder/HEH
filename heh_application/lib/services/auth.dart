import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:heh_application/services/call_api.dart';

import '../models/sign_up_user.dart';

abstract class AuthBase {
  Stream<User?> authStateChanges();
  Future<User?> signInWithGoogle();
  Future<User> signInWithFacebook();
  // Future<User?> signInWithPhoneAndPassword(String phoneNumber, String password);
  // Future<User> signInWithEmailAndPassword (String username, String password);
  // Future<User> signUpWithEmailAndPassword (String username, String password);
  void verifyUserPhoneNumber (String phoneNumber);
  Stream<SignUpUser> loginUserStream(SignUpUser signUpUser) ;
  Future<bool> checkUserExist(BuildContext context,String email) ;
  Future<void> signOut();
}

class Auth implements AuthBase {
  StreamController<SignUpUser> userStreamController = new StreamController<SignUpUser>();
  Stream<SignUpUser> get userStream => userStreamController.stream;
  CallAPI _callAPI = CallAPI();
  // ignore: override_on_non_overriding_member
  @override
  User? get currenUser => FirebaseAuth.instance.currentUser;

  @override
  Stream<User?> authStateChanges() => _firebaseAuth.authStateChanges();

  final _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<User?> signInWithGoogle() async {
    _firebaseAuth.userChanges();
    final googleSignIn = GoogleSignIn();
    //call google sign in method
    final googleUser = await googleSignIn.signIn().catchError((onError) => print(onError));
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

  void verifyUserPhoneNumber (String phoneNumber) {
    _firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _firebaseAuth.signInWithCredential(credential).then(
                (value) => print('Logged in success'),
          );
        },
        verificationFailed: (FirebaseAuthException e){
        print(e.message);
        },
        codeSent: (verificationId, forceResendingToken) {
          String receiveID = verificationId;
        },
        codeAutoRetrievalTimeout: (verificationId) {

        },);
  }



  @override
  Stream<SignUpUser> loginUserStream(SignUpUser signUpUser)  {
    // TODO: implement testStream
    userStreamController.sink.add(signUpUser);
    return userStream;
  }



  @override
  Future<bool> checkUserExist(BuildContext context,String email) async {
    // TODO: implement checkUserExist
    SignUpUser? user = await _callAPI.getUserByID(context, email);

    if (user == null) {
      print("false");
      return false;
    }
    else {
      print("true");
      return true;
    }
  }

  @override
  Future<void> signOut() async {
    final googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    final facebookLogin = FacebookLogin();
    await facebookLogin.logOut();
    await _firebaseAuth.signOut();
    userStreamController.close();
  }
}
