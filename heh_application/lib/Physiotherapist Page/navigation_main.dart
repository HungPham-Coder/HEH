import 'package:flutter/material.dart';
import 'package:heh_application/Login%20page/landing_page.dart';
import 'package:heh_application/Physiotherapist%20Page/Physio%20page/Feature%20page/feature.dart';

import 'package:heh_application/Physiotherapist%20Page/Physio%20page/home.dart';
import 'package:heh_application/Physiotherapist%20Page/Physio%20page/notification.dart';
import 'package:heh_application/Physiotherapist%20Page/Profile%20page/setting.dart';
import 'package:heh_application/models/medical_record.dart';
import 'package:heh_application/services/call_api.dart';

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
    const FeaturePage(),
    const NotificationPage(),
    const PhysioSettingPage(),
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
          items: <BottomNavigationBarItem>[
            const BottomNavigationBarItem(
                icon: Icon(Icons.home), label: "Trang chủ"),
            const BottomNavigationBarItem(
                icon: Icon(Icons.featured_play_list), label: "Tính năng"),
            BottomNavigationBarItem(
                icon: Stack(children: const [
                  Badge(
                    child: Icon(Icons.notifications),
                    smallSize: 7,
                  )
                ]),
                label: "Thông báo"),
            const BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: "Cài đặt"),
          ]),
    );
  }
}
