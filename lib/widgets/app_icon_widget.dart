import 'package:flutter/material.dart';

class AppIconWidget extends StatelessWidget {
  final image;
  final widthPct;

  const AppIconWidget({
    Key? key,
    @required this.image,
    this.widthPct = 0.20,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //getting screen size
    var size = MediaQuery.of(context).size;

    //calculating container width
    double imageSize = (size.width * widthPct);

    return Image.asset(
      image,
      height: imageSize,
    );
  }
}
