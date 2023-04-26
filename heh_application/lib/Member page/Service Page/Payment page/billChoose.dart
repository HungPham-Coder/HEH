import 'package:flutter/material.dart';
import 'package:heh_application/Login%20page/landing_page.dart';
import 'package:heh_application/Member%20page/Service%20Page/Advise%20page/result.dart';
import 'package:heh_application/Member%20page/Service%20Page/Payment%20page/paymentChoose.dart';
import 'package:heh_application/Member%20page/Service%20Page/Payment%20page/paymentTime.dart';
import 'package:heh_application/Member%20page/Service%20Page/Payment%20page/success.dart';
import 'package:heh_application/models/booking_detail.dart';
import 'package:heh_application/models/booking_schedule.dart';
import 'package:heh_application/models/physiotherapist.dart';
import 'package:heh_application/models/schedule.dart';
import 'package:heh_application/models/sub_profile.dart';
import 'package:heh_application/services/call_api.dart';
import 'package:intl/intl.dart';

class BillChoosePage extends StatefulWidget {
  BillChoosePage(
      {Key? key,
      required this.physiotherapist,
      required this.schedule,
      required this.bookingSchedule})
      : super(key: key);
  Physiotherapist physiotherapist;
  Schedule schedule;
  BookingSchedule? bookingSchedule;
  @override
  State<BillChoosePage> createState() => _BillChoosePageState();
}

class _BillChoosePageState extends State<BillChoosePage> {
  String? day;
  String? timeStart;
  String? timeEnd;
  void formatDateAndTime() {
    DateTime tempDate =
        new DateFormat("yyyy-MM-dd").parse(widget.schedule.slot.timeStart);
    day = DateFormat("dd-MM-yyyy").format(tempDate);
    DateTime tempTimeStart = new DateFormat("yyyy-MM-ddTHH:mm:ss")
        .parse(widget.schedule.slot.timeStart);
    timeStart = DateFormat("HH:mm").format(tempTimeStart);

    DateTime tempTimeEnd = new DateFormat("yyyy-MM-ddTHH:mm:ss")
        .parse(widget.schedule.slot.timeEnd);
    timeEnd = DateFormat("HH:mm").format(tempTimeEnd);
    print(timeStart);
    print(timeEnd);
  }

  @override
  void initState() {
    // TODO: implement initState
    formatDateAndTime();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Xác nhận",
          style: TextStyle(fontSize: 23),
        ),
        elevation: 10,
        backgroundColor: const Color.fromARGB(255, 46, 161, 226),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(15)),
                child: Column(children: [
                  const SizedBox(height: 10),
                  Container(
                    height: MediaQuery.of(context).size.height / 11,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                                "https://firebasestorage.googleapis.com/v0/b/healthcaresystem-98b8d.appspot.com/o/image%2Fwelcome3.png?alt=media&token=0fbdd14a-2e64-4ed5-87ab-2733d6180051"))),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Center(
                            child: Text("Xác nhận hóa đơn",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500))),
                        const SizedBox(height: 20),
                        information(
                            name: "ID: ", info: widget.schedule.scheduleID),
                        padding(),
                        information(
                            name: "Tên chuyên viên: ",
                            info: widget.physiotherapist.signUpUser!.lastName!),
                        padding(),
                        information(
                            name: "Tên người đặt: ",
                            info: sharedCurrentUser!.firstName!),
                        padding(),
                        const SizedBox(height: 15),
                        information(
                            name: "Buổi điều trị: ",
                            info: widget.schedule.slot.slotName),
                        padding(),
                        information(name: "Ngày điều trị: ", info: day),
                        padding(),
                        information(
                            name: "Thời gian bắt đầu: ", info: timeStart),
                        padding(),
                        information(
                            name: "Thời gian kết thúc: ", info: timeEnd),
                        padding(),
                        information(
                            name: "Số tiền: ",
                            info: '${widget.schedule.typeOfSlot.price} VND'),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ]),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: const MaterialStatePropertyAll<Color>(
                            Colors.black12),
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.only(
                                left: 25, right: 25, top: 15, bottom: 15)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                              side: const BorderSide(color: Colors.white)),
                        )),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const TimeResultPage()));
                    },
                    child: const Text(
                      "Trở lại",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        padding:
                            MaterialStateProperty.all(const EdgeInsets.all(15)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                              side: const BorderSide(color: Colors.white)),
                        )),
                    onPressed: () async {
                      BookingDetail bookingDetail = BookingDetail(
                          bookingScheduleID:
                              widget.bookingSchedule!.bookingScheduleID!,
                          status: true);
                      bool addBookingDetail =
                          await CallAPI().addBookingDetail(bookingDetail);
                      if (addBookingDetail) {
                        widget.schedule.physioBookingStatus = true;
                        await CallAPI().updateScheduleWithPhysioBookingStatus(
                            widget.schedule);
                      }

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PaymentTimePage()));
                    },
                    child: const Text(
                      "Thanh toán",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class information extends StatelessWidget {
  information({Key? key, required this.name, required this.info})
      : super(key: key);
  String? name, info;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Wrap(
        children: [
          Text(name!),
          Text(info!, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    ]);
  }
}

Widget padding() {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 15),
    child: Container(
      height: 1,
      color: Colors.grey,
    ),
  );
}
