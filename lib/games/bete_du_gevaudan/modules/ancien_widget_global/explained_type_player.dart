import 'package:kiwigames/games/bete_du_gevaudan/modules/player/player_controller.dart';
import 'package:kiwigames/games/bete_du_gevaudan/utils/constant/constant_color.dart';
import 'package:flutter/material.dart';

import 'button_type_player.dart';

class ExplainedTypePlayer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "Vous êtes",
          style: TextStyle(color: ConstantColor.white, fontSize: 22),
        ),
        SizedBox(height: 20),
        Text(
          PlayerController.to.player.nameTypePlayer,
          style: TextStyle(
            fontSize: 27,
            fontWeight: FontWeight.bold,
            color: ConstantColor.white,
          ),
        ),
        SizedBox(height: 30),
        ButtonTypePlayer(
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Container(),//Image.asset(PlayerController.to.player.imageTypePlayer),
          ),
        ),
      ],
    );
  }
}
