// import 'package:flutter/material.dart';
// import 'package:heh_application/Login%20page/login.dart';
// import 'package:heh_application/services/auth.dart';
// import 'package:provider/provider.dart';
//
// import 'Login page/landing_page.dart';
// import 'SignUp Page/signup.dart';
// class WelcomePage extends StatelessWidget {
//   const WelcomePage({Key? key}) : super(key: key);
//
//   static Widget create (BuildContext context){
//     return WelcomePage();
//   }
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//
//
//
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Container(
//           width: MediaQuery.of(context).size.width,
//           height: MediaQuery.of(context).size.height,
//           padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               Column(
//                 children: const <Widget>[
//                   Text("HEALTH CARE AND HEALING SYSTEM",
//                       style: TextStyle(fontSize: 35, fontFamily: 'Roadbrush')),
//                   SizedBox(height: 0),
//                 ],
//               ),
//               Container(
//                 height: MediaQuery.of(context).size.height / 2,
//                 decoration: const BoxDecoration(
//                     image: DecorationImage(
//                         image: AssetImage("assets/images/welcome.jpg"))),
//               ),
//               Column(
//                 children: <Widget>[
//                   MaterialButton(
//                     minWidth: double.infinity,
//                     height: 60,
//                     onPressed: () {
//                       Navigator.push(context,
//                           MaterialPageRoute(builder: (context) {
//                             return const LandingPage();
//                           }));
//
//                     },
//                     shape: RoundedRectangleBorder(
//                         side: const BorderSide(color: Colors.black),
//                         borderRadius: BorderRadius.circular(50)),
//                     child: const Text(
//                       "Đăng nhập",
//                       style:
//                       TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   MaterialButton(
//                     minWidth: double.infinity,
//                     height: 60,
//                     onPressed: () {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => const SignUpPage()));
//                     },
//                     color: const Color.fromARGB(255, 46, 161, 226),
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(50)),
//                     child: const Text(
//                       "Tạo tài khoản",
//                       style: TextStyle(
//                           fontWeight: FontWeight.w600,
//                           fontSize: 18,
//                           color: Colors.white),
//                     ),
//                   )
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }