import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heh_application/Login%20page/login.dart';
import 'package:heh_application/SignUp%20Page/signup.dart';
import 'package:heh_application/models/login_user.dart';
import 'package:heh_application/models/sign_up_user.dart';
import 'package:heh_application/services/auth.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../Main page/navigation_main.dart';

class CallAPI {

  Future<Widget?> callLoginAPI (LoginUser loginUser, BuildContext context)  async {
        var url = Uri.https('localhost:7166','api/User/Login');
        final body = jsonEncode({"username":loginUser.phone,"password":loginUser.password});
        final headers = {"Accept": "application/json",
          "content-type": "application/json"};
        var response =  await http.post(url,body: body,headers: headers);
        print(response.statusCode);
        if (response.statusCode == 200) {
          // return auth.signInWithEmailAndPassword(loginUser.phone, loginUser.password);
          return Navigator.of(context).push(MaterialPageRoute(
              fullscreenDialog: true,
            builder: (context) => Navigation_Bar(),
          ));
        }
  }
  Future<Widget?> callRegisterAPI (BuildContext context, SignUpUser signUpUser) async {
      var url = Uri.https('localhost:7166','api/User/Register');
      bool gender = true;
      if (signUpUser.gender == 1){
        gender = false;
      }
      final body = jsonEncode({"userName":signUpUser.phone,
      "password":signUpUser.password,
        "email":signUpUser.email,
        "firstName":signUpUser.firstName,
        "lastName":signUpUser.lastName,
        "address":"",
        "dob":signUpUser.dob,
        "phoneNumber":signUpUser.phone,
        "gender": gender,
        "bookingStatus":false,
        "banStatus":false,
        "address":"a"
      });
      final headers = {"Accept": "application/json",
        "content-type": "application/json"};
      var response = await http.post(url,body: body,headers: headers);
      print(response.statusCode);
      if (response.statusCode == 200) {

        return Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginPage()));
      }
      else if (response.statusCode == 400) {

        // print('Error: ${user['Failed']}');
        print(response.body);
        return SignUpPage();
      }

  }


}