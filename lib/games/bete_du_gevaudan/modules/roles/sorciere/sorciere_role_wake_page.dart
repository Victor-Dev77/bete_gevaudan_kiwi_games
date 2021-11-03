import 'package:get/get.dart';
import 'package:kiwigames/games/bete_du_gevaudan/model/server.dart';
import 'package:kiwigames/games/bete_du_gevaudan/modules/player/player_controller.dart';
import 'package:kiwigames/games/bete_du_gevaudan/modules/widgets_global/button_action_game.dart';
import 'package:kiwigames/games/bete_du_gevaudan/utils/constant/constant_color.dart';
import 'package:flutter/material.dart';
import 'sorciere_role_controller.dart';

class SorciereRoleWakePage extends GetView<SorciereRoleController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Tour: ${PlayerController.to.gameTour}",
              style: TextStyle(
                color: ConstantColor.white,
                fontSize: 22,
              ),
            ),
            SizedBox(height: 20),
            ButtonActionGame(
              onTap: () => Server.instance.nextPage(GameTour.SORCIERE_SLEEP),
              isActive: true,
              text: "SUIVANT",
            ),
          ],
        ),
      ),
    );
  }
}
