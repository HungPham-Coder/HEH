import 'package:flutter/material.dart';
import 'package:heh_application/Login%20page/landing_page.dart';
import 'package:heh_application/Member%20page/Profile%20page/setting.dart';
import 'package:heh_application/models/medical_record.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import '../../../models/exercise_model/category.dart';
import '../../../services/call_api.dart';

class MedicalPage extends StatefulWidget {
  const MedicalPage({Key? key}) : super(key: key);

  @override
  State<MedicalPage> createState() => _MedicalPageState();
}

class Problem {
  final String name;

  Problem({required this.name});
}

class _MedicalPageState extends State<MedicalPage> {
  static final List<CategoryModel> _listCategory = [];
  static final List<Problem> _problems = [
  ];
  List _selectedProblems = [];

  bool _visibility = false;



  void addProblem(List<CategoryModel> list) {
    if (_problems.isEmpty){

      list.forEach((category) {

        _problems.add(Problem(name: category.categoryName));

        _listCategory.add(category);
      });
      _problems.add(Problem(name: "Khác"));
      // _listCategory.forEach((element) {print(element.categoryName);});
    }



  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: const <Widget>[
                      Text(
                        "Anh/Chị đang gặp vấn đề gì?",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Colors.black87),
                      ),
                      Text(
                        " *",
                        style: TextStyle(color: Colors.red),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.grey,
                      ),
                    ),

                     child: FutureBuilder <MedicalRecord>(
                          future: CallAPI().getMedicalRecordByUserId(sharedCurrentUser!.userID!),
                            builder: (context, snapshot) {
                            if (snapshot.hasData){

                            return MultiSelectBottomSheetField<Problem?>(
                              initialChildSize: 0.4,
                              title: const Text("Vấn đề của bạn"),
                              buttonText: const Text(
                                "Vấn đề của bạn",
                                style: TextStyle(color: Colors.grey, fontSize: 15),
                              ),
                              items: _problems
                                  .map((e) => MultiSelectItem(e, e.name))
                                  .toList(),
                              listType: MultiSelectListType.CHIP,
                              searchable: true,

                              onConfirm: (values) {
                                setState(() {


                                  _selectedProblems = values;
                                  for (var values in _selectedProblems) {
                                    if (values == 'Khác') {
                                      _visibility = true;
                                    }
                                  }
                                });
                              },
                              chipDisplay: MultiSelectChipDisplay(

                                onTap: (values) {
                                  setState(() {
                                    if (values.toString() == "Khác") {
                                      _visibility = false;
                                    }
                                    _selectedProblems.remove(values);
                                  });
                                },
                              ),
                            );
                            }
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        ),
                        // _selectedProblems == null || _selectedProblems.isEmpty
                        //     ? Container(
                        //         padding: const EdgeInsets.all(10),
                        //         alignment: Alignment.centerLeft,
                        //         child: const Text(
                        //           "Trống",
                        //           style: TextStyle(color: Colors.black54),
                        //         ))
                        //     : Container(),

                  ),
                  const SizedBox(height: 20),
                  Visibility(
                    visible: _visibility,
                    child: problem(label: "Khác"),
                  ),
                  difficult(label: "Hoạt động khó khăn trong cuộc sống?"),
                  injury(label: "Anh/Chị đã gặp chấn thương gì?"),
                  curing(label: "Bệnh lý Anh/Chị đang điều trị kèm theo"),
                  medicine(label: "Thuốc đang sử dụng hiện tại"),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: Container(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: MaterialButton(
                          height: 50,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SettingPage()));
                          },
                          color: Colors.grey[400],
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text(
                            "Hủy",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )),
                  Container(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: Container(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: MaterialButton(
                          height: 50,
                          onPressed: () {
                            // SignUpUser signUpUser = SignUpUser(
                            //     firstName: _firstName.text,
                            //     lastName: _lastName.text,
                            //     phone: _phone.text,
                            //     password: _password.text,
                            //     email: _email.text,
                            //     gender: _genderValue.index,
                            //     dob: _date.text);
                            // signUp(signUpUser);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SettingPage()));
                          },
                          color: const Color.fromARGB(255, 46, 161, 226),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text(
                            "Cập nhật",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
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

Widget difficult({label, obscureText = false}) {
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
        // controller: _email,
        obscureText: obscureText,
        decoration: const InputDecoration(
            hintText: 'Hoạt động',
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

Widget injury({label, obscureText = false}) {
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
        // controller: _phone,
        obscureText: obscureText,
        decoration: const InputDecoration(
            hintText: 'Chấn thương',
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

Widget curing({label, obscureText = false}) {
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
        // controller: _password,
        obscureText: obscureText,
        decoration: const InputDecoration(
            hintText: 'Bệnh lý',
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            border:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.grey))),
      ),
      const SizedBox(height: 15)
    ],
  );
}

Widget medicine({label, obscureText = false}) {
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
        // controller: _confirmPassword,
        obscureText: obscureText,
        decoration: const InputDecoration(
            hintText: 'Thuốc',
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            border:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.grey))),
      ),
      const SizedBox(height: 0)
    ],
  );
}
