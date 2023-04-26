import 'package:flutter/material.dart';
import 'package:heh_application/Member%20page/Service%20Page/Advise%20page/result.dart';
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
          child: Column(
            children: [
              const SizedBox(height: 10),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black)),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              children: [
                                const SizedBox(height: 20),
                                const relationship(),
                                const SizedBox(height: 20),
                                const category(),
                                const SizedBox(height: 20),
                                chooseDate(),
                                const SizedBox(height: 20),
                                // const chooseSlot(),
                                // const SizedBox(height: 10),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: ElevatedButton(
                  style: ButtonStyle(
                      padding:
                          MaterialStateProperty.all(const EdgeInsets.all(15)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                            side: const BorderSide(color: Colors.white)),
                      )),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const TimeResultPage()));
                  },
                  child: const Text(
                    "Tìm kiếm",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
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
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                children: [
                  const SizedBox(width: 10),
                  Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        child: Text("${hours}:${minutes}",
                            style: const TextStyle(fontSize: 18)),
                      )),
                ],
              ),
            ),
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
                        width: MediaQuery.of(context).size.width / 1.75,
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
  ];
  List<Problem?> _selectedProblems = [];

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
                  });
                },
                chipDisplay: MultiSelectChipDisplay(onTap: (values) {
                  setState(
                    () {
                      _itemChange(values!, false);
                    },
                  );
                }),
              )
            ],
          ),
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
    return Column(
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
          height: 50,
          child: SizedBox(
            child: DropdownButtonFormField<String>(
              value: selectedRelationship,
              items: _relationships
                  .map((relationship) => DropdownMenuItem<String>(
                      value: relationship,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          relationship,
                          style: const TextStyle(fontSize: 13),
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
    );
  }
}

class chooseSlot extends StatefulWidget {
  const chooseSlot({Key? key}) : super(key: key);

  @override
  State<chooseSlot> createState() => _chooseSlotState();
}

class _chooseSlotState extends State<chooseSlot> {
  final List<String> _relationships = [
    "- Chọn khung giờ -",
    "00:00 - 01:00",
    "01:00 - 02:00",
    "02:00 - 03:00",
    "03:00 - 04:00",
    "04:00 - 05:00",
    "05:00 - 06:00",
    "06:00 - 07:00",
    "07:00 - 08:00",
    "08:00 - 09:00",
    "09:00 - 10:00",
    "10:00 - 11:00",
    "11:00 - 12:00",
    "12:00 - 13:00",
    "13:00 - 14:00",
    "14:00 - 15:00",
    "15:00 - 16:00",
    "16:00 - 17:00",
    "17:00 - 18:00",
    "18:00 - 19:00",
    "19:00 - 20:00",
    "20:00 - 21:00",
    "21:00 - 22:00",
    "22:00 - 23:00",
    "23:00 - 00:00",
  ];
  String? selectedRelationship = "- Chọn khung giờ -";
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: const [
            Text("Bạn muốn đặt khung giờ nào?"),
            Text(" *", style: TextStyle(color: Colors.red)),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 50,
          child: SizedBox(
            child: DropdownButtonFormField<String>(
              value: selectedRelationship,
              items: _relationships
                  .map((relationship) => DropdownMenuItem<String>(
                      value: relationship,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          relationship,
                          style: const TextStyle(fontSize: 13),
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
    );
  }
}

class chooseDate extends StatelessWidget {
  chooseDate({Key? key}) : super(key: key);
  final TextEditingController _date = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Row(children: const [
          Text("Chọn ngày muốn đặt "),
          Text("*", style: TextStyle(color: Colors.red))
        ]),
        TextFormField(
          readOnly: true,
          controller: _date,
          decoration: const InputDecoration(
            hoverColor: Colors.black,
            hintText: "Chọn ngày",
          ),
          onTap: () async {
            DateTime? pickeddate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1960),
                lastDate: DateTime(2030));
            if (pickeddate != null) {
              _date.text = DateFormat('dd-MM-yyyy').format(pickeddate);
            }
          },
        ),
      ],
    );
    ;
  }
}

class chooseTime extends StatefulWidget {
  const chooseTime({Key? key}) : super(key: key);

  @override
  State<chooseTime> createState() => _chooseTimeState();
}

class _chooseTimeState extends State<chooseTime> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
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
      ],
    );
  }
}
