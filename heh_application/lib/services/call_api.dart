import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:heh_application/services/auth.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../Main page/navigation_main.dart';

class CallAPI {

  Future<User?> callLoginAPI (String phone, String password, AuthBase authBase, BuildContext context)  async {
        final auth = Provider.of<AuthBase>(context,listen: false);
        var url = Uri.https('localhost:7166','api/User/Login');
        final body = jsonEncode({"username":phone,"password":password});
        var response =  await http.post(url,body: body,headers: {
          "Accept": "application/json",
          "content-type": "application/json"
        });
        print(response.statusCode);
        if (response.statusCode == 200) {
          return auth.signInWithEmailAndPassword(phone, password);
        }
  }


}