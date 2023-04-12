import 'package:flutter/material.dart';
import 'package:heh_application/Member%20page/Service%20Page/Payment%20page/success.dart';
// import 'package:lottie/lottie.dart';

enum paymentGroup { momo }

class PaymentChoosePage extends StatefulWidget {
  const PaymentChoosePage({Key? key}) : super(key: key);

  @override
  State<PaymentChoosePage> createState() => _PaymentChoosePageState();
}

class _PaymentChoosePageState extends State<PaymentChoosePage> {
  paymentGroup _paymentValue = paymentGroup.momo;
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
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
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
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500)),
                            const SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: const [
                                      Text("Người thanh toán: "),
                                      Text("Nguyễn Văn A",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600)),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15),
                                    child: Container(
                                      height: 1,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text("Số tiền: "),
                                      Row(
                                        children: const [
                                          Text("100,000",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600)),
                                          Text(" VNĐ",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600)),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15),
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
                        child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(15)),
                            child: Column(children: [
                              const SizedBox(height: 10),
                              const Text("Hình thức thanh toán",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500)),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: Column(
                                  children: [
                                    Column(
                                      children: <Widget>[
                                        choose(
                                          name: "MOMO",
                                          icon:
                                              "https://firebasestorage.googleapis.com/v0/b/healthcaresystem-98b8d.appspot.com/o/icon%2Fmomo.png?alt=media&token=96db2edd-a509-416c-8f46-51a5ed8c6ef1",
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ])))
                  ],
                ))),
        bottomSheet: Container(
          color: Colors.black12,
          height: 120,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    Text("Số tiền:",style: TextStyle(fontSize: 15)),
                    Text("100,000 VNĐ",
                        style: TextStyle(fontWeight: FontWeight.w600,fontSize: 17)),
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
        ));
  }
}

class choose extends StatefulWidget {
  choose({Key? key, required this.name, required this.icon}) : super(key: key);

  String name, icon;
  @override
  State<choose> createState() => _chooseState();
}

class _chooseState extends State<choose> {
  paymentGroup _genderValue = paymentGroup.momo;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Radio(
            value: paymentGroup.momo,
            groupValue: _genderValue,
            onChanged: (paymentGroup? value) {
              setState(() {
                _genderValue = value!;
              });
            }),
        Row(
          children: [
            Text(widget.name),
            const SizedBox(width: 10),
            Image.network(
              widget.icon,
              height: 30,
            ),
          ],
        ),
      ],
    );
  }
}
