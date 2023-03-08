import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:heh_application/services/auth.dart';
import 'package:http/http.dart' as http;

import '../Main page/navigation_main.dart';

class CallAPI {

  Future<void> callAPILogin (String phone, String password, AuthBase authBase)  async {

        var url = Uri.https('localhost:7166','api/User');
        var response =  await http.get(url);
        if (response.statusCode == 200) {
          print(response.headers);
          print(response.body);
        }
        // final response = await client.post(Uri.https('10.0.2.2:7166','api/User/Login'),
        //     body:{'username':'0367302912','password':'1234567890'} );
        // print('Response status : ${response.statusCode}');
        // print('Response body : ${response.body}');
        // return http.get(Uri.https('10.0.2.2:7166','/api/User'));

        // final response =  await client.get(Uri.parse("http://127.0.0.1:7166/api/User"));
        // final response =await client.get('localhost',7166,'/api/User');
        // final response1 = await response.close();
        // print('${response1.statusCode} ab');

        print(' ab');
        // return response;
        // print('Response status : ${response.statusCode}');
        // print('Response body : ${response.body}');
        // if (response.statusCode == 200) {
        //
        //  // Future<User?> user =  authBase.signInWithPhoneAndPassword(phone, password);
        //  // print(user);
        //     // return LoginUser.fromJson(jsonDecode(response.body));
        //   }
        // else {
        //   print('status 400');
        // }


  }


}