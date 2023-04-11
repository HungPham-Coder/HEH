import 'dart:async';

import 'package:flutter/material.dart';
import 'package:heh_application/Welcome%20page/modelSlide.dart';
import 'package:heh_application/Welcome%20page/slide.dart';
import 'package:heh_application/Welcome%20page/slideDot.dart';

class WelcomePage extends StatefulWidget {
  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  int currentPage = 0;
  final PageController page = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (currentPage < 2) {
        currentPage++;
      } else {
        currentPage = 0;
      }
      page.animateToPage(currentPage,
          duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
    });
  }

  @override
  void dispose() {
    super.dispose();
    page.dispose();
  }

  onPageChanged(int index) {
    setState(() {
      currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Stack(alignment: AlignmentDirectional.center, children: [
      Column(
        children: [
          PageView.builder(
              scrollDirection: Axis.horizontal,
              controller: page,
              onPageChanged: onPageChanged,
              itemCount: slideList.length,
              itemBuilder: (context, index) => SlideItem(index)),
          Stack(
            children: [
              Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (int i = 0; i < slideList.length; i++)
                      if (i == currentPage) SlideDot(true) else SlideDot(false)
                  ],
                ),
              )
            ],
          )
        ],
      )
    ]));
  }
}
