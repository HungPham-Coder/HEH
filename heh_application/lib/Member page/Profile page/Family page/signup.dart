import 'dart:async';

import 'package:flutter/material.dart';
import 'package:heh_application/Member%20page/Profile%20page/Family%20page/signupMed.dart';
import 'package:heh_application/SignUp%20Page/signupMed.dart';
import 'package:heh_application/main.dart';
import 'package:heh_application/models/relationship.dart';
import 'package:heh_application/models/sign_up_user.dart';
import 'package:heh_application/services/call_api.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

// ignore: camel_case_types
enum genderGroup { male, female, others }

class SignUpFamilyPage extends StatefulWidget {
  const SignUpFamilyPage({Key? key}) : super(key: key);

  @override
  State<SignUpFamilyPage> createState() => _SignUpFamilyPageState();
}

class _SignUpFamilyPageState extends State<SignUpFamilyPage> {
  genderGroup _genderValue = genderGroup.male;

  final List<String> _relationships =["- Chọn -",];


  String selectedRelationship = "- Chọn -";

  final TextEditingController _date = TextEditingController();
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _phone = TextEditingController();

  Future<void> signUp(SignUpUser signUpUser) async {
    await CallAPI().callRegisterAPI(signUpUser);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Đăng ký thành viên gia đình",
          style: TextStyle(fontSize: 18),
        ),
        elevation: 10,
        backgroundColor: const Color.fromARGB(255, 46, 161, 226),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 20,
              ),
              Text(
                "Hãy tham gia cùng chúng tôi!",
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              ),
              const SizedBox(
                height: 20,
              ),
              fullName(label: "Họ và Tên"),
              email(label: "Email"),
              phone(label: "Số điện thoại"),
              Row(
                children: const <Widget>[
                  Text(
                    "Giới tính ",
                    style: TextStyle(fontSize: 15),
                  ),
                  Text(
                    "*",
                    style: TextStyle(fontSize: 15, color: Colors.red),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  const Text("Nam"),
                  Radio(
                      value: genderGroup.male,
                      groupValue: _genderValue,
                      onChanged: (genderGroup? value) {
                        setState(() {
                          _genderValue = value!;
                        });
                      }),
                  const Text("Nữ"),
                  Radio(
                      value: genderGroup.female,
                      groupValue: _genderValue,
                      onChanged: (genderGroup? value) {
                        setState(() {
                          _genderValue = value!;
                        });
                      }),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: const [
                  Text("Ngày sinh"),
                  Text(" *", style: TextStyle(color: Colors.red)),
                ],
              ),
              const SizedBox(height: 5),
              TextFormField(
                controller: _date,
                readOnly: true,
                onTap: () async {
                  DateTime? pickeddate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1960),
                      lastDate: DateTime(2030));
                  if (pickeddate != null) {
                    _date.text = DateFormat('yyyy-MM-dd').format(pickeddate);
                  }
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: const [
                  Text("Mối quan hệ"),
                  Text(" *", style: TextStyle(color: Colors.red)),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  // child: SizedBox(
                  child: FutureBuilder<List<Relationship>>(
                    future: CallAPI().getAllRelationship(),
                    builder: (context, snapshot)  {
                      if (snapshot.hasData){
                        if (_relationships.length == 1){
                          snapshot.data!.forEach((element) {
                            String field = "${element.relationName}";
                            _relationships.add(field);
                          });
                          print("Co data");
                        }
                        return DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                  BorderSide(width: 1, color: Colors.grey))),
                          value: selectedRelationship,
                          items: _relationships
                              .map((relationship) => DropdownMenuItem<String>(
                              value: relationship,
                              child: Text(
                                relationship,
                                style: const TextStyle(fontSize: 15),
                              )))
                              .toList(),
                          onChanged: (relationship) => setState(() {
                            selectedRelationship = relationship!;
                          }),
                        );
                      }
                      else {
                        return Center(child: CircularProgressIndicator(),);
                      }

                    }
                  )

                  // ),
                  ),
              Row(
                children: [
                  Container(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
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
                                    builder: (context) =>
                                        const FamilySignUpMedicalPage()));
                          },
                          color: const Color.fromARGB(255, 46, 161, 226),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text(
                            "Tiếp Theo",
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
              const SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget fullName({label, obscureText = false}) {
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
          controller: _firstName,
          decoration: const InputDecoration(
              hintText: 'Họ và Tên',
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

  Widget email({label, obscureText = false}) {
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
          controller: _email,
          obscureText: obscureText,
          decoration: const InputDecoration(
              hintText: 'Email',
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

  Widget phone({label, obscureText = false}) {
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
        TextFormField(
          keyboardType: TextInputType.phone,
          controller: _phone,
          obscureText: obscureText,
          decoration: const InputDecoration(
              hintText: 'Số điện thoại',
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
}
