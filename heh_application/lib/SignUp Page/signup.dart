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

  var isObscure;
  @override
  void initState() {
    super.initState();
    isObscure = false;
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
                      TextFormField(
                        readOnly: true,
                        controller: _date,
                        decoration: const InputDecoration(
                          hoverColor: Colors.black,
                          hintText: "Ngày sinh",
                        ),
                        onTap: () async {
                          DateTime? pickeddate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1960),
                              lastDate: DateTime(2030));
                          if (pickeddate != null) {
                            _date.text =
                                DateFormat('dd-MM-yyyy').format(pickeddate);
                            print(_date.text);
                            dob = DateFormat('yyyy-MM-dd').format(pickeddate);

                            print(dob);
                          }
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  password(label: "Mật khẩu", isObscure: true),
                  confirmPassword(
                      label: "Xác thực lại mật khẩu", obscureText: true),
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
          obscureText: obscureText,
          controller: _firstName,
          keyboardType: TextInputType.name,
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
        Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: TextFormField(
                controller: _email,
                obscureText: obscureText,
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
                  email != null && !EmailValidator.validate(email)
                      ? "Nhập đúng email"
                      : null;
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
          validator: (value) {
            if (value != null || value!.length > 11) {
              return "Số điện thoại không được nhiều hơn 10 số";
            } else {
              return null;
            }
          },
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

  Widget password({label, isObscure = false}) {
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
                      isObscure ? Icons.visibility : Icons.visibility_off)),
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
        TextFormField(
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

// class password extends StatefulWidget {
//   password(
//       {Key? key,
//       required this.label,
//       required TextEditingController controller})
//       : super(key: key);

//   String label;
//   bool obscureText = false;
//   final TextEditingController controller = TextEditingController();

//   @override
//   State<password> createState() => _passwordState();
// }

// class _passwordState extends State<password> {
//   var isObscure;
//   @override
//   void initState() {
//     super.initState();
//     isObscure = false;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: <Widget>[
//         Row(
//           children: <Widget>[
//             Text(
//               widget.label,
//               style: const TextStyle(
//                   fontSize: 15,
//                   fontWeight: FontWeight.w400,
//                   color: Colors.black87),
//             ),
//             const Text(
//               " *",
//               style: TextStyle(color: Colors.red),
//             ),
//           ],
//         ),
//         const SizedBox(height: 5),
//         TextFormField(
//           controller: widget.controller,
//           obscureText: isObscure,
//           decoration: InputDecoration(
//               suffixIcon: IconButton(
//                   onPressed: () {
//                     setState(() {
//                       isObscure = !isObscure;
//                     });
//                   },
//                   icon: Icon(isObscure
//                       ? Icons.remove_red_eye_outlined
//                       : Icons.remove_red_eye_sharp)),
//               hintText: 'Mật khẩu',
//               contentPadding:
//                   const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
//               enabledBorder: const OutlineInputBorder(
//                 borderSide: BorderSide(color: Colors.grey),
//               ),
//               border: const OutlineInputBorder(
//                   borderSide: BorderSide(color: Colors.grey))),
//         ),
//         const SizedBox(height: 15)
//       ],
//     );
//   }
// }

// class confirmPassword extends StatefulWidget {
//   confirmPassword(
//       {Key? key,
//       required this.label,
//       required TextEditingController controller})
//       : super(key: key);

//   String label;
//   bool obscureText = false;
//   final TextEditingController controller = TextEditingController();

//   @override
//   State<confirmPassword> createState() => _confirmPasswordState();
// }

// class _confirmPasswordState extends State<confirmPassword> {
//   var isObscure;
//   @override
//   void initState() {
//     super.initState();
//     isObscure = false;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: <Widget>[
//         Row(
//           children: <Widget>[
//             Text(
//               widget.label,
//               style: const TextStyle(
//                   fontSize: 15,
//                   fontWeight: FontWeight.w400,
//                   color: Colors.black87),
//             ),
//             const Text(
//               " *",
//               style: TextStyle(color: Colors.red),
//             ),
//           ],
//         ),
//         const SizedBox(height: 5),
//         TextFormField(
//           controller: widget.controller,
//           obscureText: isObscure,
//           decoration: InputDecoration(
//               suffixIcon: IconButton(
//                   onPressed: () {
//                     setState(() {
//                       isObscure = !isObscure;
//                     });
//                   },
//                   icon: Icon(isObscure
//                       ? Icons.remove_red_eye_outlined
//                       : Icons.remove_red_eye_sharp)),
//               hintText: 'Xác thực',
//               contentPadding:
//                   const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
//               enabledBorder: const OutlineInputBorder(
//                 borderSide: BorderSide(color: Colors.grey),
//               ),
//               border: const OutlineInputBorder(
//                   borderSide: BorderSide(color: Colors.grey))),
//         ),
//         const SizedBox(height: 15)
//       ],
//     );
//   }
// }
