import 'package:kiwigames/games/bete_du_gevaudan/utils/constant/constant_color.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class ButtonTypePlayer extends StatelessWidget {
  final Key? key;
  final Widget child;
  final double size, borderRadius;
  final Color color;

  ButtonTypePlayer(
      {this.key,
      required this.child,
      this.size: 100,
      this.borderRadius: 20,
      this.color: ConstantColor.white});

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      key: key,
      angle: -math.pi / 4,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Transform.rotate(
          angle: math.pi / 4,
          child: Center(
            child: child,
          ),
        ),
      ),
    );
  }
}
