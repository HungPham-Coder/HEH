import 'package:flutter/material.dart';
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

  final TextEditingController _date = TextEditingController();
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();

  Future<void> signUp(SignUpUser signUpUser) async {
    CallAPI().callRegisterAPI(context, signUpUser);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
          // height: MediaQuery.of(context).size.height + 110,
          // width: MediaQuery.of(context).size.width,
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
                  lastName(label: "Họ"),
                  firstName(label: "Tên"),
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
                          const Text("Khác"),
                          Radio(
                              value: genderGroup.others,
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
                            _date.text =
                                DateFormat('yyyy-MM-dd').format(pickeddate);
                          }
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  password(label: "Mật khẩu", obscureText: true),
                  confirmPassword(
                      label: "Xác thực lại mật khẩu", obscureText: true),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 70),
                  child: Container(
                    padding: const EdgeInsets.only(top: 0),
                    child: MaterialButton(
                      minWidth: double.infinity,
                      height: 50,
                      onPressed: () {
                        SignUpUser signUpUser = SignUpUser(
                            firstName: _firstName.text,
                            lastName: _lastName.text,
                            phone: _phone.text,
                            password: _password.text,
                            email: _email.text,
                            gender: _genderValue.index,
                            dob: _date.text);
                        signUp(signUpUser);
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
              const SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget firstName({label, obscureText = false}) {
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
              hintText: 'Tên',
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

  Widget lastName({label, obscureText = false}) {
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
          controller: _lastName,
          obscureText: obscureText,
          decoration: const InputDecoration(
              hintText: 'Họ',
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
        TextField(
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

  Widget password({label, obscureText = false}) {
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
          controller: _password,
          obscureText: obscureText,
          decoration: const InputDecoration(
              hintText: 'Mật khẩu',
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

  Widget confirmPassword({label, obscureText = false}) {
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
          controller: _confirmPassword,
          obscureText: obscureText,
          decoration: const InputDecoration(
              hintText: 'Xác thực lại mật khẩu',
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
