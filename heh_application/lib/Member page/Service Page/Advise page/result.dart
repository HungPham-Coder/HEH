import 'package:flutter/material.dart';
import 'package:heh_application/Login%20page/landing_page.dart';
import 'package:heh_application/Member%20page/Service%20Page/Payment%20page/billChoose.dart';
import 'package:heh_application/Member%20page/Service%20Page/Payment%20page/billTime.dart';
import 'package:heh_application/models/booking_schedule.dart';
import 'package:heh_application/models/schedule.dart';
import 'package:heh_application/models/sub_profile.dart';
import 'package:heh_application/services/call_api.dart';
import 'package:intl/intl.dart';

class TimeResultPage extends StatefulWidget {
  TimeResultPage(
      {Key? key,
      required this.timeStart,
      required this.timeEnd,
      required this.problem,
      required this.subProfile})
      : super(key: key);
  String timeStart;
  String timeEnd;
  String problem;
  SubProfile subProfile;
  @override
  State<TimeResultPage> createState() => _TimeResultPageState();
}

class _TimeResultPageState extends State<TimeResultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            "Kết quả tìm kiếm",
            style: TextStyle(fontSize: 23),
          ),
          elevation: 10,
          backgroundColor: const Color.fromARGB(255, 46, 161, 226),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 20),
                CurrentTime(),
                FutureBuilder<List<Schedule>>(
                    future: CallAPI().getallPhysiotherapistBySlotTimeAndSkill(
                        widget.timeStart, widget.timeEnd, widget.problem),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: snapshot.data!.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              DateTime dateStart = new DateFormat("yyyy-MM-ddTHH:mm:ss").parse(snapshot.data![index].slot.timeStart);
                              String startStr = DateFormat("HH:mm").format(dateStart);
                              DateTime dateEnd = new DateFormat("yyyy-MM-ddTHH:mm:ss").parse(snapshot.data![index].slot.timeEnd);
                              String endStr = DateFormat("HH:mm").format(dateEnd);
                              return PhysioChooseMenu(
                                icon:
                                    "https://firebasestorage.googleapis.com/v0/b/healthcaresystem-98b8d.appspot.com/o/icon%2Fphy.png?alt=media&token=bac867bc-190c-4523-83ba-86fccc649622",
                                name:
                                    "${snapshot.data![index].physiotherapist.signUpUser!.firstName}",
                                time: "Khung giờ: $startStr - $endStr",
                                press: () async {
                                  String date = DateFormat("yyyy-MM-dd").format(DateTime.now());
                                  String time = DateFormat("HH:mm:ss").format(DateTime.now());
                                  BookingSchedule bookingSchedule = BookingSchedule(
                                      userID: sharedCurrentUser!.userID!,
                                      subProfileID: widget.subProfile.profileID!,
                                      scheduleID: snapshot.data![index].scheduleID,
                                      dateBooking: date,
                                      timeBooking: time);

                                 BookingSchedule? bookingScheduleAdd = await CallAPI().addBookingSchedule(bookingSchedule);


                                 Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                               BillChoosePage(physiotherapist: snapshot.data![index].physiotherapist, schedule: snapshot.data![index], bookingSchedule: bookingScheduleAdd)));
                                },
                              );
                            });
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
              ],
            ),
          ),
        ));
  }
}

class PhysioChooseMenu extends StatelessWidget {
  const PhysioChooseMenu({
    Key? key,
    required this.time,
    required this.name,
    required this.icon,
    required this.press,
  }) : super(key: key);

  final String icon, name, time;
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    // ignore: duplicate_ignore
    return Column(
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
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 15)),
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
                  const SizedBox(width: 5),
                  SizedBox(
                      width: MediaQuery.of(context).size.width / 1.6,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            time,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      )),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Icon(Icons.arrow_forward_ios_rounded),
                  ),
                ],
              )),
        ),
      ],
    );
  }
}

class CurrentTime extends StatelessWidget {
  CurrentTime({Key? key}) : super(key: key);

  final TextEditingController _date = TextEditingController();

  String getCurrentDate() {
    var date = DateTime.now().toString();

    var dateParse = DateTime.parse(date);

    var formattedDate =
        "Ngày ${dateParse.day} Tháng ${dateParse.month} Năm ${dateParse.year}";
    return formattedDate.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(getCurrentDate(), style: const TextStyle(fontSize: 20))
        ],
      ),
    );
  }
}
