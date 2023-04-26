import 'package:flutter/material.dart';

import 'package:heh_application/Member%20page/Exercise%20Page/category.dart';
import 'package:heh_application/Member%20page/Home%20page/Paid%20page/servicePaid.dart';
import 'package:heh_application/Member%20page/email.dart';

import '../../Welcome page/welcome_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  Future<bool> _onWillPop(BuildContext context) async {
    bool? exitResult = await showDialog(
      context: context,
      builder: (context) => _buildExitDialog(context),
    );
    return exitResult ?? false;
  }

  Future<bool?> _showExitDialog(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) => _buildExitDialog(context),
    );
  }

  AlertDialog _buildExitDialog(BuildContext context) {
    return AlertDialog(
      title: const Text('Đăng xuất?'),
      content: const Text('Ban có muốn đăng xuất?'),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('Không'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text('Có'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () => _onWillPop(context),
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Text(
              "Trang chủ",
              style: TextStyle(fontSize: 23),
            ),
            elevation: 10,
            backgroundColor: const Color.fromARGB(255, 46, 161, 226),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                const Center(
                  child: Text("Chào mừng đến với HEH",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      )),
                ),
                const Center(
                  child: Text(
                      "'Trải nghiệm của bạn cũng là trải nghiệm của chúng tôi!'",
                      style:
                          TextStyle(fontSize: 13, fontStyle: FontStyle.italic)),
                ),
                HomeMenu(
                  icon:
                      "https://firebasestorage.googleapis.com/v0/b/healthcaresystem-98b8d.appspot.com/o/icon%2Fexercise.png?alt=media&token=f299c936-6f81-41e5-8448-bc587873bc67",
                  text: "Bài tập trị liệu",
                  press: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CategoryPage()));
                  },
                ),
                HomeMenu(
                  icon:
                      "https://firebasestorage.googleapis.com/v0/b/healthcaresystem-98b8d.appspot.com/o/icon%2Fregisterd.png?alt=media&token=0b0eba33-ef11-44b4-a943-5b5b9b936cfe",
                  text: "Dịch vụ đã đăng ký",
                  press: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ServicePaidPage()));
                  },
                ),
                // HomeMenu(
                //   icon:
                //       "https://firebasestorage.googleapis.com/v0/b/healthcaresystem-98b8d.appspot.com/o/icon%2Fregisterd.png?alt=media&token=0b0eba33-ef11-44b4-a943-5b5b9b936cfe",
                //   text: "Welcome page",
                //   press: () {
                //     Navigator.push(context,
                //         MaterialPageRoute(builder: (context) => WelcomePage()));
                //   },
                // ),
                HomeMenu(
                  icon:
                      "https://firebasestorage.googleapis.com/v0/b/healthcaresystem-98b8d.appspot.com/o/icon%2Fregisterd.png?alt=media&token=0b0eba33-ef11-44b4-a943-5b5b9b936cfe",
                  text: "Email page",
                  press: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Email()));
                  },
                ),
              ],
            ),
          ),
        ));
  }
}

class HomeMenu extends StatelessWidget {
  HomeMenu({
    Key? key,
    required this.text,
    required this.icon,
    required this.press,
  }) : super(key: key);

  final String text, icon;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
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
              Image.network(
                icon,
                width: 60,
                height: 60,
              ),
              const SizedBox(
                width: 20,
                height: 10,
              ),
              Expanded(
                  child: Text(
                text,
                style: Theme.of(context).textTheme.titleMedium,
              )),
              const Icon(Icons.arrow_forward_sharp),
            ],
          )),
    );
  }
}
