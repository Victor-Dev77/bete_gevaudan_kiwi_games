import 'package:kiwigames/games/bete_du_gevaudan/utils/constant/constant_color.dart';
import 'package:flutter/material.dart';

import 'custom_gradient.dart';

class ButtonStatusGame extends StatelessWidget {
  final Key? key;
  final Widget child;
  final double size;

  ButtonStatusGame({this.key, required this.child, this.size: 110});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: key,
      width: size,
      height: size,
      decoration: BoxDecoration(
        gradient: CustomGradient(),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: child,
      ),
    );
  }
}
