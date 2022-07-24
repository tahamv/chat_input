import 'package:flutter/cupertino.dart';

class Line extends StatelessWidget {
  const Line({required this.height, required this.width, required this.color, this.isVertical = true, Key? key}) : super(key: key);

  final double height;

  final double width;

  final Color color;
  final bool isVertical;

  @override
  Widget build(BuildContext context) {
    return isVertical
        ? Container(
            color: color,
            width: 2,
            height: height,
            alignment: Alignment.center,
          )
        : Container(
            color: color,
            width: width,
            height: 2,
            alignment: Alignment.center,
          );
  }
}
