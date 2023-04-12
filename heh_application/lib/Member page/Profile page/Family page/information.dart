import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:heh_application/Member%20page/Profile%20page/Family%20page/family.dart';
import 'package:heh_application/Member%20page/Profile%20page/setting.dart';
import 'package:intl/intl.dart';

final TextEditingController _date = TextEditingController();
final TextEditingController _firstName = TextEditingController();
final TextEditingController _lastName = TextEditingController();
final TextEditingController _email = TextEditingController();
final TextEditingController _phone = TextEditingController();
final TextEditingController _password = TextEditingController();
final TextEditingController _confirmPassword = TextEditingController();

enum genderGroup { male, female, others }

class FamilyInformationPage extends StatefulWidget {
  const FamilyInformationPage({Key? key}) : super(key: key);

  @override
  State<FamilyInformationPage> createState() => _FamilyInformationPageState();
}

class _FamilyInformationPageState extends State<FamilyInformationPage> {
  genderGroup _genderValue = genderGroup.male;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                Center(
                  child: SizedBox(
                    height: 115,
                    width: 115,
                    child: Stack(
                      clipBehavior: Clip.none,
                      fit: StackFit.expand,
                      children: [
                        const CircleAvatar(
                          backgroundColor: Color.fromARGB(255, 220, 220, 220),
                          backgroundImage:
                              AssetImage("assets/icons/person.png"),
                        ),
                        Positioned(
                          right: -12,
                          bottom: 0,
                          child: SizedBox(
                            height: 46,
                            width: 46,
                            child: TextButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            const Color(0xfff5f6f9)),
                                    padding: MaterialStateProperty.all(
                                        EdgeInsets.zero),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          side: const BorderSide(
                                              color: Color.fromARGB(
                                                  255, 46, 161, 226))),
                                    )),
                                onPressed: () async {},
                                child: SvgPicture.asset(
                                  "assets/icons/camera.svg",
                                  width: 20,
                                  height: 20,
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Text("ABC", style: TextStyle(fontSize: 30)),
                const SizedBox(height: 20),
              ],
            ),
          ),
          fullName(label: "Họ và Tên"),
          email(label: "Email"),
          phone(label: "Số điện thoại"),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              TextField(
                controller: _date,
                decoration: const InputDecoration(
                  labelText: "Ngày sinh ",
                ),
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
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
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
                                builder: (context) =>  FamilyPage()));
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
                                builder: (context) =>  FamilyPage()));
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
    )));
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
          // controller: _firstName,
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
          // controller: _email,
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
          // controller: _phone,
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
