import 'package:flutter/material.dart';
import 'package:heh_application/Login%20page/landing_page.dart';

import 'package:heh_application/Video%20call%20page/VideoCall.dart';
import 'package:heh_application/models/booking_detail.dart';
import 'package:heh_application/services/call_api.dart';
import 'package:intl/intl.dart';

class ServicePaidPage extends StatefulWidget {
  const ServicePaidPage({Key? key}) : super(key: key);

  @override
  State<ServicePaidPage> createState() => _ServicePaidPageState();
}

class _ServicePaidPageState extends State<ServicePaidPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Lịch đặt hẹn",
          style: TextStyle(fontSize: 23),
        ),
        elevation: 10,
        backgroundColor: const Color.fromARGB(255, 46, 161, 226),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            const Center(
              child: Text("Danh sách các lịch bạn đã đặt."),
            ),
            FutureBuilder<List<BookingDetail>>(
                future: CallAPI()
                    .getAllBookingDetailByUserID(sharedCurrentUser!.userID!),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        DateTime tempDate = new DateFormat("yyyy-MM-dd").parse(
                            snapshot.data![index].bookingSchedule!.schedule!
                                .slot.timeStart);
                        String day = DateFormat("dd-MM-yyyy").format(tempDate);
                        DateTime tempStart =
                            new DateFormat("yyyy-MM-ddTHH:mm:ss").parse(snapshot
                                .data![index]
                                .bookingSchedule!
                                .schedule!
                                .slot
                                .timeStart);
                        String start = DateFormat("HH:mm").format(tempStart);
                        DateTime tempEnd = new DateFormat("yyyy-MM-ddTHH:mm:ss")
                            .parse(snapshot.data![index].bookingSchedule!
                                .schedule!.slot.timeEnd);
                        String end = DateFormat("HH:mm").format(tempEnd);
                        return ServicePaid(
                          icon:
                              "https://firebasestorage.googleapis.com/v0/b/healthcaresystem-98b8d.appspot.com/o/icon%2Fappointment.png?alt=media&token=647e3ff8-d708-4b77-b1e2-64444de5dad0",
                          name:
                              "${snapshot.data![index].bookingSchedule!.schedule!.typeOfSlot.typeName}",
                          date: "$day",
                          time: "$start - $end",
                          bookedFor:
                              "${snapshot.data![index].bookingSchedule!.subProfile!.relationship!.relationName}",
                          press: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ServicePaidPage()));
                          },
                        );
                      },
                    );
                  } else {
                    return Center(
                      child: Text(
                          'Hiện tại bạn đang chưa đăng ký bất kỳ lịch nào'),
                    );
                  }
                }),
          ],
        ),
      )),
    );
  }
}

class ServicePaid extends StatelessWidget {
  const ServicePaid({
    Key? key,
    required this.time,
    required this.name,
    required this.icon,
    required this.press,
    required this.date,
    required this.bookedFor,
  }) : super(key: key);

  final String icon, name, time, bookedFor, date;
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    // ignore: duplicate_ignore
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                  border: Border.all(
                    width: 2,
                    color: const Color.fromARGB(255, 46, 161, 226),
                  ),
                  borderRadius: BorderRadius.circular(15),
                  color: const Color.fromARGB(255, 235, 241, 245)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(
                    icon,
                    width: 40,
                    height: 50,
                  ),
                  const SizedBox(width: 15),
                  SizedBox(
                      width: MediaQuery.of(context).size.width / 1.7,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Text(
                                "Ngày đặt: ",
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                              Text(
                                date,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Text(
                                "Khung giờ: ",
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                              Text(
                                time,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Text(
                                "Đặt cho: ",
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                              Text(
                                bookedFor,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          const button(),
                        ],
                      )),
                ],
              )),
        ],
      ),
    );
  }
}

class button extends StatefulWidget {
  const button({Key? key}) : super(key: key);

  @override
  State<button> createState() => _buttonState();
}

class _buttonState extends State<button> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          child: ElevatedButton(
            style: ButtonStyle(
                backgroundColor: const MaterialStatePropertyAll(
                    Color.fromARGB(255, 210, 158, 36)),
                padding: MaterialStateProperty.all(const EdgeInsets.all(15)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: const BorderSide(color: Colors.white)),
                )),
            onPressed: () {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) =>
              //             const TimeResultPage()));
            },
            child: const Text("Xem hóa đơn",
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700)),
          ),
        ),
        const SizedBox(width: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          child: ElevatedButton(
            style: ButtonStyle(
                backgroundColor: const MaterialStatePropertyAll(Colors.green),
                padding: MaterialStateProperty.all(const EdgeInsets.all(15)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: const BorderSide(color: Colors.white)),
                )),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => VideoCallPage()));
            },
            child: const Text(
              "Tham gia",
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ],
    );
  }
}
