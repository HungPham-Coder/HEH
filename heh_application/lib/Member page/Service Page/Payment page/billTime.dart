import 'package:flutter/material.dart';
import 'package:heh_application/Member%20page/Service%20Page/Advise%20page/result.dart';

import 'package:heh_application/Member%20page/Service%20Page/Payment%20page/paymentTime.dart';

class BillTimePage extends StatefulWidget {
  const BillTimePage({Key? key}) : super(key: key);

  @override
  State<BillTimePage> createState() => _BillTimePageState();
}

class _BillTimePageState extends State<BillTimePage> {
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
                      children: [
                        const Center(
                            child: Text("Xác nhận hóa đơn",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500))),
                        const SizedBox(height: 20),
                        information(name: "ID:", info: "347238947239847"),
                        padding(),
                        information(
                            name: "Tên chuyên viên:", info: "Nguyễn Văn A"),
                        padding(),
                        information(
                            name: "Tên người đặt:", info: "Nguyễn Văn B"),
                        padding(),
                        information(
                            name: "Tên người được điều trị:",
                            info: "Nguyễn Văn C"),
                        padding(),
                        information(name: "Buổi điều trị:", info: "Buổi ABC"),
                        padding(),
                        information(name: "Ngày điều trị:", info: "04-11-2023"),
                        padding(),
                        information(name: "Thời gian bắt đầu:", info: "11:30"),
                        padding(),
                        information(name: "Thời gian kết thúc:", info: "12:30"),
                        padding(),
                        information(name: "Số tiền:", info: "100.000 VNĐ"),
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
                    onPressed: () {
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
  String name, info;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(name),
          Text(info, style: const TextStyle(fontWeight: FontWeight.w600)),
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
