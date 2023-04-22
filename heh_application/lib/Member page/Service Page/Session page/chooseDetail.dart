import 'package:flutter/material.dart';
import 'package:heh_application/Member%20page/Service%20Page/Payment%20page/paymentTime.dart';
import 'package:heh_application/models/physiotherapist.dart';
import 'package:heh_application/models/schedule.dart';
import 'package:heh_application/models/slot.dart';
import 'package:heh_application/services/call_api.dart';
import 'package:intl/intl.dart';

class SessonDetailPage extends StatefulWidget {
  SessonDetailPage({Key? key, required this.physiotherapist}) : super(key: key);
  Physiotherapist physiotherapist;
  @override
  State<SessonDetailPage> createState() => _SessonDetailPageState();
}

class _SessonDetailPageState extends State<SessonDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Chọn khung giờ",
          style: TextStyle(fontSize: 23),
        ),
        elevation: 10,
        backgroundColor: const Color.fromARGB(255, 46, 161, 226),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            PhysioProfile(
              image:
                  "https://firebasestorage.googleapis.com/v0/b/healthcaresystem-98b8d.appspot.com/o/icon%2Fphy.png?alt=media&token=bac867bc-190c-4523-83ba-86fccc649622",
              phy: "Chuyên viên",
              name: widget.physiotherapist.signUpUser!.firstName!,
              specialize: "Chuyên môn: ${widget.physiotherapist.specialize}",
              experience: "Kinh nghiệm: ${widget.physiotherapist.skill}",
            ),
            const SizedBox(height: 20),
            Center(
                child: Text("Khung giờ",
                    style: Theme.of(context).textTheme.headline6)),
            const SizedBox(height: 5),
            FutureBuilder<List<Schedule>?>(
                future: CallAPI().getallSlotByPhysiotherapistID(
                    widget.physiotherapist.physiotherapistID),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return PhysioChooseMenu(
                          icon:
                              "https://firebasestorage.googleapis.com/v0/b/healthcaresystem-98b8d.appspot.com/o/icon%2Fphy.png?alt=media&token=bac867bc-190c-4523-83ba-86fccc649622",
                          name: widget.physiotherapist.signUpUser!.firstName!,
                          time: "Khung giờ: ",
                          timeStart: '${snapshot.data![index].slot.timeStart}',
                          timeEnd: '${snapshot.data![index].slot.timeEnd}',
                          price: snapshot.data![index].typeOfSlot.price,
                          press: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const PaymentTimePage()));
                          },
                        );
                      },
                    );
                  } else {
                    return Container(
                      child: Text("Physio dang ban het tat ca cac slot"),
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }
}

class PhysioProfile extends StatelessWidget {
  const PhysioProfile({
    Key? key,
    required this.image,
    required this.phy,
    required this.name,
    required this.specialize,
    required this.experience,

    // required this.time,
  }) : super(key: key);

  final String image, specialize, experience, name, phy;

  @override
  Widget build(BuildContext context) {
    // ignore: duplicate_ignore
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.black)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: SizedBox(
                        height: 100,
                        width: 100,
                        child: Stack(
                          clipBehavior: Clip.none,
                          fit: StackFit.expand,
                          children: const [
                            CircleAvatar(
                                backgroundImage: NetworkImage(
                                    "https://firebasestorage.googleapis.com/v0/b/healthcaresystem-98b8d.appspot.com/o/icon%2Fphy.png?alt=media&token=bac867bc-190c-4523-83ba-86fccc649622")),
                          ],
                        )),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    children: [
                      Text(
                        phy,
                        style: const TextStyle(fontSize: 15),
                      ),
                      Text(name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          )),
                    ],
                  ),
                ],
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      Text(specialize),
                      const SizedBox(height: 20),
                      Text(experience),
                      const SizedBox(height: 20),
                      // Text(time),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

class PhysioChooseMenu extends StatelessWidget {
  PhysioChooseMenu({
    Key? key,
    required this.price,
    required this.time,
    required this.timeStart,
    required this.timeEnd,
    required this.name,
    required this.icon,
    required this.press,
  }) : super(key: key);

  final String icon, name, time;
  final VoidCallback? press;
  String timeStart, timeEnd;
  double price;

  @override
  Widget build(BuildContext context) {
    // ignore: duplicate_ignore
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: TextButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 15)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: const BorderSide(
                              color: Color.fromARGB(255, 46, 161, 226),
                              width: 2)),
                    )),
                onPressed: press,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.network(
                      icon,
                      width: 40,
                      height: 50,
                    ),
                    const SizedBox(width: 10),
                    SizedBox(
                        width: MediaQuery.of(context).size.width / 1.6,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            // SizedBox(
                            //   height: 10,
                            // ),
                            Text(
                              '$time : $timeStart - $timeEnd',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            Text(
                              '$price VND',
                            ),
                          ],
                        )),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Icon(Icons.add, size: 24),
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
