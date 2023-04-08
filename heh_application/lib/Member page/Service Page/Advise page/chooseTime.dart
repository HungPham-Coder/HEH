import 'package:flutter/material.dart';
import 'package:heh_application/Member%20page/Service%20Page/Advise%20page/chooseDetail.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class ChooseTimePage extends StatefulWidget {
  const ChooseTimePage({Key? key}) : super(key: key);

  @override
  State<ChooseTimePage> createState() => _ChooseTimePageState();
}

class _ChooseTimePageState extends State<ChooseTimePage> {
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
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: Column(
              children: [
                Container(
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black)),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      CurrentTime(),
                      const SizedBox(height: 10),
                      const relationship(),
                      const SizedBox(height: 10),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: category(),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              ClockMenu(
                                label: "Chọn",
                                time: "Thời gian bắt đầu:",
                              ),
                              ClockMenu(
                                label: "Chọn",
                                time: "Thời gian kết thúc:",
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 25, vertical: 15),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  padding: MaterialStateProperty.all(
                                      const EdgeInsets.all(13)),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        side: const BorderSide(
                                            color: Colors.white)),
                                  )),
                              onPressed: () {},
                              child: const Text(
                                "Tìm kiếm",
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      const Center(
                        child: Text("Danh sách chuyên viên",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: PhysioChooseMenu(
                          icon:
                              "https://firebasestorage.googleapis.com/v0/b/healthcaresystem-98b8d.appspot.com/o/icon%2Fphy.png?alt=media&token=bac867bc-190c-4523-83ba-86fccc649622",
                          name: "Phạm Phú Minh Hưng",
                          time: "Khung giờ: ",
                          press: () {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) =>
                            //             const ChooseDetailpage()));
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

class ClockMenu extends StatefulWidget {
  ClockMenu({Key? key, required this.label, required this.time})
      : super(key: key);

  String label, time;

  @override
  State<ClockMenu> createState() => _ClockMenuState();
}

class _ClockMenuState extends State<ClockMenu> {
  TimeOfDay time = const TimeOfDay(hour: 00, minute: 00);

  @override
  Widget build(BuildContext context) {
    final hours = time.hour.toString().padLeft(2, '0');
    final minutes = time.minute.toString().padLeft(2, '0');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(widget.time, style: const TextStyle(fontSize: 15)),
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: Text("${hours}:${minutes}",
                        style: const TextStyle(fontSize: 18)),
                  )),
            ),
            ElevatedButton(
                child: Text(widget.label),
                onPressed: () async {
                  TimeOfDay? newtime = await showTimePicker(
                    // builder: (context, child) {
                    //   return MediaQuery(
                    //       data: MediaQuery.of(context)
                    //           .copyWith(alwaysUse24HourFormat: false),
                    //       child: child!);
                    // },
                    context: context,
                    initialTime: time,
                    cancelText: "Hủy",
                    confirmText: "Chấp nhận",
                    helpText: "Chọn khung giờ",
                    hourLabelText: "Giờ",
                    minuteLabelText: "Phút",
                  );
                  if (newtime == null) {
                    return;
                  }
                  setState(() => time = newtime);
                })
          ],
        ),
      ],
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
                    const SizedBox(width: 5),
                    SizedBox(
                        width: MediaQuery.of(context).size.width / 1.65,
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

class Problem {
  final String name;

  Problem({required this.name});
}

class category extends StatefulWidget {
  const category({Key? key}) : super(key: key);

  @override
  State<category> createState() => _categoryState();
}

class _categoryState extends State<category> {
  static final List<Problem> _problems = [
    Problem(name: "Đau lưng"),
    Problem(name: "Đau khớp gối"),
    Problem(name: "Đau khớp gối 1"),
    Problem(name: "Đau khớp gối 2"),
    Problem(name: "Đau khớp gối 3"),
    Problem(name: "Khác"),
  ];
  List<Problem?> _selectedProblems = [];

  bool _visibility = false;
  bool checkVisibility() {
    _selectedProblems.forEach((element) {
      if (element!.name == "Khác") {
        _visibility = true;
      }
    });
    return _visibility;
  }

  final _items = _problems
      .map((problem) => MultiSelectItem<Problem>(problem, problem.name))
      .toList();

  void _itemChange(Problem itemValue, bool isSelected) {
    setState(() {
      if (isSelected) {
        _selectedProblems.add(itemValue);
      } else {
        _selectedProblems.remove(itemValue);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(children: const [
          Text("Vấn đề của bạn "),
          Text("* ", style: TextStyle(color: Colors.red))
        ]),
        const SizedBox(height: 5),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.grey,
            ),
          ),
          child: Column(
            children: [
              MultiSelectBottomSheetField<Problem?>(
                selectedItemsTextStyle: const TextStyle(color: Colors.black),
                confirmText:
                    const Text("Chấp nhận", style: TextStyle(fontSize: 18)),
                cancelText: const Text("Hủy", style: TextStyle(fontSize: 18)),
                initialChildSize: 0.4,
                title: const Text("Vấn đề của bạn"),
                buttonText: _selectedProblems.isEmpty
                    ? const Text(
                        "Vấn đề của bạn",
                        style: TextStyle(color: Colors.grey, fontSize: 15),
                      )
                    : const Text(""),
                items: _problems
                    .map((e) => MultiSelectItem<Problem?>(e, e.name))
                    .toList(),
                listType: MultiSelectListType.CHIP,
                searchable: true,
                onConfirm: (values) {
                  setState(() {
                    _selectedProblems = values;
                    int counter = 0;
                    _selectedProblems.forEach((element) {
                      if (element!.name.contains("Khác")) {
                        counter++;
                      }
                    });
                    if (counter > 0) {
                      _visibility = true;
                    } else {
                      _visibility = false;
                    }
                  });
                },
                chipDisplay: MultiSelectChipDisplay(onTap: (values) {
                  setState(
                    () {
                      _itemChange(values!, false);
                      int counter = 0;
                      _selectedProblems.forEach((element) {
                        if (element!.name.contains("Khác")) {
                          counter++;
                        }
                      });
                      if (counter == 0) {
                        _visibility = false;
                      } else {
                        _visibility = true;
                      }
                    },
                  );
                }),
              )
            ],
          ),
        ),
        const SizedBox(height: 10),
        Visibility(
          visible: _visibility,
          child: problem(label: "Khác"),
        ),
      ],
    );
  }
}

