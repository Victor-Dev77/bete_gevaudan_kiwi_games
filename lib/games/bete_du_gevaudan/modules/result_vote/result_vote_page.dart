import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiwigames/games/bete_du_gevaudan/modules/player/player_controller.dart';
import 'package:kiwigames/games/bete_du_gevaudan/modules/result_vote/result_vote_controller.dart';
import 'package:kiwigames/games/bete_du_gevaudan/utils/constant/constant.dart';
import 'package:kiwigames/games/bete_du_gevaudan/utils/constant/constant_color.dart';

class ResultVotePage extends GetView<ResultVoteController> {
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
              return Text(
                controller.voteWithDead
                    ? controller.playerIsMarried
                        ? "LE VILLAGE S'EST PRONONCE.\n${PlayerController.to.married![0].name.toUpperCase()} ET ${PlayerController.to.married![1].name.toUpperCase()}\nN'EST PLUS. ILS ETAIENT ${PlayerController.to.married![0].nameTypePlayer} ET ${PlayerController.to.married![1].nameTypePlayer}"
                        : "LE VILLAGE S'EST PRONONCE. ${controller.playerDead!.name.toUpperCase()} N'EST\nPLUS. IL ETAIT ${controller.playerDead!.nameTypePlayer}"
                    : Constant.resultVoteNoDead,
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
