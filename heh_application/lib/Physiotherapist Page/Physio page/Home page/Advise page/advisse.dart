import 'package:flutter/material.dart';

class AdviseNotificationPage extends StatefulWidget {
  const AdviseNotificationPage({Key? key}) : super(key: key);

  @override
  State<AdviseNotificationPage> createState() => _AdviseNotificationPageState();
}

class _AdviseNotificationPageState extends State<AdviseNotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Tư vấn một buổi",
          style: TextStyle(fontSize: 23),
        ),
        elevation: 10,
        backgroundColor: const Color.fromARGB(255, 46, 161, 226),
      ),
      body: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            children: [
              const SizedBox(height: 20),
              const Center(
                child: Text("Lịch hẹn của người dùng",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: AdviseChooseMenu(
                  icon:
                      "https://firebasestorage.googleapis.com/v0/b/healthcaresystem-98b8d.appspot.com/o/icon%2Fbooking.png?alt=media&token=aa78656d-2651-42a4-810e-07c273cdfe5a",
                  name: "Phạm Phú Minh Hưng",
                  time: "Khung giờ: ",
                  press: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => dialog(
                              text: "Bạn có lịch hẹn",
                            ));
                  },
                ),
              ),
            ],
          ),
        ],
      )),
    );
  }
}

class AdviseChooseMenu extends StatelessWidget {
  const AdviseChooseMenu({
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
                        width: MediaQuery.of(context).size.width / 1.65,
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
                            const SizedBox(height: 10),
                          ],
                        )),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child:
                          Icon(Icons.notifications_active_outlined, size: 30),
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}

class dialog extends StatelessWidget {
  dialog({
    Key? key,
    required this.text,
  }) : super(key: key);

  String text;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Bạn có lịch hẹn'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(text),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Hủy'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text('Xem chi tiết'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
