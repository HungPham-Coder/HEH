import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:heh_application/ExceptionDialog/show_exception_alert_dialog.dart';
import 'package:heh_application/ForgotPassword%20Page/forgotPass.dart';
import 'package:heh_application/Main%20page/navigation_main.dart';
import 'package:heh_application/SignUp%20Page/signup.dart';
import 'package:heh_application/models/login_user.dart';
import 'package:heh_application/services/auth.dart';
import 'package:heh_application/services/call_api.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController phoneController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Đăng nhập",
          style: TextStyle(fontSize: 23),
        ),
        elevation: 10,
        backgroundColor: const Color.fromARGB(255, 46, 161, 226),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height - 40,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height / 4,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/welcome.jpg"))),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      children: <Widget>[
                        inputPhone(
                            label: "Số điện thoại",
                            phoneController: phoneController),
                        inputPassword(
                            label: "Mật khẩu",
                            obscureText: true,
                            passwordController: passwordController)
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  return  ForgotPassword(auth: auth,);
                                }),
                              );
                            },
                            child: const Text(
                              "Quên mật khẩu?",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 46, 161, 226),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      )),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Container(
                      padding: const EdgeInsets.only(top: 0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: const Border(
                            bottom: BorderSide(color: Colors.black),
                            top: BorderSide(color: Colors.black),
                            left: BorderSide(color: Colors.black),
                            right: BorderSide(color: Colors.black),
                          )),
                      child: MaterialButton(
                        minWidth: double.infinity,
                        height: 60,
                        onPressed: () {
                          Login(phoneController.text, passwordController.text,
                              auth);
                        },
                        color: const Color.fromARGB(255, 46, 161, 226),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: const Text(
                          "Đăng nhập",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 22,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Text("Bạn chưa có tài khoản ư? "),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  return const SignUpPage();
                                }),
                              );
                            },
                            child: const Text(
                              "Đăng ký ",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 46, 161, 226),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                          ),
                          const Text("tại đây!")
                        ],
                      )),
                  const SizedBox(
                    height: 15,
                  ),
                  Column(
                    children: <Widget>[
                      Row(children: <Widget>[
                        Expanded(
                            child: Container(
                          margin:
                              const EdgeInsets.only(left: 10.0, right: 10.0),
                          child: const Divider(
                            color: Colors.black,
                            height: 20,
                          ),
                        )),
                        const Text("Hoặc sử dụng",
                            style: TextStyle(color: Colors.grey)),
                        Expanded(
                            child: Container(
                          margin:
                              const EdgeInsets.only(left: 10.0, right: 10.0),
                          child: const Divider(
                            color: Colors.black,
                            height: 20,
                          ),
                        )),
                      ]),

                      const SizedBox(
                        height: 10,
                      ),

                      Center(
                        child: FloatingActionButton.extended(
                          heroTag: 'google',
                          onPressed: () => _signInWithGoogle(context),
                          icon: Image.asset('assets/icons/google_icon.png',
                              height: 30, width: 30),
                          label: const Text('Đăng nhập với Google'),
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                        ),
                      ),
                      // ignore: prefer_const_constructors
                      SizedBox(
                        height: 15,
                      ),
                      Center(
                        child: FloatingActionButton.extended(
                          heroTag: 'facebook',
                          onPressed: () => _signInWithFacebook(context),
                          icon: Image.asset('assets/icons/facebook_icon.png',
                              height: 30, width: 30),
                          label: const Text('Đăng nhập với Facebook'),
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }

  void Login(String phone, String password, AuthBase authBase) {
    try {
      LoginUser loginUser = LoginUser(phone: phone, password: password);
      CallAPI().callLoginAPI(loginUser, context);
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  Future<void> _signInWithGoogle(BuildContext context) async {
    try {
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth.signInWithGoogle();
    }
    on Exception catch (e) {
      _showSignInError (context, e);
    }

  }

  Future<void> _signInWithFacebook(BuildContext context) async {
    try {
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth.signInWithFacebook();
    } on FirebaseException catch (e) {
      // ignore: avoid_print
      print(e.message);
    }
  }

  void _showSignInError(BuildContext context, Exception e) {
    if (e is PlatformException && e.code == "ERROR_ABORTED_BY_USER") {
      return;
    }
    showExceptionAlertDialog(context, title: "Sign In failed", exception: e);
  }
}

//create text field
Widget inputPhone(
    {label,
    obscureText = false,
    required TextEditingController phoneController}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        label,
        style: const TextStyle(
            fontSize: 17, fontWeight: FontWeight.w400, color: Colors.black87),
      ),
      const SizedBox(height: 5),
      TextField(
        obscureText: obscureText,
        controller: phoneController,
        decoration: const InputDecoration(
            hintText: 'Số điện thoại',
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

Widget inputPassword(
    {label,
    obscureText = false,
    required TextEditingController passwordController}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        label,
        style: const TextStyle(
            fontSize: 17, fontWeight: FontWeight.w400, color: Colors.black87),
      ),
      const SizedBox(height: 5),
      TextField(
        controller: passwordController,
        obscureText: obscureText,
        decoration: const InputDecoration(
            hintText: 'Mật khẩu',
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
