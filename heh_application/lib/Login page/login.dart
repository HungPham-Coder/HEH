import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:heh_application/ExceptionDialog/show_exception_alert_dialog.dart';
import 'package:heh_application/ForgotPassword%20Page/forgotPass.dart';
import 'package:heh_application/Login%20page/landing_page.dart';
import 'package:heh_application/SignUp%20Page/signup.dart';
import 'package:heh_application/models/login_user.dart';
import 'package:heh_application/models/sign_up_user.dart';
import 'package:heh_application/services/auth.dart';
import 'package:heh_application/services/call_api.dart';
import 'package:heh_application/services/stream_test.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/result_login.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isObscure = false;
  bool _submitted = false;

  @override
  void initState() {
    super.initState();
    isObscure = true;
  }

  @override
  void dispose() {
    super.dispose();
    phoneController.dispose();
    passwordController.dispose();
  }

  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String? get _errorText {
    final text = passwordController.value.text;
    if (text.isEmpty) {
      return 'Can\'t be empty';
    }
    if (text.length < 4) {
      return 'Too short';
    }
    return null;
  }

  void _submit() {
    setState(() => _submitted = true);
    if (_errorText == null) {}
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return Scaffold(
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
                      const SizedBox(height: 10),
                      Container(
                        height: MediaQuery.of(context).size.height / 4,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                    "https://firebasestorage.googleapis.com/v0/b/healthcaresystem-98b8d.appspot.com/o/image%2Fwelcome2.png?alt=media&token=e26f1d4f-e548-406c-aa71-65c099663f85"))),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Column(
                          children: <Widget>[
                            inputPhone(
                                obscureText: false,
                                label: "",
                                phoneController: phoneController),
                            inputPassword(
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
                                      return ForgotPassword(
                                        auth: auth,
                                      );
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
                          child: MaterialButton(
                            minWidth: double.infinity,
                            height: 60,
                            onPressed: () {
                              Login(phoneController.text,
                                  passwordController.text, auth);
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
                              const Text("Bạn chưa có tài khoản ? "),
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

                      // Row(children: <Widget>[
                      //   Expanded(
                      //       child: Container(
                      //     margin:
                      //         const EdgeInsets.only(left: 10.0, right: 10.0),
                      //     child: const Divider(
                      //       color: Colors.black,
                      //       height: 20,
                      //     ),
                      //   )),
                      //   const Text("Hoặc sử dụng",
                      //       style: TextStyle(color: Colors.grey)),
                      //   Expanded(
                      //       child: Container(
                      //     margin:
                      //         const EdgeInsets.only(left: 10.0, right: 10.0),
                      //     child: const Divider(
                      //       color: Colors.black,
                      //       height: 20,
                      //     ),
                      //   )),
                      // ]),

                      // mainAxisAlignment: MainAxisAlignment.start,
                      // children: <Widget>[
                      //   Container(
                      //     height: MediaQuery
                      //         .of(context)
                      //         .size
                      //         .height / 4,
                      //     decoration: const BoxDecoration(
                      //         image: DecorationImage(
                      //             image: AssetImage(
                      //                 "assets/images/welcome.jpg"))),
                      //   ),

                      Column(
                        children: <Widget>[
                          Row(children: <Widget>[
                            Expanded(
                                child: Container(
                              margin: const EdgeInsets.only(
                                  left: 10.0, right: 10.0),
                              child: const Divider(
                                color: Colors.black,
                                height: 20,
                              ),
                            )),
                            const Text("Hoặc sử dụng",
                                style: TextStyle(color: Colors.grey)),
                            Expanded(
                                child: Container(
                              margin: const EdgeInsets.only(
                                  left: 10.0, right: 10.0),
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
                              onPressed: () => _signInWithGoogle(),
                              icon: Image.network(
                                  'https://firebasestorage.googleapis.com/v0/b/healthcaresystem-98b8d.appspot.com/o/icon%2Fgoogle_icon.png?alt=media&token=6234a131-fc34-4cd6-b596-beba7b1c3a46',
                                  height: 30,
                                  width: 30),
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
                              onPressed: () => _signInWithFacebook(),
                              icon: Image.network(
                                  'https://firebasestorage.googleapis.com/v0/b/healthcaresystem-98b8d.appspot.com/o/icon%2Ffacebook_icon.png?alt=media&token=412d4a7e-32b4-49bc-9e94-ff7a294703b3',
                                  height: 30,
                                  width: 30),
                              label: const Text('Đăng nhập với Facebook'),
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ]),
        )));
  }

  Future<void> Login(String phone, String password, AuthBase authBase) async {
    try {
      final auth = Provider.of<AuthBase>(context, listen: false);
      final stream = StreamTest.instance;
      LoginUser loginUser = LoginUser(phone: phone, password: password);
      ResultLogin? resultLogin = await CallAPI().callLoginAPI(loginUser);
      if (resultLogin != null) {
        //add login stream to manage login state

        //add signup user to manage user object xuyen suot app
        // await  stream.addSignUpStream(signUpUser);
        await auth.signInAnonymously();

        await stream.addLoginStream(resultLogin);
      }
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  Future<void> _signInWithGoogle() async {
    try {
      final auth = Provider.of<AuthBase>(context, listen: false);
      final stream = StreamTest.instance;
      User? user = await auth.signInWithGoogle();
      // await user!.reload();
      var email;
      for (var field in user!.providerData) {
        email = field.email;
      }
      // DateTime? dateTime = "2023-03-27";

      SignUpUser signUpUser = SignUpUser(
          firstName: user.displayName,
          lastName: 'lastName',
          phone: '1234567890',
          password: '123456789',
          email: email,
          gender: true,
          // dob: DateFormat('yyyy-MM-dd').format(dateTime as DateTime),
          address: "abc",
          image: user.photoURL);
      bool checkUserExist = await auth.checkUserExistInPostgre(email);

      if (checkUserExist == false) {
        await CallAPI().callRegisterAPI(signUpUser);

        // else {
        //   LoginPage();
        // }
      } else {}

      ResultLogin resultLogin = ResultLogin(
        userID: email,
        firstName: user.displayName,
        lastName: "google",
        phoneNumber: user.phoneNumber,
      );

      // await  stream.addSignUpStream(signUpUser);

      await stream.addLoginStream(resultLogin);
    } on Exception catch (e) {
      // _showSignInError(e);
    }
  }

  Future<void> _signInWithFacebook() async {
    try {
      final auth = Provider.of<AuthBase>(context, listen: false);
      final stream = StreamTest.instance;
      User? user = await auth.signInWithFacebook();

      var email;
      for (var field in user.providerData) {
        email = field.email;
      }
      print(email);
      bool checkUserExistInPostgre = await auth.checkUserExistInPostgre(email);
      SignUpUser signUpUser = SignUpUser(
          firstName: user.displayName,
          lastName: "facebook",
          phone: "123456",
          password: "facebook",
          email: email,
          gender: true,
          // dob: '2023-04-02T15:07:52.779Z',
          address: "facebook",
          image: user.photoURL);

      if (checkUserExistInPostgre == false) {
        print("register");

        await CallAPI().callRegisterAPI(signUpUser);
        // else {
        //   LoginPage();
        // }
      } else {
        print("da registered roi");
      }
      ResultLogin resultLogin = ResultLogin(
          userID: email,
          firstName: user.displayName,
          phoneNumber: user.phoneNumber,
          lastName: "facebook");

      // await  stream.addSignUpStream(signUpUser);

      await stream.addLoginStream(resultLogin);
    } on FirebaseException catch (e) {
      // ignore: avoid_print
      print(e.message);
    }
  }

  void _showSignInError(Exception e) {
    if (e is PlatformException && e.code == "ERROR_ABORTED_BY_USER") {
      return;
    }
    showExceptionAlertDialog(context, title: "Sign In failed", exception: e);
  }

//create text field
  Widget inputPhone(
      {label,
      obscureText = true,
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
        TextFormField(
          keyboardType: TextInputType.phone,
          obscureText: obscureText,
          controller: phoneController,
          decoration: const InputDecoration(
              label: Text("Số điện thoại"),
              // hintText: 'Số điện thoại',
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

  Widget inputPassword({required TextEditingController passwordController}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 5),
        TextFormField(
          controller: passwordController,
          validator: (value) {
            value == 0 ? 'Password cannot be blank' : null;
          },
          obscureText: isObscure,
          decoration: InputDecoration(
              label: const Text("Mật khẩu"),
              suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      isObscure = !isObscure;
                    });
                  },
                  icon: Icon(
                      isObscure ? Icons.visibility_off : Icons.visibility)),
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
