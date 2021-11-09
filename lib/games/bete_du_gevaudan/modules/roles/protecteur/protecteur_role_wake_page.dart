import 'package:chewie/chewie.dart';
import 'package:kiwigames/games/bete_du_gevaudan/model/player.dart';
import 'package:kiwigames/games/bete_du_gevaudan/model/server.dart';
import 'package:kiwigames/games/bete_du_gevaudan/modules/player/player_controller.dart';
import 'package:kiwigames/games/bete_du_gevaudan/modules/widgets_global/button_action_game.dart';
import 'package:kiwigames/games/bete_du_gevaudan/modules/widgets_global/button_select_player.dart';
import 'package:kiwigames/games/bete_du_gevaudan/utils/constant/constant.dart';
import 'package:kiwigames/games/bete_du_gevaudan/utils/constant/constant_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'protecteur_role_controller.dart';

class ProtecteurRoleWakePage extends GetView<ProtecteurRoleController> {
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
            child: Text(
              Constant.protecteurWake,
              textAlign: TextAlign.center,
              style: TextStyle(color: ConstantColor.white, fontSize: 22),
            ),
          ),
        ],
      );
    }
    if (PlayerController.to.player.isKill)
      return PlayerController.to.killPlayerWidget();
    if (PlayerController.to.player.typePlayer != TypePlayer.PROTECTEUR)
      return PlayerController.to.sleepPlayerPageWidget();
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  PlayerController.to.player.nameTypePlayer,
                  style: TextStyle(
                    color: ConstantColor.white,
                    fontSize: 25,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "QUI VEUX-TU PROTÉGER POUR\nCETTE NUIT ?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ConstantColor.white,
                    fontSize: 22,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: GetBuilder<ProtecteurRoleController>(
                builder: (_) {
                  var listPlayer = PlayerController.to.listPlayer;
                  listPlayer.removeWhere(
                      (element) => element.typePlayer == TypePlayer.PROTECTEUR);
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 2.75,
                    ),
                    itemCount: listPlayer.length,
                    itemBuilder: (ctx, index) {
                      var player = listPlayer[index];
                      return ButtonSelectPlayer(
                        player: player,
                        enabled: _.isPlayer(player),
                        onTap: (_player) => _.clickPlayer(_player),
                      );
                    },
                  );
                },
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Obx(() {
                if (controller.voiceOffFinish)
                  return GetBuilder<ProtecteurRoleController>(
                    builder: (_) {
                      return ButtonActionGame(
                        onTap: () {
                          print(_.playerSelected);
                          Server.instance
                              .choicePlayerToProtect(_.playerSelected!);
                          Future.delayed(
                              Duration(seconds: 1),
                              () => Server.instance
                                  .nextPage(GameTour.PROTECTEUR_SLEEP));
                        },
                        isActive: _.playerSelected != null,
                        text: "SUIVANT",
                      );
                    },
                  );
                return ButtonActionGame(
                  onTap: () {},
                  isActive: false,
                  showLoader: true,
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
