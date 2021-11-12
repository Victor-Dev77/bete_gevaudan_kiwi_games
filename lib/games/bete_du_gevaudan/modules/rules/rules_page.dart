import 'package:chewie/chewie.dart';
import 'package:get/get.dart';
import 'package:kiwigames/games/bete_du_gevaudan/model/server.dart';
import 'package:kiwigames/games/bete_du_gevaudan/modules/player/player_controller.dart';
import 'package:kiwigames/games/bete_du_gevaudan/modules/rules/rules_controller.dart';
import 'package:kiwigames/games/bete_du_gevaudan/modules/widgets_global/button_action_game.dart';
import 'package:kiwigames/games/bete_du_gevaudan/utils/constant/constant.dart';
import 'package:kiwigames/games/bete_du_gevaudan/utils/constant/constant_color.dart';
import 'package:kiwigames/games/bete_du_gevaudan/utils/constant/constant_image.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class RulesPage extends StatelessWidget {
  final controller = Get.put(RulesController());

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
              return SizedBox.expand(
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: Center(
                    child: Chewie(controller: controller.chewieController),
                  ),
                ),
              );
            return Container();
          }),
          Obx(() {
            if (controller.introGame)
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "LA BETE DU GEVAUDAN",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: ConstantColor.white, fontSize: 33),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: Text(
                      Constant.credit,
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(color: ConstantColor.white, fontSize: 22),
                    ),
                  )
                ],
              );
            return Center(
              child: Text(
                Constant.introGameText,
                textAlign: TextAlign.center,
                style: TextStyle(color: ConstantColor.white, fontSize: 22),
              ),
            );
          }),
        ],
      );
    }
    return Stack(
      children: [
        Obx(() {
          if (controller.videoCharged)
            return SizedBox.expand(
              child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: controller.videoPlayerController.value.size.width,
                  height: controller.videoPlayerController.value.size.height,
                  child: VideoPlayer(controller.videoPlayerController),
                ),
              ),
            );
          return Container();
        }),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 20),
                  Text(
                    "LA BETE DU GEVAUDAN",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: ConstantColor.white,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(flex: 3, child: Container()),
            Expanded(
              child: Container(child: Center(
                child: Obx(() {
                  if (!controller.introGame &&
                      PlayerController.to.player.isHost)
                    return ButtonActionGame(
                      width: 200,
                      onTap: () => Server.instance.startGame(),
                      text: "Jouer",
                    );
                  return Container();
                }),
              )),
            ),
          ],
        ),
      ],
    );
  }
}
