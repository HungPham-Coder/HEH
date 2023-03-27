import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:heh_application/Member%20page/Home%20page/favorite.dart';
import 'package:heh_application/Member%20page/Home%20page/home.dart';
import 'package:heh_application/Member%20page/messenger.dart';
import 'package:heh_application/Member%20page/Profile%20page/setting.dart';
import 'package:heh_application/Member%20page/Physiotherapist%20MainPage/physiotherapist.dart';

// ignore: camel_case_types
class Navigation_Bar extends StatefulWidget {
  const Navigation_Bar({Key? key}) : super(key: key);

  @override
  State<Navigation_Bar> createState() => _Navigation_BarState();
}

// ignore: camel_case_types
class _Navigation_BarState extends State<Navigation_Bar> {
  int pageIndex = 0;
  List<Widget> pageList = <Widget>[
    const HomePage(),
    const Physiotherapist(),
    const FavoritePage(),
    const SettingPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pageList[pageIndex],
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: const Color.fromARGB(255, 46, 161, 226),
          fixedColor: Colors.white,
          currentIndex: pageIndex,
          onTap: (value) {
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
