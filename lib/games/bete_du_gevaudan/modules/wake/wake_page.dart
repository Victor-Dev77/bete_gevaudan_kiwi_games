import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiwigames/games/bete_du_gevaudan/modules/player/player_controller.dart';
import 'package:kiwigames/games/bete_du_gevaudan/utils/constant/constant.dart';
import 'package:kiwigames/games/bete_du_gevaudan/utils/constant/constant_color.dart';

class WakePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildScreen(),
    );
  }

  _buildScreen() {
    Future.delayed(Duration(seconds: 3),
        () => PlayerController.to.switchGameTour(GameTour.VOTE));
    if (PlayerController.to.player.isPrincipale) {
      return Container(
        color: ConstantColor.black,
        child: Center(
          child: Text(
            Constant.wakeNoKill,
            textAlign: TextAlign.center,
            style: TextStyle(color: ConstantColor.white, fontSize: 22),
          ),
        ),
      );
    }
    return PlayerController.to.sleepPlayerPageWidget();
  }
}
