import 'package:kiwigames/games/bete_du_gevaudan/utils/constant/constant_color.dart';
import 'package:flutter/material.dart';

class ButtonNamePlayer extends StatelessWidget {
  final Key? key;
  final String playerName;
  final double height, padding;

  ButtonNamePlayer(
      {this.key, this.playerName: "", this.height: 60, this.padding: 20});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: key,
      height: height,
      padding: EdgeInsets.symmetric(horizontal: padding),
      decoration: BoxDecoration(
        color: ConstantColor.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Center(
        child: Text(
          playerName,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
    );
  }
}
