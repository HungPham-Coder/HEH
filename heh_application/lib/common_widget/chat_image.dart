import 'package:flutter/material.dart';
import 'package:heh_application/common_widget/image_view.dart';
import 'error_container.dart';

class chatImage extends StatefulWidget {
  chatImage({Key? key, required this.imageSrc}) : super(key: key);

  String imageSrc;

  @override
  State<chatImage> createState() => _chatImageState();
}

class _chatImageState extends State<chatImage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ImageViewPage(imageSrc: widget.imageSrc)));
        },
        child: Container(
          constraints: const BoxConstraints(maxWidth: 225, maxHeight: 225),
          child: Image.network(
            widget.imageSrc,
            fit: BoxFit.fill,
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
        ));
  }
}
