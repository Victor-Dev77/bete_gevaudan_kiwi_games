import 'package:chewie/chewie.dart';
import 'package:get/get.dart';
import 'package:kiwigames/games/bete_du_gevaudan/modules/player/player_controller.dart';
import 'package:kiwigames/games/bete_du_gevaudan/modules/roles/loup/loup_role_controller.dart';
import 'package:kiwigames/games/bete_du_gevaudan/modules/widgets_global/button_action_game.dart';
import 'package:kiwigames/games/bete_du_gevaudan/utils/constant/constant.dart';
import 'package:kiwigames/games/bete_du_gevaudan/utils/constant/constant_color.dart';
import 'package:flutter/material.dart';

class LoupRoleSleepPage extends StatelessWidget {
  final controller = Get.put(LoupRoleController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildScreen(),
    );
  }

  _buildScreen() {
    Future.delayed(Duration(seconds: 3),
        () => PlayerController.to.switchGameTour(GameTour.SORCIERE_WAKE));
    if (PlayerController.to.player.isPrincipale) {
      return Stack(
        children: [
          Obx(() {
            if (controller.videoCharged)
              return Chewie(controller: controller.chewieController);
            return Container();
          }),
          Center(
            child: Text(
              Constant.loupSleep,
              textAlign: TextAlign.center,
              style: TextStyle(color: ConstantColor.white, fontSize: 22),
            ),
          ),
        ],
      );
    }
    return PlayerController.to.sleepPlayerPageWidget();
  }
}
