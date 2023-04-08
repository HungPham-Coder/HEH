import 'package:flutter/material.dart';
import 'package:heh_application/Member%20page/Service%20Page/Payment%20page/payment.dart';

class ChooseDetailpage extends StatefulWidget {
  const ChooseDetailpage({Key? key}) : super(key: key);

  @override
  State<ChooseDetailpage> createState() => _ChooseDetailpageState();
}

class _ChooseDetailpageState extends State<ChooseDetailpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Chọn khung giờ",
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
            const PhysioProfile(
              image:
                  "https://firebasestorage.googleapis.com/v0/b/healthcaresystem-98b8d.appspot.com/o/icon%2Fphy.png?alt=media&token=bac867bc-190c-4523-83ba-86fccc649622",
              phy: "Chuyên viên",
              name: "Phạm Phú Minh Hưng",
              specialize: "Chuyên môn: PHCN thần kinh cơ.",
              experience:
                  "Kinh nghiệm: Có khả năng giao tiếp, ngoại hình tốt.",
            ),
            const SizedBox(height: 20),
            Center(
                child: Text("Khung giờ",
                    style: Theme.of(context).textTheme.headline6)),
            const SizedBox(height: 5),
            PhysioChooseMenu(
              icon:
                  "https://firebasestorage.googleapis.com/v0/b/healthcaresystem-98b8d.appspot.com/o/icon%2Fphy.png?alt=media&token=bac867bc-190c-4523-83ba-86fccc649622",
              name: "Slot 1",
              time: "Khung giờ: 10:00 AM - 11:00 AM",
              press: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PaymentPage()));
              },
            ),
          ],
        ),
      ),
    );
  }
}

class PhysioProfile extends StatelessWidget {
  const PhysioProfile({
    Key? key,
    required this.image,
    required this.phy,
    required this.name,
    required this.specialize,
    required this.experience,
  }) : super(key: key);

  final String image, specialize, experience, name, phy;

  @override
  Widget build(BuildContext context) {
    // ignore: duplicate_ignore
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.black)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: SizedBox(
                        height: 100,
                        width: 100,
                        child: Stack(
                          clipBehavior: Clip.none,
                          fit: StackFit.expand,
                          children: const [
                            CircleAvatar(
                                backgroundImage: NetworkImage(
                                    "https://firebasestorage.googleapis.com/v0/b/healthcaresystem-98b8d.appspot.com/o/icon%2Fphy.png?alt=media&token=bac867bc-190c-4523-83ba-86fccc649622")),
                          ],
                        )),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    children: [
                      Text(
                        phy,
                        style: const TextStyle(fontSize: 15),
                      ),
                      Text(name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          )),
                    ],
                  ),
                ],
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      Text(specialize),
                      const SizedBox(height: 20),
                      Text(experience),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

class PhysioChooseMenu extends StatelessWidget {
  const PhysioChooseMenu({
    Key? key,
    required this.time,
    required this.name,
    required this.icon,
    required this.press,
  }) : super(key: key);

  final String icon, name, time;
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
                    const SizedBox(width: 10),
                    SizedBox(
                        width: MediaQuery.of(context).size.width / 1.6,
                        height: 50,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              time,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        )),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Icon(Icons.add, size: 24),
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
