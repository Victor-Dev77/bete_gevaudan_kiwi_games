import 'package:chewie/chewie.dart';
import 'package:get/get.dart';
import 'package:kiwigames/games/bete_du_gevaudan/modules/player/player_controller.dart';
import 'package:kiwigames/games/bete_du_gevaudan/utils/constant/constant.dart';
import 'package:kiwigames/games/bete_du_gevaudan/utils/constant/constant_color.dart';
import 'package:flutter/material.dart';
import 'male_alpha_role_controller.dart';

class MaleAlphaRoleSleepPage extends GetView<MaleAlphaRoleController> {
  @override
  Widget build(BuildContext context) {
    controller.changeAudioForSleep();
    return Scaffold(
      body: _buildScreen(),
    );
  }

  _buildScreen() {
    Future.delayed(PlayerController.to.durationChrono, () {
      controller.onClose();
      PlayerController.to.switchGameTour(GameTour.PROTECTEUR_WAKE);
    });
    if (PlayerController.to.player.isPrincipale) {
      return Stack(
        children: [
          Obx(() {
            if (controller.videoCharged)
              return Center(
                child: Chewie(controller: controller.chewieController),
              );
            return Container();
          }),
          Center(
            child: Text(
              Constant.maleAlphaSleep,
              textAlign: TextAlign.center,
              style: TextStyle(color: ConstantColor.white, fontSize: 22),
            ),
          ),
        ],
      );
    }
    if (PlayerController.to.player.isKill)
      return PlayerController.to.killPlayerWidget();
    return PlayerController.to.sleepPlayerPageWidget();
  }
}
