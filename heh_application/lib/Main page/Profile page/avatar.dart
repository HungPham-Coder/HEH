// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
            fit: StackFit.expand,
            overflow: Overflow.visible,
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
                  child: FlatButton(
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                          side: const BorderSide(color: Colors.white)),
                      color: const Color(0xfff5f6f9),
                      onPressed: () {},
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
