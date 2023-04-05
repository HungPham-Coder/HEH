import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:heh_application/Physiotherapist%20Page/Physio%20page/home.dart';
import 'package:heh_application/Physiotherapist%20Page/Physio%20page/Profile%20Page/setting.dart';
import 'package:heh_application/Physiotherapist%20Page/messenger.dart';

// ignore: camel_case_types
class PhyNavigation_bar extends StatefulWidget {
  const PhyNavigation_bar({Key? key}) : super(key: key);

  @override
  State<PhyNavigation_bar> createState() => _PhyNavigation_barState();
}

// ignore: camel_case_types
class _PhyNavigation_barState extends State<PhyNavigation_bar> {
  int pageIndex = 0;
  List<Widget> pageList = <Widget>[
    const PhysioHomePage(),
    const PhysioMessenger(),
    const PhysioSettingPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: pageIndex, children: pageList),
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
                icon: SvgPicture.asset("assets/icons/message.svg",
                    width: 25, height: 25),
                activeIcon: SvgPicture.asset("assets/icons/message.svg",
                    width: 25, height: 25, color: Colors.white),
                label: "Tin nhắn"),
            const BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: "Cài đặt"),
          ]),
    );
  }
}
