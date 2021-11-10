import 'package:kiwigames/games/bete_du_gevaudan/modules/kill_player/kill_player_controller.dart';
import 'package:kiwigames/games/bete_du_gevaudan/modules/player/player_controller.dart';
import 'package:kiwigames/games/bete_du_gevaudan/modules/widgets_global/button_action_game.dart';
import 'package:kiwigames/games/bete_du_gevaudan/routes/app_pages.dart';
import 'package:kiwigames/games/bete_du_gevaudan/utils/constant/constant_color.dart';
import 'package:kiwigames/games/bete_du_gevaudan/utils/constant/constant_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class KillPlayerPage extends StatelessWidget {
  final controller = Get.put(KillPlayerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ConstantImage.backgroundNuitIntro),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(), //ConstantImage.logoImage,
            ),
            Expanded(flex: 3, child: _buildFormKill()),
            Expanded(
              child: Container(),
            )
          ],
        ),
      ),
    );
  }

  _buildFormKill() {
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              //color: Colors.red,
              child: Center(
                child: Text(
                  "Qui voulez-vous tuer ?",
                  style: TextStyle(color: ConstantColor.white, fontSize: 25),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              //color: Colors.green,
              child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: Get.width / 8),
                itemCount: PlayerController.to.nbPlayerAlive,
                itemBuilder: (ctx, index) {
                  var player = PlayerController.to.listPlayerAlive[index];
                  if (player.id == PlayerController.to.player.id)
                    return Container();
                  return GetBuilder<KillPlayerController>(
                    builder: (_) {
                      return Container();
                      /*ButtonKillPlayer(
                        onTap: (player) =>
                            controller.selectPlayerToKill(player),
                        player: player,
                        showTypePlayer: PlayerController.to.gameTour == GameTour.KILL_WOLF,
                      );*/
                    },
                  );
                },
                separatorBuilder: (ctx, index) => SizedBox(height: 10),
              ),
            ),
          ),
          Expanded(
            child: Container(
              //color: Colors.yellow,
              child: Center(
                child: Obx(
                  () => ButtonActionGame(
                    onTap: () {
                      PlayerController.to
                          .killPlayer(controller.getPlayerSelected().id);
                      Get.offAllNamed(Routes.WAKE);
                    },
                    width: Get.width - Get.width / 4,
                    text: "Tuer",
                    isActive: controller.isPlayerSelected.value,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
