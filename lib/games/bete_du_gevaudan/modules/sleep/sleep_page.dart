import 'package:kiwigames/games/bete_du_gevaudan/modules/player/player_controller.dart';
import 'package:kiwigames/games/bete_du_gevaudan/modules/sleep/sleep_controller.dart';
import 'package:kiwigames/games/bete_du_gevaudan/utils/constant/constant_color.dart';
import 'package:kiwigames/games/bete_du_gevaudan/utils/constant/constant_image.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SleepPage extends GetView<SleepController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Obx(() {
            if (controller.videoCharged)
              return Chewie(controller: controller.chewieController);
            return Container();
          }),
          Opacity(
            opacity: 0.3,
            child: Container(
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Center(
                      child: Text(
                        PlayerController.to.player.nameTypePlayer,
                        style:
                            TextStyle(color: ConstantColor.white, fontSize: 22),
                      ),
                    ),
                  ),
                  Expanded(flex: 3, child: Container()),
                  Spacer()
                ],
              ),
            ),
          ),
          Center(
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
        ],
      ),
    );
  }
}
