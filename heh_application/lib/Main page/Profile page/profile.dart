// ignore_for_file: deprecated_member_use



import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../services/auth.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Hồ sơ của bạn",
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
              children: [
                const CircleAvatar(
                  backgroundImage: AssetImage("assets/images/profile.jpg"),
                ),
                Positioned(
                  right: -12,
                  bottom: 0,
                  child: SizedBox(
                    height: 46,
                    width: 46,
                    child: TextButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                const Color(0xfff5f6f9)),
                            padding: MaterialStateProperty.all(EdgeInsets.zero),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  side: const BorderSide(color: Colors.white)),
                            )),
                        onPressed: () {},
                        child: SvgPicture.asset("assets/icons/camera.svg",
                            width: 20, height: 20)),
                  ),
                )
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
            text: "Tài khoản của bạn",
            press: () {},
          ),
          ProfileMenu(
            icon: "assets/icons/history.svg",
            text: "Lịch sử giao dịch",
            press: () {},
          ),
          ProfileMenu(
            icon: "assets/icons/logout.svg",
            text: "Đăng xuất",
            press:() => signout(context),
          ),
        ],
      )),
    );
  }

  void signout  (BuildContext context) async {
    final auth = Provider.of<AuthBase>(context, listen: false);
    await auth.signOut();
    Navigator.of(context).pop();
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
