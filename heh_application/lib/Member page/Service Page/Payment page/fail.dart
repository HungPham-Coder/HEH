import 'package:flutter/material.dart';
import 'package:heh_application/Member%20page/navigation_main.dart';
import 'package:lottie/lottie.dart';

class FailPage extends StatefulWidget {
  const FailPage({Key? key}) : super(key: key);

  @override
  State<FailPage> createState() => _FailPageState();
}

class _FailPageState extends State<FailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Kết quả giao dịch",
          style: TextStyle(fontSize: 23),
        ),
        centerTitle: true,
        elevation: 10,
        backgroundColor: const Color.fromARGB(255, 46, 161, 226),
      ),
      body: Center(
        child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 80,
                          child: Lottie.network(
                              'https://assets2.lottiefiles.com/packages/lf20_O6BZqckTma.json',
                              repeat: false),
                        ),
                        const Text("Thanh toán thất bại",
                            style: TextStyle(fontSize: 20)),
                      ]),
                ],
              ),
            )),
      ),
      bottomSheet: SizedBox(
        height: 100,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: const MaterialStatePropertyAll<Color>(
                      Color.fromARGB(255, 46, 161, 226),
                    ),
                    padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(
                            horizontal: 100, vertical: 15)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                          side: const BorderSide(color: Colors.white)),
                    )),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Navigation_Bar()));
                },
                child: const Text(
                  "Trở về trang chủ",
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
