import 'package:flutter/material.dart';
import 'package:heh_application/models/slot.dart';
import 'package:heh_application/services/call_api.dart';
import 'package:intl/intl.dart';

import '../../../../common_widget/dialog.dart';

class PhysioRegisterSlotPage extends StatefulWidget {
  const PhysioRegisterSlotPage({Key? key}) : super(key: key);

  @override
  State<PhysioRegisterSlotPage> createState() => _PhysioRegisterSlotPageState();
}

class _PhysioRegisterSlotPageState extends State<PhysioRegisterSlotPage> {
  bool check = false;
  final TextEditingController _date = TextEditingController();
  List<Slot>? slotList;

  Widget Time() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            // initialValue: dob,
            // DateTime.parse(sharedCurrentUser!.dob as String).toString(),
            readOnly: true,
            controller: _date,
            decoration: const InputDecoration(
              labelText: "Chọn thời gian làm việc",
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

  Widget button() {
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
          onPressed: () async {
            if (_date.text != '') {
              DateTime day = new DateFormat('dd-MM-yyyy').parse(_date.text);
              String dayStr = DateFormat('yyyy-MM-ddTHH:mm:ss').format(day);
              slotList = await CallAPI().getallSlotByDate(dayStr);
              if (slotList!.length > 0) {
                setState(() {
                  check = true;
                });
              } else {
                setState(() {
                  check = false;
                });
              }

              print(check);
            }
          },
          child: const Text("Tìm kiếm",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Đăng ký lịch làm việc",
          style: TextStyle(fontSize: 20),
        ),
        elevation: 10,
        backgroundColor: const Color.fromARGB(255, 46, 161, 226),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Time(),
            button(),
            const SizedBox(height: 10),
            check == false && _date.text != "" && slotList!.length == 0
                ? Container(
                    height: MediaQuery.of(context).size.height / 4,
                    alignment: Alignment.bottomCenter,
                    child: const Text(
                      "Hiện tại không có slot để đăng ký.",
                      style: TextStyle(fontSize: 18),
                    ),
                  )
                : (_date.text != "" && slotList != null)
                    ? Visibility(
                        visible: check,
                        child: Column(
                          children: [
                            const Text("Danh sách thời gian làm việc",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 16)),
                            ListView.builder(
                                shrinkWrap: true,
                                itemCount: slotList!.length,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  DateTime startTime =
                                      new DateFormat('yyyy-MM-ddTHH:mm:ss')
                                          .parse(slotList![index].timeStart);
                                  String start =
                                      DateFormat('HH:mm').format(startTime);
                                  DateTime endTime =
                                      new DateFormat('yyyy-MM-ddTHH:mm:ss')
                                          .parse(slotList![index].timeEnd);
                                  String end =
                                      DateFormat('HH:mm').format(endTime);

                                  return FutureBuilder(
                                      future: CallAPI()
                                          .getNumberOfPhysioRegisterOnSlot(
                                              slotList![index].slotID),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          if (slotList![index].available ==
                                              true) {
                                            return RegisterMenu(
                                              icon:
                                                  "https://firebasestorage.googleapis.com/v0/b/healthcaresystem-98b8d.appspot.com/o/icon%2Fregisterd.png?alt=media&token=0b0eba33-ef11-44b4-a943-5b5b9b936cfe",
                                              name:
                                                  "${slotList![index].slotName}",
                                              time: "Khung giờ: $start - $end",
                                              full: "",
                                              choose: false,
                                              amount:
                                                  "Số lượng đăng ký: ${snapshot.data}",
                                              press: () {
                                                Navigator.push(
                                                    context,
                                                    DialogRoute(
                                                        context: context,
                                                        builder: (context) =>
                                                            dialog(
                                                              text:
                                                                  "Chọn thời gian làm việc",
                                                              des:
                                                                  "Yêu cầu của bạn đến quản lý",
                                                            )));
                                              },
                                            );
                                          } else {
                                            return RegisterMenu(
                                                icon:
                                                    "https://firebasestorage.googleapis.com/v0/b/healthcaresystem-98b8d.appspot.com/o/icon%2Fregisterd.png?alt=media&token=0b0eba33-ef11-44b4-a943-5b5b9b936cfe",
                                                name:
                                                    "${slotList![index].slotName}",
                                                full:
                                                    "Slot này đầy. Vui lòng chọn slot khác.",
                                                choose: true,
                                                time:
                                                    "Khung giờ: $start - $end",
                                                amount:
                                                    "Số lượng đăng ký: ${snapshot.data}",
                                                press: null);
                                          }
                                        } else {
                                          return const Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        }
                                      });
                                  // }
                                })
                          ],
                        ))
                    : Container()
          ],
        ),
      ),
    );
  }
}

class RegisterMenu extends StatelessWidget {
  RegisterMenu({
    Key? key,
    required this.name,
    required this.time,
    required this.amount,
    required this.icon,
    required this.press,
    required this.full,
    required this.choose,
  }) : super(key: key);

  final String icon, name, time, amount, full;
  final VoidCallback? press;
  bool choose;

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
                        width: MediaQuery.of(context).size.width / 1.6,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(name,
                                style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black)),
                            Text(
                              time,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            Text(
                              amount,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            const SizedBox(height: 5),
                            Visibility(
                              visible: choose,
                              child: Text(
                                full,
                                style: const TextStyle(
                                    color: Colors.red,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400),
                              ),
                            )
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
