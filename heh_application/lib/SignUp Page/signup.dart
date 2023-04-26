import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:heh_application/SignUp%20Page/signupMed.dart';
import 'package:heh_application/main.dart';
import 'package:heh_application/models/sign_up_user.dart';
import 'package:heh_application/services/call_api.dart';
import 'package:intl/intl.dart';

// ignore: camel_case_types
enum genderGroup { male, female, others }

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  genderGroup _genderValue = genderGroup.male;

  String? dob;
  DateTime today = DateTime.now();
  late int age;

  bool isObscure = false;
  bool isObscure1 = false;
  @override
  void initState() {
    super.initState();
    isObscure = true;
    isObscure1 = true;
  }

  final TextEditingController _date = TextEditingController();
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Đăng ký tài khoản",
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
            children: <Widget>[
              Column(
                children: <Widget>[
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Hãy tham gia cùng chúng tôi!",
                    style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                children: <Widget>[
                  fullName(label: "Họ và Tên"),
                  email(label: "Email"),
                  phone(label: "Số điện thoại"),
                  address(label: "Địa chỉ"),
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
                      Row(children: const [
                        Text("Ngày sinh "),
                        Text("*", style: TextStyle(color: Colors.red))
                      ]),
                      Form(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: TextFormField(
                          readOnly: true,
                          controller: _date,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Không được để trống ngày sinh!";
                            } else if (age < 18) {
                              return "Tuổi phải trên 18.";
                            } else {
                              return null;
                            }
                          },
                          decoration: const InputDecoration(
                            hoverColor: Colors.black,
                            hintText: "Ngày sinh",
                          ),
                          onTap: () async {
                            DateTime? pickeddate = await showDatePicker(
                                context: context,
                                initialDate: today,
                                firstDate: DateTime(1900),
                                lastDate: DateTime(2030));
                            if (pickeddate != null) {
                              _date.text =
                                  DateFormat('dd-MM-yyyy').format(pickeddate);
                              // print(_date.text);
                              dob = DateFormat('yyyy-MM-dd').format(pickeddate);
                              age = today.year - pickeddate.year;
                              print(age);
                              // print(dob);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  password(label: "Mật khẩu"),
                  confirmPassword(label: "Xác thực lại mật khẩu"),
                ],
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
                          onPressed: () async {
                            bool gender = false;
                            if (_genderValue.index == 0) {
                              gender = true;
                            } else if (_genderValue == 1) {
                              gender = false;
                            }
                            SignUpUser signUpUser = SignUpUser(
                              firstName: _firstName.text,
                              email: _email.text,
                              phone: _phone.text,
                              address: _address.text,
                              gender: gender,
                              dob: dob,
                              password: _password.text,
                            );

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignUpMedicalPage(
                                  signUpUser: signUpUser,
                                ),
                              ),
                            );
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
    String patttern = "'[\x5F]+|[a-z]|[0-9]";
    RegExp regExp = new RegExp(patttern);
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
        Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: TextFormField(
            keyboardType: TextInputType.name,
            validator: (value) {
              if (value!.isEmpty) {
                return "Hãy nhập Họ và Tên của bạn.";
              } else if (!regExp.hasMatch(value)) {
                return "Hãy nhập đúng tên";
              }
            },
            obscureText: obscureText,
            controller: _firstName,
            decoration: const InputDecoration(
                hintText: 'Họ và Tên',
                contentPadding:
                    EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey))),
          ),
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
        Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: TextFormField(
                controller: _email,
                obscureText: obscureText,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                    hintText: 'Email',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey))),
                validator: (email) {
                  if (email != null && !EmailValidator.validate(email)) {
                    return "Nhập đúng email";
                  } else if (email!.isEmpty) {
                    return "Vui lòng nhập email!";
                  } else {
                    return null;
                  }
                })),
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
        Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: TextFormField(
            keyboardType: TextInputType.phone,
            controller: _phone,
            obscureText: obscureText,
            decoration: const InputDecoration(
                hintText: 'Số điện thoại',
                contentPadding:
                    EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey))),
            validator: (value) {
              if (value != null && value.length > 10) {
                return "Số điện thoại không được nhiều hơn 10 chữ số";
              } else if (value!.isEmpty) {
                return "Không được để trống";
              } else {
                return null;
              }
            },
          ),
        ),
        const SizedBox(height: 10)
      ],
    );
  }

  Widget address({label, obscureText = false}) {
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
          controller: _address,
          obscureText: obscureText,
          keyboardType: TextInputType.streetAddress,
          decoration: const InputDecoration(
              hintText: 'Địa chỉ',
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

  Widget password({label}) {
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
          controller: _password,
          obscureText: isObscure,
          decoration: InputDecoration(
              suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      isObscure = !isObscure;
                    });
                  },
                  icon: Icon(
                      isObscure ? Icons.visibility_off : Icons.visibility)),
              hintText: 'Mật khẩu',
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              border: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey))),
        ),
        const SizedBox(height: 15)
      ],
    );
  }

  Widget confirmPassword({label}) {
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
          controller: _confirmPassword,
          obscureText: isObscure1,
          decoration: InputDecoration(
              suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      isObscure1 = !isObscure1;
                    });
                  },
                  icon: Icon(
                      isObscure1 ? Icons.visibility_off : Icons.visibility)),
              hintText: 'Mật khẩu xác thực',
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              border: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey))),
        ),
        const SizedBox(height: 0)
      ],
    );
  }
}
