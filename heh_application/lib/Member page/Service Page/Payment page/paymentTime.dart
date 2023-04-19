import 'package:flutter/material.dart';
import 'package:heh_application/Member%20page/Service%20Page/Payment%20page/success.dart';
// import 'package:lottie/lottie.dart';

// enum paymentGroup { male, female, others }

class PaymentTimePage extends StatefulWidget {
  const PaymentTimePage({Key? key}) : super(key: key);

  @override
  State<PaymentTimePage> createState() => _PaymentTimePageState();
}

class _PaymentTimePageState extends State<PaymentTimePage> {
  // paymentGroup _paymentValue = paymentGroup.male;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Thanh toán",
          style: TextStyle(fontSize: 23),
        ),
        elevation: 10,
        backgroundColor: const Color.fromARGB(255, 46, 161, 226),
      ),
      body: SingleChildScrollView(
          child: SizedBox(
              // height: MediaQuery.of(context).size.height * 2,
              child: Column(
        children: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                                "https://firebasestorage.googleapis.com/v0/b/healthcaresystem-98b8d.appspot.com/o/image%2Fwelcome2.png?alt=media&token=e26f1d4f-e548-406c-aa71-65c099663f85"))),
                  ),
                  const SizedBox(height: 10),
                  const Text("Chi tiết giao dịch",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text("Người thanh toán: "),
                            Text("Nguyễn Văn A",
                                style: TextStyle(fontWeight: FontWeight.w600)),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: Container(
                            height: 1,
                            color: Colors.grey,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Số tiền: "),
                            Row(
                              children: const [
                                Text("100,000",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600)),
                                Text(" VNĐ",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600)),
                              ],
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: Container(
                            height: 1,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
              )),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(children: [
                choose(
                  icon:
                      "https://firebasestorage.googleapis.com/v0/b/healthcaresystem-98b8d.appspot.com/o/icon%2FQR.jpg?alt=media&token=cf838750-d192-44cf-831d-4cf7fc0d1802",
                )
              ])),
          SizedBox(
            height: 130,
          )
        ],
      ))),
      bottomSheet: SizedBox(
        height: 120,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  Text("Số tiền:"),
                  Text("100,000 VNĐ",
                      style: TextStyle(fontWeight: FontWeight.w600)),
                ],
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: const MaterialStatePropertyAll<Color>(
                      Color.fromARGB(255, 46, 161, 226),
                    ),
                    padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(
                            horizontal: 100, vertical: 14)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                          side: const BorderSide(color: Colors.white)),
                    )),
                onPressed: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => const FailPage()));
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SuccessPage()));
                },
                child: const Text(
                  "Thanh toán",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class choose extends StatefulWidget {
  choose({Key? key, required this.icon}) : super(key: key);

  String icon;
  @override
  State<choose> createState() => _chooseState();
}

class _chooseState extends State<choose> {
  // paymentGroup _genderValue = paymentGroup.male;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          const SizedBox(height: 10),
          const Text("Hình thức thanh toán",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Center(
              child: Image.network(
                widget.icon,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
