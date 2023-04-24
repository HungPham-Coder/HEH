import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:heh_application/Login%20page/landing_page.dart';
import 'package:heh_application/Member%20page/Home%20page/favorite.dart';
import 'package:heh_application/Member%20page/Home%20page/home.dart';
import 'package:heh_application/Member%20page/Profile%20page/setting.dart';
import 'package:heh_application/Member%20page/Service%20Page/service.dart';
import 'package:heh_application/models/medical_record.dart';
import 'package:heh_application/services/call_api.dart';

import '../models/sign_up_user.dart';

// ignore: camel_case_types
class Navigation_Bar extends StatefulWidget {
  Navigation_Bar({
    Key? key,
  }) : super(key: key);

  @override
  State<Navigation_Bar> createState() => _Navigation_BarState();
}

// ignore: camel_case_types
class _Navigation_BarState extends State<Navigation_Bar> {
  SignUpUser? signUpUser;

  @override
  void initState() {
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder <MedicalRecord?>(
        future: CallAPI().getMedicalRecordByUserIDAndRelationName(sharedCurrentUser!.userID!),
          builder: (context, snapshot) {
          if (snapshot.hasData){
            sharedMedicalRecord = snapshot.data! ;
            return pageList[pageIndex];
          }
          else {
            return Container();
          }

          }
      ),
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
                icon: SvgPicture.network(
                    "https://firebasestorage.googleapis.com/v0/b/healthcaresystem-98b8d.appspot.com/o/icon%2Fphysiotherapist.svg?alt=media&token=59cf906d-e05a-49a4-910f-f06720527a08",
                    width: 25,
                    height: 25),
                activeIcon: SvgPicture.network(
                    "https://firebasestorage.googleapis.com/v0/b/healthcaresystem-98b8d.appspot.com/o/icon%2Fphysiotherapist.svg?alt=media&token=59cf906d-e05a-49a4-910f-f06720527a08",
                    width: 25,
                    height: 25,
                    color: Colors.white),
                label: "Dịch vụ"),
            BottomNavigationBarItem(
                icon: SvgPicture.network(
                    "https://firebasestorage.googleapis.com/v0/b/healthcaresystem-98b8d.appspot.com/o/icon%2Ffavorite.svg?alt=media&token=6cfd2de1-ce36-405d-9622-84935fbc7606",
                    width: 25,
                    height: 25),
                activeIcon: Image.network(
                    "https://firebasestorage.googleapis.com/v0/b/healthcaresystem-98b8d.appspot.com/o/icon%2Ffavorited.png?alt=media&token=43a91ace-f9c8-40dc-a0b1-9fdadbaa00a9",
                    width: 25,
                    height: 25),
                label: "Yêu thích"),
            const BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: "Cài đặt"),
          ]),
    );
  }
}
