import 'package:flutter/material.dart';
import 'package:heh_application/Physiotherapist%20Page/Physio%20page/Profile%20Page/Personal%20page/certificate.dart';
import 'package:heh_application/Physiotherapist%20Page/Physio%20page/Profile%20Page/Personal%20page/information.dart';

class PhysioPersonalPage extends StatefulWidget {
  const PhysioPersonalPage({Key? key}) : super(key: key);

  @override
  State<PhysioPersonalPage> createState() => _PhysioPersonalPageState();
}

class _PhysioPersonalPageState extends State<PhysioPersonalPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.of(context).pop(),
              ),
              automaticallyImplyLeading: true,
              title: const Text(
                "Tài khoản của bạn",
                style: TextStyle(fontSize: 23),
              ),
              bottom: const TabBar(
                unselectedLabelColor: Colors.black,
                tabs: [
                  Tab(text: "Thông tin chính"),
                  Tab(text: "Thông tin khác"),
                ],
              ),
              elevation: 10,
              backgroundColor: const Color.fromARGB(255, 46, 161, 226),
            ),
            body: const TabBarView(
                children: [PhysioInformationPage(), CertificatePage()])),
      ),
    );
  }
}
