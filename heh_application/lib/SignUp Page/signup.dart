import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum genderGroup { male, female, others }

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  genderGroup _value = genderGroup.male;

  final TextEditingController _date = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Sign up",
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
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          height: MediaQuery.of(context).size.height + 35,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Column(
                children: <Widget>[
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Create a new account. It's Free!",
                    style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: ListTile(
                          title: Row(
                            children: const <Widget>[
                              Text(
                                "First name",
                                style: TextStyle(fontSize: 15),
                              ),
                              Text(
                                " *",
                                style: TextStyle(color: Colors.red),
                              ),
                            ],
                          ),
                          subtitle: TextFormField(
                            decoration: const InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey)),
                              hintText: "First name",
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 0,
                      ),
                      Expanded(
                        child: ListTile(
                          title: Row(
                            children: const <Widget>[
                              Text(
                                "Last name",
                                style: TextStyle(fontSize: 15),
                              ),
                              Text(
                                " *",
                                style: TextStyle(color: Colors.red),
                              ),
                            ],
                          ),
                          subtitle: TextFormField(
                            decoration: const InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 10),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey)),
                              hintText: "Last name",
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  email(label: "Email"),
                  phone(label: "Phone number"),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: const <Widget>[
                          Text(
                            "Gender ",
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
                          const Text("Male"),
                          Radio(
                              value: genderGroup.male,
                              groupValue: _value,
                              onChanged: (genderGroup? value) {
                                setState(() {
                                  _value = value!;
                                });
                              }),
                          const Text("Female"),
                          Radio(
                              value: genderGroup.female,
                              groupValue: _value,
                              onChanged: (genderGroup? value) {
                                setState(() {
                                  _value = value!;
                                });
                              }),
                          const Text("Others"),
                          Radio(
                              value: genderGroup.others,
                              groupValue: _value,
                              onChanged: (genderGroup? value) {
                                setState(() {
                                  _value = value!;
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
                          labelText: "Date of birth: ",
                          // icon: Icon(
                          //   Icons.calendar_month,
                          //   color: Colors.black,
                          // ),
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
                  password(label: "Password", obscureText: true),
                  confirmPassword(label: "Confirm password", obscureText: true),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 100),
                  child: Container(
                    padding: const EdgeInsets.only(top: 0),
                    child: MaterialButton(
                      minWidth: double.infinity,
                      height: 50,
                      onPressed: () {},
                      color: const Color.fromARGB(255, 46, 161, 226),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        "Sign up",
                        style: TextStyle(
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
}

// Widget firstName({label, obscureText = false}) {
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: <Widget>[
//       Row(
//         children: <Widget>[
//           Text(
//             label,
//             style: const TextStyle(
//                 fontSize: 15,
//                 fontWeight: FontWeight.w400,
//                 color: Colors.black87),
//           ),
//           const Text(
//             " *",
//             style: TextStyle(color: Colors.red),
//           ),
//         ],
//       ),
//       const SizedBox(height: 5),
//       TextField(
//         obscureText: obscureText,
//         decoration: const InputDecoration(
//             hintText: 'First name',
//             contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
//             enabledBorder: OutlineInputBorder(
//               borderSide: BorderSide(color: Colors.grey),
//             ),
//             border:
//                 OutlineInputBorder(borderSide: BorderSide(color: Colors.grey))),
//       ),
//       const SizedBox(height: 10)
//     ],
//   );
// }

// Widget lastName({label, obscureText = false}) {
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: <Widget>[
//       Row(
//         children: <Widget>[
//           Text(
//             label,
//             style: const TextStyle(
//                 fontSize: 15,
//                 fontWeight: FontWeight.w400,
//                 color: Colors.black87),
//           ),
//           const Text(
//             " *",
//             style: TextStyle(color: Colors.red),
//           ),
//         ],
//       ),
//       const SizedBox(height: 5),
//       TextField(
//         obscureText: obscureText,
//         decoration: const InputDecoration(
//             hintText: 'Last name',
//             contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
//             enabledBorder: OutlineInputBorder(
//               borderSide: BorderSide(color: Colors.grey),
//             ),
//             border:
//                 OutlineInputBorder(borderSide: BorderSide(color: Colors.grey))),
//       ),
//       const SizedBox(height: 10)
//     ],
//   );
// }

Widget email({label, obscureText = false}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
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
        decoration: const InputDecoration(
            hintText: 'Email',
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

Widget phone({label, obscureText = false}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
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
        decoration: const InputDecoration(
            hintText: 'Phone number',
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

// Widget dob({label, obscureText = false}) {
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: <Widget>[
//       Row(
//         children: <Widget>[
//           Text(
//             label,
//             style: const TextStyle(
//                 fontSize: 15,
//                 fontWeight: FontWeight.w400,
//                 color: Colors.black87),
//           ),
//           const Text(
//             " *",
//             style: TextStyle(color: Colors.red),
//           ),
//         ],
//       ),
//       const SizedBox(height: 5),
//       TextField(
//         obscureText: obscureText,
//         decoration: const InputDecoration(
//             hintText: 'DD/MM/YYYY',
//             contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
//             enabledBorder: OutlineInputBorder(
//               borderSide: BorderSide(color: Colors.grey),
//             ),
//             border:
//                 OutlineInputBorder(borderSide: BorderSide(color: Colors.grey))),
//       ),
//       const SizedBox(height: 10)
//     ],
//   );
// }

Widget password({label, obscureText = false}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
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
        decoration: const InputDecoration(
            hintText: 'Password',
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            border:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.grey))),
      ),
      const SizedBox(height: 15)
    ],
  );
}

Widget confirmPassword({label, obscureText = false}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
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
        decoration: const InputDecoration(
            hintText: 'Confirm Password',
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            border:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.grey))),
      ),
      const SizedBox(height: 1)
    ],
  );
}
