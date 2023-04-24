import 'package:flutter/material.dart';
import 'package:heh_application/Login%20page/landing_page.dart';
import 'package:heh_application/Member%20page/Profile%20page/Personal%20page/information.dart';
import 'package:heh_application/Member%20page/Profile%20page/Personal%20page/medical.dart';

class PersonalPage extends StatefulWidget {
  const PersonalPage({Key? key}) : super(key: key);

  @override
  State<PersonalPage> createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: const Text(
            "Tài khoản của bạn",
            style: TextStyle(fontSize: 23),
          ),
          bottom: const TabBar(
            tabs: [
              Tab(text: "Thông tin chính"),
              Tab(text: "Thông tin khác"),
            ],
          ),
          elevation: 10,
          backgroundColor: const Color.fromARGB(255, 46, 161, 226),
        ),
        body: TabBarView(children: [
          InformationPage(),
          MedicalPage(
            medicalRecord: sharedMedicalRecord,
          )
        ]),
      ),
    ));
  }
}
