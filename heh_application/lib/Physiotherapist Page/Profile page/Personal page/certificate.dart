import 'package:flutter/material.dart';
import 'package:heh_application/Login%20page/landing_page.dart';
import 'package:heh_application/Member%20page/Profile%20page/setting.dart';
import 'package:heh_application/models/physiotherapist.dart';
import 'package:heh_application/services/call_api.dart';

import '../../../models/physiotherapist.dart';

class PhysioCertificatePage extends StatefulWidget {
  PhysioCertificatePage({Key? key, this.physiotherapist}) : super(key: key);
  Physiotherapist? physiotherapist;
  @override
  State<PhysioCertificatePage> createState() => _PhysioCertificatePageState();
}

class Problem {
  final String name;

  Problem({required this.name});
}

class _PhysioCertificatePageState extends State<PhysioCertificatePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: FutureBuilder<Physiotherapist>(
                future: CallAPI()
                    .getPhysiotherapistByUserID(sharedCurrentUser!.userID!),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        specialize(
                            label: "Chuyên môn của chuyên viên.",
                            specialize: snapshot.data!.specialize),
                        skill(
                            label: "Kỹ năng của chuyên viên.",
                            skill: snapshot.data!.skill),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 0),
                                child: Container(
                                  padding: const EdgeInsets.only(
                                      top: 10, bottom: 10),
                                  child: MaterialButton(
                                    height: 50,
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const SettingPage()));
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 0),
                                child: Container(
                                  padding: const EdgeInsets.only(
                                      top: 10, bottom: 10),
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
                                                  const SettingPage()));
                                    },
                                    color:
                                        const Color.fromARGB(255, 46, 161, 226),
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
                    );
                  } else {
                    return Text("ABC");
                  }
                })
            // _selectedProblems == null || _selectedProblems.isEmpty
            //     ? Container(
            //         padding: const EdgeInsets.all(10),
            //         alignment: Alignment.centerLeft,
            //         child: const Text(
            //           "Trống",
            //           style: TextStyle(color: Colors.black54),
            //         ))

            //    }
            //    else {
            //      return Center(child: CircularProgressIndicator(),);
            //    }
            //   }
            // ),
            ),
      ),
    );
  }
}

Widget specialize({label, obscureText = false, String? specialize}) {
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
        initialValue: specialize,
        obscureText: obscureText,
        // controller: _firstName,
        decoration: const InputDecoration(
            hintText: 'Chuyên môn',
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

Widget skill({label, obscureText = false, String? skill}) {
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
        initialValue: skill,
        // controller: _email,
        obscureText: obscureText,
        decoration: const InputDecoration(
            hintText: 'Kỹ năng',
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