Widget problem({label, obscureText = false}) {
  return Column(
    children: <Widget>[
      Row(
        children: <Widget>[
          Text(
            label,
            style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: Colors.black87),
          ),
          const Text(
            " *",
            style: TextStyle(color: Colors.red),
          ),
        ],
      ),
      const SizedBox(height: 5),
      TextField(
        obscureText: obscureText,
        // controller: _firstName,
        decoration: const InputDecoration(
            hintText: 'Vấn đề',
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            border:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.grey))),
      ),
      const SizedBox(height: 10)
    ],
  );
}

class relationship extends StatefulWidget {
  const relationship({Key? key}) : super(key: key);

  @override
  State<relationship> createState() => _relationshipState();
}

class _relationshipState extends State<relationship> {
  final List<String> _relationships = [
    "- Chọn -",
    "Tôi",
    "Cha",
    "Mẹ",
    "Vợ",
    "Chồng",
    "Con",
    "Anh",
    "Chị",
    "Em",
    "Cháu",
    "Ông nội",
    "Bà nội",
    "Ông Ngoại",
    "Bà ngoại"
  ];
  String? selectedRelationship = "- Chọn -";
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            children: const [
              Text("Bạn muốn đặt cho ai?"),
              Text(" *", style: TextStyle(color: Colors.red)),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 55,
            child: SizedBox(
              child: DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: Colors.grey))),
                value: selectedRelationship,
                items: _relationships
                    .map((relationship) => DropdownMenuItem<String>(
                        value: relationship,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            relationship,
                            style: const TextStyle(fontSize: 15),
                          ),
                        )))
                    .toList(),
                onChanged: (relationship) => setState(() {
                  selectedRelationship = relationship;
                }),
              ),
            ),
          )
        ],
      ),
    );
  }
}
