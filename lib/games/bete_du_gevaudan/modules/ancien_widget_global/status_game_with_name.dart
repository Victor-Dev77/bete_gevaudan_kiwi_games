import 'package:kiwigames/games/bete_du_gevaudan/utils/constant/constant_color.dart';
import 'package:flutter/material.dart';
import 'button_type_player.dart';

class StatusGameWithName extends StatelessWidget {
  final Key? key;
  final String playerName;
  final Widget childTypePlayer;
  final double sizeType;

  StatusGameWithName({
    this.key,
    this.playerName: "",
    required this.childTypePlayer,
    this.sizeType: 45,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      key: key,
      children: <Widget>[
        ButtonTypePlayer(
          size: sizeType,
          borderRadius: 7,
          child: childTypePlayer,
        ),
        SizedBox(width: 20),
        Text(
          playerName,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: ConstantColor.white,
          ),
        )
      ],
    );
  }
}
