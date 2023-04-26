import 'package:flutter/material.dart';

import 'package:heh_application/Physiotherapist%20Page/Physio%20page/Feature%20page/Register%20slot%20page/register.dart';

class FeaturePage extends StatefulWidget {
  const FeaturePage({Key? key}) : super(key: key);

  @override
  State<FeaturePage> createState() => _FeaturePageState();
}

class _FeaturePageState extends State<FeaturePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Tính năng",
          style: TextStyle(fontSize: 23),
        ),
        elevation: 10,
        backgroundColor: const Color.fromARGB(255, 46, 161, 226),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FeatureMenu(
              icon:
                  "https://firebasestorage.googleapis.com/v0/b/healthcaresystem-98b8d.appspot.com/o/icon%2Fexercise.png?alt=media&token=f9b0b759-2f11-431e-b821-f695bd62e78c",
              text: "Bài tập trị liệu",
              press: () {
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => const CategoryPage()));
              },
            ),
            FeatureMenu(
              icon:
                  "https://firebasestorage.googleapis.com/v0/b/healthcaresystem-98b8d.appspot.com/o/icon%2Fcalendar.png?alt=media&token=45426216-f7a3-449b-8a91-05582ebc1339",
              text: "Đăng ký lịch làm việc",
              press: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PhysioRegisterSlotPage()));
              },
            ),
          ],
        ),
      ),
    );
  }
}

class FeatureMenu extends StatelessWidget {
  const FeatureMenu({
    Key? key,
    required this.text,
    required this.icon,
    required this.press,
  }) : super(key: key);

  final String text, icon;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    // ignore: duplicate_ignore
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
