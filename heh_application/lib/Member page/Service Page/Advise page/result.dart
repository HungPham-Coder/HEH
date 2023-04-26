import 'package:flutter/material.dart';
import 'package:heh_application/Member%20page/Service%20Page/Payment%20page/billTime.dart';

class TimeResultPage extends StatefulWidget {
  const TimeResultPage({Key? key}) : super(key: key);

  @override
  State<TimeResultPage> createState() => _TimeResultPageState();
}

class _TimeResultPageState extends State<TimeResultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            "Kết quả tìm kiếm",
            style: TextStyle(fontSize: 23),
          ),
          elevation: 10,
          backgroundColor: const Color.fromARGB(255, 46, 161, 226),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    CurrentTime(),
                    PhysioChooseMenu(
                      icon:
                          "https://firebasestorage.googleapis.com/v0/b/healthcaresystem-98b8d.appspot.com/o/icon%2Fphy.png?alt=media&token=bac867bc-190c-4523-83ba-86fccc649622",
                      name: "Phạm Phú Minh Hưng",
                      time: "Khung giờ: 6:00 - 7:00",
                      press: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const BillTimePage()));
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
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
    return Column(
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
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 15)),
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
                  const SizedBox(width: 5),
                  SizedBox(
                      width: MediaQuery.of(context).size.width / 1.6,
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
                    child: Icon(Icons.arrow_forward_ios_rounded),
                  ),
                ],
              )),
        ),
      ],
    );
  }
}

class CurrentTime extends StatelessWidget {
  CurrentTime({Key? key}) : super(key: key);

  final TextEditingController _date = TextEditingController();

  String getCurrentDate() {
    var date = DateTime.now().toString();

    var dateParse = DateTime.parse(date);

    var formattedDate =
        "Ngày ${dateParse.day} Tháng ${dateParse.month} Năm ${dateParse.year}";
    return formattedDate.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(getCurrentDate(), style: const TextStyle(fontSize: 20))
        ],
      ),
    );
  }
}
