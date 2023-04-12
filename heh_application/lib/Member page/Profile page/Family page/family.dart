import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:heh_application/Member%20page/Profile%20page/Family%20page/personalFam.dart';
import 'package:heh_application/Member%20page/Profile%20page/Family%20page/signup.dart';
import 'package:intl/intl.dart';

import '../../../models/sub_profile.dart';

class FamilyPage extends StatefulWidget {
   FamilyPage({Key? key, this.listSubProfile}) : super(key: key);
  List<SubProfile>? listSubProfile;
  @override
  State<FamilyPage> createState() => _FamilyPageState();
}

class _FamilyPageState extends State<FamilyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            "Thành viên gia đình",
            style: TextStyle(fontSize: 23),
          ),
          elevation: 10,
          backgroundColor: const Color.fromARGB(255, 46, 161, 226),
        ),
        body: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(height: 20),
              ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: widget.listSubProfile!.length,
                  itemBuilder: (context, index) {
                  DateTime tempDate = new DateFormat("yyyy-MM-dd").parse(widget.listSubProfile![index].signUpUser!.dob!);
                  int age = DateTime.now().year - tempDate.year ;
                  return ProfileMenu(
                    icon:
                        "https://firebasestorage.googleapis.com/v0/b/healthcaresystem-98b8d.appspot.com/o/icon%2Fperson.svg?alt=media&token=7bef043d-fdb5-4c5b-bb2e-644ee7682345",
                    name: "${widget.listSubProfile![index].signUpUser!.firstName}",
                    relationship: "${widget.listSubProfile![index].relationship!.relationName} - ",
                    text: "$age tuổi",
                    press: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const FamilyPersonalPage()));
                    },
                  );
                }
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const SignUpFamilyPage()));
          },
          child: const Icon(Icons.add),
        ));
  }
}

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key? key,
    required this.relationship,
    required this.text,
    required this.name,
    required this.icon,
    required this.press,
  }) : super(key: key);

  final String text, icon, name, relationship;
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    // ignore: duplicate_ignore
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
              padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                    side: const BorderSide(
                        color: Color.fromARGB(255, 46, 161, 226), width: 2)),
              )),
          onPressed: press,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SvgPicture.network(
                icon,
                width: 40,
                color: const Color.fromARGB(255, 46, 161, 226),
              ),
              const SizedBox(width: 20),
              SizedBox(
                  width: MediaQuery.of(context).size.width / 1.9,
                  height: 50,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          name,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            relationship,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          Text(
                            text,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ],
                  )),
              const Icon(Icons.arrow_forward_ios_rounded),
            ],
          )),
    );
  }
}
