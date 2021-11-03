import 'package:kiwigames/games/bete_du_gevaudan/model/server.dart';
import 'package:kiwigames/games/bete_du_gevaudan/modules/player/player_controller.dart';
import 'package:kiwigames/games/bete_du_gevaudan/modules/widgets_global/button_action_game.dart';
import 'package:kiwigames/games/bete_du_gevaudan/utils/constant/constant.dart';
import 'package:kiwigames/games/bete_du_gevaudan/utils/constant/constant_color.dart';
import 'package:kiwigames/games/bete_du_gevaudan/utils/constant/constant_image.dart';
import 'package:flutter/material.dart';

class RulesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(ConstantImage.backgroundNuitIntro),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: _buildScreen(),
          ),
        ),
      ),
    );
  }

  _buildScreen() {
    if (PlayerController.to.player.isPrincipale)
      return Text(
        Constant.introGameText,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: ConstantColor.white,
            fontSize: 17,
            fontWeight: FontWeight.w600),
      );
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          flex: 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              //ConstantImage.logoImage,
              SizedBox(height: 20),
              Text(
                "LA BETE DU GEVAUDAN",
                style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                  color: ConstantColor.white,
                ),
              ),
            ],
          ),
        ),
        Expanded(flex: 3, child: Container()),
        Expanded(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                if (PlayerController.to.player.isHost)
                  ButtonActionGame(
                    onTap: () => Server.instance.startGame(),
                    text: "Jouer",
                  ),
                Container(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
