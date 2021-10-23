import 'package:flutter/material.dart';

class HeightSpacer extends StatelessWidget {
  final double height;

  const HeightSpacer(this.height, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
    );
  }
}

class WidthSpacer extends StatelessWidget {
  final double width;

  const WidthSpacer(this.width, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
    );
  }
}
