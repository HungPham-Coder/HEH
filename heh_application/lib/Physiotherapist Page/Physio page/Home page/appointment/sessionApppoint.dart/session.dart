import 'package:flutter/material.dart';

class SessionAppointmentPage extends StatefulWidget {
  const SessionAppointmentPage({Key? key}) : super(key: key);

  @override
  State<SessionAppointmentPage> createState() => _SessionAppointmentPageState();
}

class _SessionAppointmentPageState extends State<SessionAppointmentPage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
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