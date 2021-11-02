import 'package:kiwigames/games/bete_du_gevaudan/utils/constant/constant_color.dart';
import 'package:flutter/material.dart';

class ButtonNameDeadPlayer extends StatelessWidget {
  final Key? key;
  final String playerName;
  final double height, padding, opacity;

  ButtonNameDeadPlayer(
      {this.key,
      this.playerName: "",
      this.height: 60,
      this.padding: 20,
      this.opacity: 0.3});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      key: key,
      opacity: opacity,
      child: Container(
        height: height,
        padding: EdgeInsets.symmetric(horizontal: padding),
        decoration: BoxDecoration(
            color: ConstantColor.transparent,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: ConstantColor.white)),
        child: Center(
          child: Text(
            playerName,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: ConstantColor.white),
          ),
        ),
      ),
    );
  }
}
