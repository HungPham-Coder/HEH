import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:heh_application/Login%20page/landing_page.dart';
import 'package:heh_application/Member%20page/Profile%20page/Personal%20page/personal.dart';
import 'package:heh_application/Member%20page/Profile%20page/changePass.dart';

import 'package:heh_application/Member%20page/Profile%20page/history.dart';

import 'package:heh_application/models/sub_profile.dart';
import 'package:heh_application/services/call_api.dart';

import 'package:heh_application/services/stream_test.dart';

import 'package:provider/provider.dart';

import '../../services/auth.dart';
import 'Family page/family.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Cài đặt",
          style: TextStyle(fontSize: 23),
        ),
        centerTitle: true,
        elevation: 10,
        backgroundColor: const Color.fromARGB(255, 46, 161, 226),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          const SizedBox(height: 20),
          SizedBox(
            height: 115,
            width: 115,
            child: Stack(
              clipBehavior: Clip.none,
              fit: StackFit.expand,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                CircleAvatar(
                  backgroundImage:
                      NetworkImage(sharedCurrentUser!.image.toString()),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Text(sharedCurrentUser!.firstName.toString(),
              style: const TextStyle(fontSize: 30)),
          const SizedBox(height: 20),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 90),
          //   child: Row(
          //     children: const <Widget>[
          //       Text("Số dư TK: 123,456.78đ "),
          //       Icon(
          //         Icons.add_circle_outline_rounded,
          //       ),
          //     ],
          //   ),
          // ),
          ProfileMenu(
            icon:
                "https://firebasestorage.googleapis.com/v0/b/healthcaresystem-98b8d.appspot.com/o/icon%2Fperson.svg?alt=media&token=7bef043d-fdb5-4c5b-bb2e-644ee7682345",
            text: "Thông tin của bạn",
            press: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PersonalPage()));
            },
          ),
          ProfileMenu(
            icon:
                "https://firebasestorage.googleapis.com/v0/b/healthcaresystem-98b8d.appspot.com/o/icon%2Ffamily.svg?alt=media&token=f6f01b99-6901-48be-9a69-798ea594bd77",
            text: "Thành viên gia đình",
            press: () async {
              List<SubProfile>? listSubProfile = await CallAPI()
                  .getallSubProfileByUserId(sharedCurrentUser!.userID!);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FamilyPage(
                            listSubProfile: listSubProfile,
                          )));
            },
          ),
          ProfileMenu(
            icon:
                "https://firebasestorage.googleapis.com/v0/b/healthcaresystem-98b8d.appspot.com/o/icon%2Fhistory.svg?alt=media&token=13ed285f-0a27-4ee5-b984-bd73d5f15ac8",
            text: "Lịch sử giao dịch",
            press: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HistoryPage()));
            },
          ),
          ProfileMenu(
            icon:
                "https://firebasestorage.googleapis.com/v0/b/healthcaresystem-98b8d.appspot.com/o/icon%2Freset.svg?alt=media&token=f574651a-977a-4eea-a07d-61fe296f5505",
            text: "Đặt lại mật khẩu",
            press: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ChangePassword()));
            },
          ),
          ProfileMenu(
            icon:
                "https://firebasestorage.googleapis.com/v0/b/healthcaresystem-98b8d.appspot.com/o/icon%2Flogout.svg?alt=media&token=99ed3d5a-ec73-4a07-ac6f-2197f26829ef",
            text: "Đăng xuất",
            press: signout,
          ),
        ],
      )),
    );
  }

  void signout() async {
    final stream = StreamTest.instance;
    final auth = Provider.of<AuthBase>(context, listen: false);
    await stream.handleLogout();
    await auth.signOut(context);
  }
}

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key? key,
    required this.text,
    required this.icon,
    required this.press,
  }) : super(key: key);

  final String text, icon;
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    // ignore: duplicate_ignore
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextButton(
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(const Color(0xfff5f6f9)),
              padding: MaterialStateProperty.all(const EdgeInsets.all(15)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: const BorderSide(color: Colors.white)),
              )),
          onPressed: press,
          child: Row(
            children: [
              SvgPicture.network(
                icon,
                width: 30,
                color: const Color.fromARGB(255, 46, 161, 226),
              ),
              const SizedBox(
                width: 20,
                height: 10,
              ),
              Expanded(
                  child: Text(
                text,
                style: Theme.of(context).textTheme.bodyText1,
              )),
              const Icon(Icons.arrow_forward_ios_rounded),
            ],
          )),
    );
  }
}
