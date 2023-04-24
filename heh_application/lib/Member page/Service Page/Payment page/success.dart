import 'package:flutter/material.dart';
import 'package:heh_application/Login%20page/landing_page.dart';
import 'package:heh_application/Member%20page/navigation_main.dart';
import 'package:lottie/lottie.dart';

class SuccessPage extends StatefulWidget {
  const SuccessPage({Key? key}) : super(key: key);

  @override
  State<SuccessPage> createState() => _SuccessPageState();
}

class _SuccessPageState extends State<SuccessPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Không thể trở về trang trước.'),
            backgroundColor: Colors.red,
          ));
          return false;
        },
        child: Scaffold(
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 60,
                              child: Lottie.network(
                                  'https://assets8.lottiefiles.com/packages/lf20_3wo4gag4.json',
                                  repeat: false),
                            ),
                            const Text("Hoàn thành",
                                style: TextStyle(
                                    fontSize: 23, fontWeight: FontWeight.w700)),
                            const SizedBox(height: 50),
                            const Text(
                                "Lưu ý: Quá trình chuyển khoảng của Quý Khách sẽ được xác nhận trong vòng 24h.",
                                style: TextStyle(
                                    fontSize: 14, fontStyle: FontStyle.italic)),
                            const SizedBox(height: 10),
                            const Text(
                                "Nếu Quý Khách không thanh toán đúng thời hạn thì việc đặt lịch sẽ bị hủy bỏ!",
                                style: TextStyle(
                                    fontSize: 14, fontStyle: FontStyle.italic)),
                            const SizedBox(height: 10),
                            const Text(
                                "Cảm ơn quý khách đã sử dụng dịch vụ của chúng tôi.",
                                style: TextStyle(
                                    fontSize: 14, fontStyle: FontStyle.italic)),
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
                  Navigator.popUntil(context, ModalRoute.withName('/landing'));
                },
                child: const Text(
                  "Trở về trang chủ",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],

          ),
        ))));
  }
}

class returnHome extends StatelessWidget {
  const returnHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
          backgroundColor: const MaterialStatePropertyAll<Color>(
            Color.fromARGB(255, 46, 161, 226),
          ),
          padding: MaterialStateProperty.all(
              const EdgeInsets.symmetric(horizontal: 100, vertical: 15)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
                side: const BorderSide(color: Colors.white)),
          )),
      onPressed: () {
        // Navigator.pushAndRemoveUntil(context,
        //     MaterialPageRoute(builder: (BuildContext context) {
        //   return const LandingPage();
        // }), (r) {
        //   return false;
        // });
        Navigator.pop(context);
      },
      child: const Text(
        "Trở về trang chủ",
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}
