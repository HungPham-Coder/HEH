import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PhysioRegisterSlotPage extends StatefulWidget {
  const PhysioRegisterSlotPage({Key? key}) : super(key: key);

  @override
  State<PhysioRegisterSlotPage> createState() => _PhysioRegisterSlotPageState();
}

class _PhysioRegisterSlotPageState extends State<PhysioRegisterSlotPage> {
  bool check = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Đăng ký thời gian làm việc ",
          style: TextStyle(fontSize: 20),
        ),
        elevation: 10,
        backgroundColor: const Color.fromARGB(255, 46, 161, 226),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            chooseTime(),
            const button(),
            const SizedBox(height: 10),
            if (check == true)
              Visibility(
                  child: Column(
                children: [
                  const Text("Danh sách thời gian làm việc",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
                  RegisterMenu(
                    icon:
                        "https://firebasestorage.googleapis.com/v0/b/healthcaresystem-98b8d.appspot.com/o/icon%2Fregisterd.png?alt=media&token=0b0eba33-ef11-44b4-a943-5b5b9b936cfe",
                    name: "Slot 1",
                    time: "Khung giờ: 11:00 - 12:00",
                    amount: "Số lượng đăng ký: 50",
                    press: () {
                      Navigator.push(
                          context,
                          DialogRoute(
                              context: context,
                              builder: (context) => dialog(text: "")));
                    },
                  ),
                ],
              )),
          ],
        ),
      ),
    );
  }
}

class chooseTime extends StatelessWidget {
  chooseTime({Key? key}) : super(key: key);

  final TextEditingController _date = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
            children: const [
              Text("Chọn thời gian làm việc"),
              Text(
                " *",
                style: TextStyle(color: Colors.red),
              )
            ],
          ),
          // SizedBox(height: 5),
          TextFormField(
            // initialValue: dob,
            // DateTime.parse(sharedCurrentUser!.dob as String).toString(),
            readOnly: true,
            controller: _date,
            decoration: const InputDecoration(
              labelText: "Chọn ngày",
            ),
            onTap: () async {
              DateTime? pickeddate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2023),
                  lastDate: DateTime(2999));
              if (pickeddate != null) {
                _date.text = DateFormat('dd-MM-yyyy').format(pickeddate);
              }
            },
          ),
        ],
      ),
    );
  }
}

class button extends StatefulWidget {
  const button({Key? key}) : super(key: key);

  @override
  State<button> createState() => _buttonState();
}

class _buttonState extends State<button> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          style: ButtonStyle(
              backgroundColor: const MaterialStatePropertyAll(
                  Color.fromARGB(255, 46, 161, 226)),
              padding: MaterialStateProperty.all(const EdgeInsets.all(15)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: const BorderSide(color: Colors.white)),
              )),
          onPressed: () {},
          child: const Text("Tìm kiếm",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
        ),
      ],
    );
  }
}

class RegisterMenu extends StatelessWidget {
  const RegisterMenu({
    Key? key,
    required this.name,
    required this.time,
    required this.amount,
    required this.icon,
    required this.press,
  }) : super(key: key);

  final String icon, name, time, amount;
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
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                            const SizedBox(height: 5),
                            Text(
                              time,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            Text(
                              amount,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        )),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Icon(Icons.add, size: 30),
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
      title: const Text('Bạn muốn đăng ký?'),
      actions: <Widget>[
        TextButton(
          child: const Text('Hủy'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text('Đồng ý'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
