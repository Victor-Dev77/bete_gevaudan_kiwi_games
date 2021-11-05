import 'package:chewie/chewie.dart';
import 'package:get/get.dart';
import 'package:kiwigames/games/bete_du_gevaudan/modules/player/player_controller.dart';
import 'package:kiwigames/games/bete_du_gevaudan/utils/constant/constant.dart';
import 'package:kiwigames/games/bete_du_gevaudan/utils/constant/constant_color.dart';
import 'package:flutter/material.dart';
import 'marieuse_role_controller.dart';

class MarieuseRoleSleepPage extends GetView<MarieuseRoleController> {
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
      PlayerController.to.switchGameTour(GameTour.MEDIUM_WAKE);
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
              Constant.marieuseSleep,
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
