import 'package:kiwigames/games/bete_du_gevaudan/modules/player/player_controller.dart';
import 'package:kiwigames/games/bete_du_gevaudan/modules/widgets_global/button_action_game.dart';
import 'package:kiwigames/games/bete_du_gevaudan/utils/constant/constant_color.dart';
import 'package:flutter/material.dart';

class MediumRoleSleepPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Center(
                child: Column(
                  children: [
                    Text(
                      PlayerController.to.player.nameTypePlayer,
                      style:
                          TextStyle(color: ConstantColor.white, fontSize: 22),
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
            ),
            Expanded(
              flex: 3,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    "FERMEZ LES YEUX, VOUS DORMEZ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: ConstantColor.white,
                      fontSize: 22,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: ButtonActionGame(
                  onTap: () => PlayerController.to
                      .switchGameTour(GameTour.MALE_ALPHA_WAKE),
                  isActive: true,
                  text: "SUIVANT",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
