import 'package:kiwigames/games/bete_du_gevaudan/modules/player/player_controller.dart';
import 'package:kiwigames/games/bete_du_gevaudan/modules/widgets_global/button_action_game.dart';
import 'package:kiwigames/games/bete_du_gevaudan/modules/widgets_global/button_select_player.dart';
import 'package:kiwigames/games/bete_du_gevaudan/utils/constant/constant_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'loup_role_controller.dart';

class LoupRoleWakePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    PlayerController.to.player.nameTypePlayer,
                    style: TextStyle(
                      color: ConstantColor.white,
                      fontSize: 25,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "QUI SERA VOTRE PROCHAINE\nVICTIME ?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: ConstantColor.white,
                      fontSize: 22,
                    ),
                  ),
                  Text(
                    "Tour: ${PlayerController.to.gameTour}",
                    style: TextStyle(
                      color: ConstantColor.white,
                      fontSize: 22,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: GetBuilder<LoupRoleController>(
                  builder: (_) {
                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 2.75,
                      ),
                      itemCount: PlayerController.to.nbPlayerAlive,
                      itemBuilder: (ctx, index) {
                        var player = PlayerController.to.listPlayerAlive[index];
                        return ButtonSelectPlayer(
                          player: player,
                          enabled: _.isPlayer(player),
                          onTap: (_player) => _.clickPlayer(_player),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: GetBuilder<LoupRoleController>(
                  builder: (_) {
                    return ButtonActionGame(
                      onTap: () {
                        print(_.playerSelected);
                        PlayerController.to.switchGameTour(GameTour.WOLF_SLEEP);
                      },
                      isActive: _.playerSelected != null,
                      text: "SUIVANT",
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
