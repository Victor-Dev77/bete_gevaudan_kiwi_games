import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiwigames/games/bete_du_gevaudan/modules/player/player_controller.dart';
import 'package:kiwigames/games/bete_du_gevaudan/modules/wake/wake_controller.dart';
import 'package:kiwigames/games/bete_du_gevaudan/utils/constant/constant.dart';
import 'package:kiwigames/games/bete_du_gevaudan/utils/constant/constant_color.dart';

class WakePage extends GetView<WakeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildScreen(),
    );
  }

  _buildScreen() {
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
            child: Obx(() {
              if (controller.resultVoteDead == 0)
                return CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation<Color>(ConstantColor.primary),
                );
              return Text(
                controller.resultVoteDead == 2
                    ? controller.playerVoted.length == 2
                        ? "LE VILLAGE SE REVEILLE.\n${controller.playerVoted[0].name.toUpperCase()} ET ${controller.playerVoted[1].name.toUpperCase()}\nSONT MORT !"
                        : "LE VILLAGE SE REVEILLE.\n${controller.playerVoted[0].name.toUpperCase()} EST MORT !"
                    : Constant.wakeNoKill,
                textAlign: TextAlign.center,
                style: TextStyle(color: ConstantColor.white, fontSize: 22),
              );
            }),
          ),
        ],
      );
    }
    if (PlayerController.to.player.isKill)
      return PlayerController.to.killPlayerWidget();
    return PlayerController.to.sleepPlayerPageWidget();
  }
}
