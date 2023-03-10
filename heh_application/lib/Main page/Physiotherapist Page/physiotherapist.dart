import 'package:flutter/material.dart';
import 'package:heh_application/Main%20page/Physiotherapist%20Page/advisesession.dart';
import 'package:heh_application/Main%20page/Physiotherapist%20Page/longtermtreatment.dart';

class Physiotherapist extends StatefulWidget {
  const Physiotherapist({Key? key}) : super(key: key);

  @override
  State<Physiotherapist> createState() => _PhysiotherapistState();
}

class _PhysiotherapistState extends State<Physiotherapist> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Chuyên viên",
          style: TextStyle(fontSize: 23),
        ),
        elevation: 10,
        backgroundColor: const Color.fromARGB(255, 46, 161, 226),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),
            const Text("Bạn đang cần tim đến dịch vụ của chúng tôi?"),
            const SizedBox(height: 20),
            PhysiptherapistMenu(
              icon: "assets/icons/advise.png",
              text: "Tư vấn một buổi",
              press: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AdviseSession()));
              },
            ),
            PhysiptherapistMenu(
              icon: "assets/icons/physio.png",
              text: "Điều trị lâu dài",
              press: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LongTermTreatment()));
              },
            ),
          ],
        ),
      ),
    );
  }
}

class PhysiptherapistMenu extends StatelessWidget {
  const PhysiptherapistMenu({
    Key? key,
    required this.text,
    required this.icon,
    required this.press,
  }) : super(key: key);

  final String text, icon;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    // ignore: duplicate_ignore
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: TextButton(
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(const Color(0xfff5f6f9)),
              padding: MaterialStateProperty.all(const EdgeInsets.all(15)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: const BorderSide(color: Colors.white)),
              )),
          onPressed: press,
          child: Row(
            children: [
              Image.asset(
                icon,
                width: 60,
              ),
              const SizedBox(
                width: 20,
                height: 10,
              ),
              Expanded(
                  child: Text(
                text,
                style: Theme.of(context).textTheme.titleMedium,
              )),
              const Icon(Icons.arrow_forward_sharp),
            ],
          )),
    );
  }
}
