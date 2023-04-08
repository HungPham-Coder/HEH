// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:heh_application/services/auth.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

enum ForgotPassPageState { resetPassword, sendOTP }

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key, required this.auth}) : super(key: key);
  final AuthBase auth;
  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController _OTPController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  ForgotPassPageState _OTPResetPasswordState = ForgotPassPageState.sendOTP;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Quên mật khẩu",
          style: TextStyle(fontSize: 23),
        ),
        elevation: 10,
        backgroundColor: const Color.fromARGB(255, 46, 161, 226),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            size: 25,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 80),
          // height: MediaQuery.of(context).size.height / 3,
          // width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              // Column(
              //   children: <Widget>[
              ForgotPass(label: "Nhập số điện thoại"),
              //   ],
              // ),
              const SizedBox(height: 15),
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Container(
                    padding: const EdgeInsets.only(top: 0),
                    child: MaterialButton(
                      minWidth: double.infinity,
                      height: 50,
                      onPressed: verifyPhoneNumber,
                      color: const Color.fromARGB(255, 46, 161, 226),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        _OTPResetPasswordState == ForgotPassPageState.sendOTP
                            ? 'SendOTP'
                            : 'Đặt lại mật khẩu',
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Widget ForgotPass({label, obscureText = false}) {
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.center,
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
        IntlPhoneField(
          keyboardType: TextInputType.phone,
          controller: _phoneController,
          obscureText: obscureText,
          decoration: const InputDecoration(
              hintText: 'Phone number',
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey))),
        ),
        const SizedBox(height: 20),
        Visibility(
          visible: _OTPResetPasswordState == ForgotPassPageState.sendOTP
              ? false
              : true,
          child: TextField(
            controller: _OTPController,
            decoration: const InputDecoration(
                labelText: 'OTP',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                )),
          ),
        ),
      ],
    );
  }

  void verifyPhoneNumber() {
    print(_phoneController.text);
    widget.auth.verifyUserPhoneNumber(_phoneController.text);
    _OTPResetPasswordState = ForgotPassPageState.resetPassword;
    setState(() {});
  }

  Future<void> verifyOTPCode() async {}
}

// ignore: non_constant_identifier_names

