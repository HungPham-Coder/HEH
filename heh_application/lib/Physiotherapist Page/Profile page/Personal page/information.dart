import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:heh_application/Login%20page/landing_page.dart';
import 'package:heh_application/Member%20page/Profile%20page/setting.dart';
import 'package:intl/intl.dart';

final TextEditingController _date = TextEditingController();
final TextEditingController _firstName = TextEditingController();
final TextEditingController _lastName = TextEditingController();
final TextEditingController _email = TextEditingController();
final TextEditingController _phone = TextEditingController();
final TextEditingController _password = TextEditingController();
final TextEditingController _confirmPassword = TextEditingController();

enum genderGroup { male, female }

class PhysioInformationPage extends StatefulWidget {
  const PhysioInformationPage({Key? key}) : super(key: key);

  @override
  State<PhysioInformationPage> createState() => _PhysioInformationPageState();
}

class _PhysioInformationPageState extends State<PhysioInformationPage> {
  genderGroup _genderValue = genderGroup.male;

  @override
  void initState() {
    super.initState();
    checkGender();
  }

  void checkGender() {
    if (sharedCurrentUser!.gender == false) {
      _genderValue = genderGroup.female;
    }
  }

  @override
  Widget build(BuildContext context) {
    // String dob = DateFormat('yyyy-MM-dd').format(sharedCurrentUser!.dob!);
    DateTime tempDob =
        new DateFormat("yyyy-MM-dd").parse(sharedCurrentUser!.dob!);

    String dob = DateFormat("dd-MM-yyyy").format(tempDob);
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
                        CircleAvatar(
                            backgroundColor: Color.fromARGB(255, 220, 220, 220),
                            backgroundImage: NetworkImage(
                                sharedCurrentUser!.image.toString())),
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
                                child: SvgPicture.network(
                                  "https://firebasestorage.googleapis.com/v0/b/healthcaresystem-98b8d.appspot.com/o/icon%2Fcamera.svg?alt=media&token=afa6a202-304e-45af-8df5-870126316135",
                                  width: 20,
                                  height: 20,
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
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
                    },
                  ),
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
              TextFormField(
                initialValue: dob,
                // DateTime.parse(sharedCurrentUser!.dob as String).toString(),
                readOnly: true,
                // controller: _date,
                decoration: const InputDecoration(
                  labelText: "Ngày sinh ",
                ),
                onTap: () async {
                  DateTime? pickeddate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2030));
                  if (pickeddate != null) {
                    _date.text = DateFormat('dd-MM-yyyy').format(pickeddate);
                  } else {
                    _date.text = sharedCurrentUser!.dob!;
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
        TextFormField(
          initialValue: sharedCurrentUser!.firstName,
          obscureText: obscureText,

          // controller: _firstName,

          decoration: const InputDecoration(
              // hintText: 'Họ và Tên',
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
        TextFormField(
          initialValue: sharedCurrentUser!.email,
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
          initialValue: sharedCurrentUser!.phone,
          keyboardType: TextInputType.phone,
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
