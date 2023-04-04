import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heh_application/Login%20page/login.dart';
import 'package:heh_application/SignUp%20Page/signup.dart';
import 'package:heh_application/models/login_user.dart';
import 'package:heh_application/models/result_login.dart';
import 'package:heh_application/models/sign_up_user.dart';
import 'package:http/http.dart' as http;


import '../Member page/navigation_main.dart';
import '../models/role.dart';

class CallAPI {
  Future<ResultLogin?> callLoginAPI (LoginUser loginUser)  async {
    var url = Uri.https('localhost:7166','api/User/Login');
    final body = jsonEncode({"phoneNumber":loginUser.phone,"password":loginUser.password});
    final headers = {"Accept": "application/json",
      "content-type": "application/json",};
    var response =  await http.post(url,body: body,headers: headers);

    print(response.statusCode);
    if (response.statusCode == 200) {
      // return auth.signInWithEmailAndPassword(loginUser.phone, loginUser.password);
      Map<String,dynamic> responseBody = json.decode(response.body);
      Map<String,dynamic> result = responseBody["result"];
      print(result["access_token"]);
      final headers = {"Content-Type": "application/json",
        "Authorization": "Bearer ${result["access_token"]}",};
      var response1 = await http.get(url,headers: headers).then((value) => print(value.body));


      return ResultLogin.fromMap(result);
    }
  }
  Future<bool> callRegisterAPI ( SignUpUser signUpUser) async {
    var url = Uri.https('localhost:7166','api/User/Register');

    final body = jsonEncode({"userName":signUpUser.phone,
      "password":signUpUser.password,
      "email":signUpUser.email,
      "firstName":signUpUser.firstName,
      "lastName":signUpUser.lastName,
      "address":signUpUser.address,
      "image" : signUpUser.image,
      "dob":signUpUser.dob,
      "phoneNumber":signUpUser.phone,
      "gender": signUpUser.gender,
      "bookingStatus":false,
      "banStatus":false,
    });
    final headers = {"Accept": "application/json",
      "content-type": "application/json"};
    var response = await http.post(url,body: body,headers: headers);
    print(response.statusCode);

    if (response.statusCode == 200) {


      return true;
    }
    else  {

      print(response.body);

      return false;
    }

  }

  Future<SignUpUser?> getUserByEmail (String email) async {
    var url = Uri.https('localhost:7166','api/User/$email');
    final headers = {"Accept": "application/json",
      "content-type": "application/json"};
    var response = await http.get(url,headers: headers);


    if (response.statusCode == 200){

      return SignUpUser.fromMap(json.decode(response.body),'');
    }
    else {

      print(response.statusCode);
      return null;
    }

  }
  Future<SignUpUser?> getUserById (String id) async {
    var url = Uri.https('localhost:7166','api/User/getById/$id');
    final headers = {"Accept": "application/json",
      "content-type": "application/json"};
    var response = await http.get(url,headers: headers);

    print('StatusCode: ${response.statusCode}');
    if (response.statusCode == 200){
      return SignUpUser.fromMap(json.decode(response.body),'');
    }
    else {
      print("response body");
      print(response.statusCode);
      return null;
    }

  }

  Future<Role?> getUserRole (String userId) async {
    var url = Uri.https('localhost:7166','api/User/getUserRole/$userId');
    final headers = {
      "Accept" : "application/json",
      "content-type" :"application/json"
    };
    var response = await http.get(url,headers: headers);
    if (response.statusCode ==200){
      return Role.fromMap(json.decode(response.body));
    }
    else {
      print("${response.statusCode} getUserRole");
    }
  }


}



