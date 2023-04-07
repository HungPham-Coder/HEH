import 'package:flutter/material.dart';
import 'package:heh_application/Member%20page/Service%20Page/Advise%20page/chooseDetail.dart';

class PhysioChoosePage extends StatefulWidget {
  const PhysioChoosePage({Key? key}) : super(key: key);

  @override
  State<PhysioChoosePage> createState() => _PhysioChoosePageState();
}

class _PhysioChoosePageState extends State<PhysioChoosePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Chọn chuyên viên",
          style: TextStyle(fontSize: 23),
        ),
        elevation: 10,
        backgroundColor: const Color.fromARGB(255, 46, 161, 226),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Category(category: "Đau lưng"),
            PhysioChooseMenu(
              icon:
                  "https://firebasestorage.googleapis.com/v0/b/healthcaresystem-98b8d.appspot.com/o/icon%2Fphy.png?alt=media&token=bac867bc-190c-4523-83ba-86fccc649622",
              name: "Phạm Phú Minh Hưng",
              time: "Khung giờ: ",
              during: "10:00 AM - 12:00 AM",
              press: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ChooseDetailpage()));
              },
            ),
          ],
        ),
      ),
    );
  }
}

class Category extends StatelessWidget {
  const Category({
    Key? key,
    required this.category,
  }) : super(key: key);

  final String category;

  @override
  Widget build(BuildContext context) {
    // ignore: duplicate_ignore
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(category,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w900,
            color: Color.fromARGB(255, 106, 97, 201),
          )),
    );
  }
}

class PhysioChooseMenu extends StatelessWidget {
  const PhysioChooseMenu({
    Key? key,
    required this.time,
    required this.during,
    required this.name,
    required this.icon,
    required this.press,
  }) : super(key: key);

  final String during, icon, name, time;
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    // ignore: duplicate_ignore
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: TextButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 15)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: const BorderSide(
                              color: Color.fromARGB(255, 46, 161, 226),
                              width: 2)),
                    )),
                onPressed: press,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.network(
                      icon,
                      width: 40,
                      height: 50,
                    ),
                    const SizedBox(width: 12),
                    SizedBox(
                        width: MediaQuery.of(context).size.width / 1.55,
                        height: 50,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                name,
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ),
                            Row(children: [
                              Text(
                                time,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              Text(
                                during,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ]),
                          ],
                        )),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Icon(Icons.arrow_forward_ios_rounded),
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
