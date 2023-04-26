import 'package:flutter/material.dart';
import 'package:heh_application/common_widget/error_container.dart';

class ImageViewPage extends StatefulWidget {
  ImageViewPage({Key? key, required this.imageSrc}) : super(key: key);

  String imageSrc;

  @override
  State<ImageViewPage> createState() => _ImageViewPageState();
}

class _ImageViewPageState extends State<ImageViewPage>
    with SingleTickerProviderStateMixin {
  late TransformationController transform;
  late AnimationController animationController;
  Animation<Matrix4>? animation;

  @override
  void initState() {
    super.initState();
    transform = TransformationController();
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200))
      ..addListener(() => transform.value = animation!.value);
  }

  @override
  void dispose() {
    transform.dispose();
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double minScale = 1;
    double maxScale = 5;
    return Scaffold(
      backgroundColor: Colors.grey[700],
      appBar: AppBar(
        automaticallyImplyLeading: true,
        // elevation: 10,
        backgroundColor: Colors.grey[700],
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 5, right: 5, bottom: 20),
        alignment: Alignment.center,
        child: InteractiveViewer(
          transformationController: transform,
          clipBehavior: Clip.none,
          minScale: minScale,
          maxScale: maxScale,
          // onInteractionEnd: (details) {
          //   resetAnimation();
          // },
          child: Image.network(
            widget.imageSrc,
            // width: ,
            fit: BoxFit.fitHeight,
            loadingBuilder: (BuildContext ctx, Widget child,
                ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) return child;
              return Container(
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
                width: 200,
                height: 200,
                child: Center(
                  child: CircularProgressIndicator(
                    color: Colors.lightBlueAccent,
                    value: loadingProgress.expectedTotalBytes != null &&
                            loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                ),
              );
            },
            errorBuilder: (context, object, stackTrace) => errorContainer(),
          ),
        ),
      ),
    );
  }

  // void resetAnimation() {
  //   animation = Matrix4Tween(
  //     begin: transform.value,
  //     end: Matrix4.identity(),
  //   ).animate(
  //       CurvedAnimation(parent: animationController, curve: Curves.bounceIn));
  //   animationController.forward(from: 0);
  // }
}
