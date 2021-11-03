import 'package:chewie/chewie.dart';
import 'package:get/get.dart';
import 'package:kiwigames/games/bete_du_gevaudan/modules/player/player_controller.dart';
import 'package:kiwigames/games/bete_du_gevaudan/utils/constant/constant.dart';
import 'package:kiwigames/games/bete_du_gevaudan/utils/constant/constant_color.dart';
import 'package:flutter/material.dart';
import 'male_alpha_role_controller.dart';

class MaleAlphaRoleSleepPage extends StatelessWidget {
  final controller = Get.put(MaleAlphaRoleController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildScreen(),
    );
  }

  _buildScreen() {
    Future.delayed(Duration(seconds: 3),
        () => PlayerController.to.switchGameTour(GameTour.PROTECTEUR_WAKE));
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
              Constant.maleAlphaSleep,
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
