import 'package:flutter/material.dart';
import 'package:heh_application/Welcome%20page/modelSlide.dart';

class SlideItem extends StatelessWidget {
  late final int index;
  SlideItem(this.index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
              color: const Color.fromARGB(179, 196, 196, 196),
              shape: BoxShape.rectangle,
              image: DecorationImage(
                  image: NetworkImage(slideList[index].imageURL),
                  fit: BoxFit.cover)),
        ),
        const Center(child: SizedBox(height: 50)),
        Text(slideList[index].title),
        const Center(child: SizedBox(height: 50)),
        Text(slideList[index].description),
      ],
    ));
  }
}
