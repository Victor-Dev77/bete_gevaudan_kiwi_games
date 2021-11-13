import 'package:chewie/chewie.dart';
import 'package:get/get.dart';
import 'package:kiwigames/games/bete_du_gevaudan/model/player.dart';
import 'package:kiwigames/games/bete_du_gevaudan/model/server.dart';
import 'package:kiwigames/games/bete_du_gevaudan/modules/player/player_controller.dart';
import 'package:kiwigames/games/bete_du_gevaudan/modules/roles/loup/loup_role_controller.dart';
import 'package:kiwigames/games/bete_du_gevaudan/utils/constant/constant.dart';
import 'package:kiwigames/games/bete_du_gevaudan/utils/constant/constant_color.dart';
import 'package:flutter/material.dart';

class LoupRoleSleepPage extends GetView<LoupRoleController> {
  @override
  Widget build(BuildContext context) {
    controller.changeAudioForSleep();
    return Scaffold(
      body: _buildScreen(),
    );
  }

  Player? _getMajority(List<Player> array, int size) {
    int count = 0;
    int i = 0;
    Player? majorityElement;
    for (i = 0; i < size; i++) {
      if (count == 0) majorityElement = array[i];
      if (array[i] == majorityElement)
        count++;
      else
        count--;
    }
    count = 0;
    for (i = 0; i < size; i++) if (array[i] == majorityElement) count++;
    if (count > size / 2) return majorityElement;
    return null;
  }

  _buildScreen() {
    Future.delayed(PlayerController.to.durationChrono, () {
      controller.onClose();
      if (PlayerController.to.player.isPrincipale)
        Server.instance.sendListPlayer(PlayerController.to.listPlayer);
      var player = _getMajority(PlayerController.to.playerKillByLoup,
          PlayerController.to.playerKillByLoup.length);
      if (player == null) // Egalité donc sorciere ne joue pas
        PlayerController.to.switchGameTour(GameTour.WAKE);
      else
        PlayerController.to.switchGameTour(GameTour.SORCIERE_WAKE);
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
              Constant.loupSleep,
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
