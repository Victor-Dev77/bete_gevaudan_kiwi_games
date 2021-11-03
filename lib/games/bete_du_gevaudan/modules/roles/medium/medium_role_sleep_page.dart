import 'package:chewie/chewie.dart';
import 'package:get/get.dart';
import 'package:kiwigames/games/bete_du_gevaudan/modules/player/player_controller.dart';
import 'package:kiwigames/games/bete_du_gevaudan/utils/constant/constant.dart';
import 'package:kiwigames/games/bete_du_gevaudan/utils/constant/constant_color.dart';
import 'package:flutter/material.dart';
import 'medium_role_controller.dart';

class MediumRoleSleepPage extends StatelessWidget {
  final controller = Get.put(MediumRoleController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildScreen(),
    );
  }

  _buildScreen() {
    Future.delayed(Duration(seconds: 3),
        () => PlayerController.to.switchGameTour(GameTour.MALE_ALPHA_WAKE));
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
              Constant.mediumSleep,
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
