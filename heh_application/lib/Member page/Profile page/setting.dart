import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:heh_application/Member%20page/Profile%20page/Personal%20page/personal.dart';
import 'package:heh_application/Member%20page/Profile%20page/changePass.dart';
import 'package:heh_application/Member%20page/history.dart';

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
                const CircleAvatar(
                  backgroundColor: Color.fromARGB(255, 220, 220, 220),
                  backgroundImage: AssetImage("assets/icons/person.png"),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          const Text("ABC", style: TextStyle(fontSize: 30)),
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
            icon: "assets/icons/person.svg",
            text: "Thông tin của bạn",
            press: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PersonalPage()));
            },
          ),
          ProfileMenu(
            icon: "assets/icons/family.svg",
            text: "Thành viên gia đình",
            press: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const FamilyPage()));
            },
          ),
          ProfileMenu(
            icon: "assets/icons/history.svg",
            text: "Lịch sử giao dịch",
            press: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HistoryPage()));
            },
          ),
          ProfileMenu(
            icon: "assets/icons/history.svg",
            text: "Đặt lại mật khẩu",
            press: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ChangePassword()));
            },
          ),
          ProfileMenu(
            icon: "assets/icons/logout.svg",
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
              SvgPicture.asset(
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
