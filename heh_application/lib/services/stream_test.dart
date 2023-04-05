import 'dart:async';

import 'package:heh_application/models/result_login.dart';

import '../models/sign_up_user.dart';

class StreamTest {
  StreamTest._();
  static final instance = StreamTest._();
  StreamController<SignUpUser> signUpUserStreamController =
      StreamController<SignUpUser>.broadcast();
  StreamController<ResultLogin> loginUserStreamController =
      StreamController<ResultLogin>.broadcast();
  Stream<ResultLogin> get loginUserStream => loginUserStreamController.stream;
  Stream<SignUpUser> get signupUserStream => signUpUserStreamController.stream;

  Future<void> addLoginStream(ResultLogin resultLogin) async {
    loginUserStreamController.sink.add(resultLogin);
  }

  Future<void> addSignUpStream(SignUpUser? signUpUser) async {
    signUpUserStreamController.sink.add(signUpUser!);
  }

  Future<void> handleLogout() async {
    ResultLogin resultLogin = ResultLogin(userID: "signout", firstName: 'null');
    await addLoginStream(resultLogin);
  }

  void dispose() {
    loginUserStreamController.close();
    signUpUserStreamController.close();
  }
}
