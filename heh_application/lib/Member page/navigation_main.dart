import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:heh_application/Member%20page/Home%20page/favorite.dart';
import 'package:heh_application/Member%20page/Home%20page/home.dart';
import 'package:heh_application/Member%20page/Profile%20page/setting.dart';
import 'package:heh_application/Member%20page/Physiotherapist%20MainPage/physiotherapist.dart';
import 'package:heh_application/models/result_login.dart';
import 'package:heh_application/services/auth.dart';
import 'package:heh_application/services/call_api.dart';
import 'package:heh_application/services/stream_test.dart';
import 'package:provider/provider.dart';

import '../models/sign_up_user.dart';

// ignore: camel_case_types
class Navigation_Bar extends StatefulWidget {
   Navigation_Bar({Key? key, }) : super(key: key);

  @override
  State<Navigation_Bar> createState() => _Navigation_BarState();
}

// ignore: camel_case_types
class _Navigation_BarState extends State<Navigation_Bar>  {
  SignUpUser? signUpUser ;


  @override
  void initState()  {
    // TODO: implement initState
    super.initState();
    // final auth = Provider.of<AuthBase>(context, listen: false);
    // auth.userSignUpStream.listen((event) {
    //   print('${event.firstName} navigation sign up 1');
    // });
  }

  @override
  void dispose() {
    // TODO: implement dispose


    super.dispose();

  }

  int pageIndex = 0;
  List<Widget> pageList = <Widget>[
    const HomePage(),
    const Physiotherapist(),
    const FavoritePage(),
    const SettingPage(),
  ];



  @override
  Widget build(BuildContext context)  {





    return Scaffold(
      body: pageList[pageIndex],
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: const Color.fromARGB(255, 46, 161, 226),
          fixedColor: Colors.white,
          currentIndex: pageIndex,
          onTap: (value) async {
            setState(() {
              pageIndex = value;
            });
          },
          type: BottomNavigationBarType.fixed,
          items: [
            const BottomNavigationBarItem(
                icon: Icon(Icons.home), label: "Trang chủ"),
            BottomNavigationBarItem(
                icon: SvgPicture.asset("assets/icons/physiotherapist.svg",
                    width: 25, height: 25),
                activeIcon: SvgPicture.asset("assets/icons/physiotherapist.svg",
                    width: 25, height: 25, color: Colors.white),
                label: "Chuyên viên"),
            BottomNavigationBarItem(
                icon: SvgPicture.asset("assets/icons/favorite.svg",
                    width: 25, height: 25),
                activeIcon: Image.asset("assets/icons/favorited.png",
                    width: 25, height: 25),
                label: "Yêu thích"),
            const BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: "Cài đặt"),
          ]),
    );
  }
}
