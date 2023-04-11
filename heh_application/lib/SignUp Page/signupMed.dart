import 'package:flutter/material.dart';
import 'package:heh_application/SignUp%20Page/signup.dart';
import 'package:heh_application/main.dart';
import 'package:heh_application/models/medical_record.dart';
import 'package:heh_application/models/sign_up_user.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import '../Login page/login.dart';
import '../models/exercise_model/category.dart';
import '../services/call_api.dart';

class Problem {
  final String name;

  Problem({required this.name});
}

class SignUpMedicalPage extends StatefulWidget {
  SignUpMedicalPage({Key? key, required this.signUpUser}) : super(key: key);
  SignUpUser signUpUser;
  @override
  State<SignUpMedicalPage> createState() => _SignUpMedicalPageState();
}

class _SignUpMedicalPageState extends State<SignUpMedicalPage> {
  final TextEditingController _difficult = TextEditingController();
  final TextEditingController _injury = TextEditingController();
  final TextEditingController _curing = TextEditingController();
  final TextEditingController _medicine = TextEditingController();

  Future<void> signUp(SignUpUser signUpUser) async {
    CallAPI().callRegisterAPI(signUpUser);
  }

   static final List<Problem> _problems = [];
  List<Problem?> _selectedProblems = [];
  static final List<CategoryModel> _listCategory = [];
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

  bool _visibility = false;
  bool checkVisibility() {
    _selectedProblems.forEach((element) {
      if (element!.name == "Khác") {
        _visibility = true;
      }
    });
    return _visibility;
  }


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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Hồ sơ bệnh án",
          style: TextStyle(fontSize: 23),
        ),
        elevation: 10,
        backgroundColor: const Color.fromARGB(255, 46, 161, 226),
      ),
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
                    child: Column(
                      children: [
                        FutureBuilder<List<CategoryModel>>(
                            future: CallAPI().getAllCategory(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {

                                addProblem(snapshot.data!);
                                return MultiSelectBottomSheetField<Problem?>(
                                  confirmText: const Text("Chấp nhận",
                                      style: TextStyle(fontSize: 18)),
                                  cancelText: const Text("Hủy",
                                      style: TextStyle(fontSize: 18)),
                                  initialChildSize: 0.4,
                                  title: const Text("Vấn đề của bạn"),
                                  buttonText: const Text(
                                    "Vấn đề của bạn",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 15),
                                  ),
                                  items: _problems
                                      .map((e) =>
                                          MultiSelectItem<Problem?>(e, e.name))
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
                                  chipDisplay:
                                      MultiSelectChipDisplay(onTap: (values) {
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
                                );
                              } else {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            })
                      ],
                    ),
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: Container(
                        padding: const EdgeInsets.only(top: 20),
                        child: MaterialButton(
                          height: 50,
                          onPressed: () async {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignUpPage()));
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
                        padding: const EdgeInsets.only(top: 20),
                        child: MaterialButton(
                          height: 50,
                          onPressed: () {

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const WelcomePage()));
                          },
                          color: Colors.grey[400],
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text(
                            "Bỏ qua",
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
                        padding: const EdgeInsets.only(top: 20),
                        child: MaterialButton(
                          height: 50,
                          onPressed: () async {
                            String problem = '';
                            _selectedProblems.forEach((element) {
                              problem += '${element!.name},';
                            });

                            String userID = await CallAPI()
                                .callRegisterAPI(widget.signUpUser);
                          List<String> listCategoryID = [];
                            _selectedProblems.forEach((elementSelected) {
                              if (elementSelected!.name != "Khác"){
                                _listCategory.forEach((category) {
                                  if (elementSelected.name == category.categoryName){
                                    listCategoryID.add(category.categoryID);
                                  }
                                });
                              }

                            });
                            listCategoryID.forEach((element) async {
                              MedicalRecord medicalRecord = MedicalRecord(
                                subProfileID: null,
                                userID: userID,
                                categoryID:
                                element,
                                problem: problem,
                                curing: _curing.text,
                                difficulty: _difficult.text,
                                injury: _injury.text,
                                medicine: _medicine.text,
                              );
                              await CallAPI().createMedicalRecord(medicalRecord);
                            });

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginPage()));
                          },
                          color: const Color.fromARGB(255, 46, 161, 226),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text(
                            "Đăng ký",
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
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey))),
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
          controller: _difficult,
          obscureText: obscureText,
          decoration: const InputDecoration(
              hintText: 'Hoạt động',
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey))),
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
          ],
        ),
        const SizedBox(height: 5),
        TextField(
          controller: _injury,
          obscureText: obscureText,
          decoration: const InputDecoration(
              hintText: 'Chấn thương',
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey))),
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
          controller: _curing,
          obscureText: obscureText,
          decoration: const InputDecoration(
              hintText: 'Bệnh lý',
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey))),
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
          controller: _medicine,
          obscureText: obscureText,
          decoration: const InputDecoration(
              hintText: 'Thuốc',
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey))),
        ),
        const SizedBox(height: 0)
      ],
    );
  }
}
