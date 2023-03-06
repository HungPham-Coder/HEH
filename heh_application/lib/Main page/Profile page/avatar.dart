// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AvatarPic extends StatefulWidget {
  const AvatarPic({Key? key}) : super(key: key);

  @override
  State<AvatarPic> createState() => _AvatarPicState();
}

class _AvatarPicState extends State<AvatarPic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(
      children: [
        SizedBox(
          height: 115,
          width: 115,
          child: Stack(
            clipBehavior: Clip.none,
            fit: StackFit.expand,
            children: [
              const CircleAvatar(
                backgroundImage: AssetImage("assets/images/profile.jpg"),
              ),
              Positioned(
                right: -12,
                bottom: 0,
                child: SizedBox(
                  height: 46,
                  width: 46,
                  child: TextButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color(0xfff5f6f9)),
                          padding: MaterialStateProperty.all(EdgeInsets.zero),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                                side: const BorderSide(color: Colors.white)),
                          )),
                      onPressed: () async {},
                      child: SvgPicture.asset(
                        "assets/icons/camera.svg",
                        width: 20,
                        height: 20,
                      )),
                ),
              )
            ],
          ),
        )
      ],
    )));
  }
}
