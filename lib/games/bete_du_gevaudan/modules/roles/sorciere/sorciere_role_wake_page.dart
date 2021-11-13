import 'package:chewie/chewie.dart';
import 'package:get/get.dart';
import 'package:kiwigames/games/bete_du_gevaudan/model/player.dart';
import 'package:kiwigames/games/bete_du_gevaudan/model/server.dart';
import 'package:kiwigames/games/bete_du_gevaudan/modules/player/player_controller.dart';
import 'package:kiwigames/games/bete_du_gevaudan/modules/widgets_global/button_action_game.dart';
import 'package:kiwigames/games/bete_du_gevaudan/modules/widgets_global/button_select_player.dart';
import 'package:kiwigames/games/bete_du_gevaudan/utils/constant/constant.dart';
import 'package:kiwigames/games/bete_du_gevaudan/utils/constant/constant_color.dart';
import 'package:flutter/material.dart';
import 'sorciere_role_controller.dart';

class SorciereRoleWakePage extends GetView<SorciereRoleController> {
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
              Constant.sorciereWake,
              textAlign: TextAlign.center,
              style: TextStyle(color: ConstantColor.white, fontSize: 22),
            ),
          ),
        ],
      );
    }
    if (PlayerController.to.player.isKill)
      return PlayerController.to.killPlayerWidget();
    if (PlayerController.to.player.typePlayer != TypePlayer.SORCIERE)
      return PlayerController.to.sleepPlayerPageWidget();
    var player = _getMajority(PlayerController.to.playerKillByLoup,
        PlayerController.to.playerKillByLoup.length)!;
    return Container(
      child: Obx(() {
        if (!controller.isVotedShow) {
          return Column(
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
                      "${player.name.toUpperCase()} VA MOURIR, VEUX-TU LE SAUVER\nEN CHOISISSANT QUELQU'UN A SA PLACE ?",
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
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ButtonActionGame(
                          onTap: () =>
                              Server.instance.nextPage(GameTour.SORCIERE_SLEEP),
                          text: "LE LAISSER MOURIR",
                          isPrimaryColor: true,
                        ),
                        SizedBox(height: 20),
                        ButtonActionGame(
                          onTap: () => controller.showVoteList(),
                          text: "TUER QUELQU'UN D'AUTRE",
                        )
                      ],
                    ),
                  )),
              Spacer(),
            ],
          );
        }
        return Column(
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 25),
                        child: IconButton(
                            onPressed: () => controller.hideVoteList(),
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color: ConstantColor.white,
                            )),
                      ),
                      Text(
                        PlayerController.to.player.nameTypePlayer,
                        style: TextStyle(
                          color: ConstantColor.white,
                          fontSize: 25,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 25),
                        child: IconButton(onPressed: () {}, icon: Icon(null)),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    "QUI VEUX-TU TUER ?",
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
                child: GetBuilder<SorciereRoleController>(
                  builder: (_) {
                    var listPlayer = PlayerController.to.listPlayer;
                    listPlayer.removeWhere((element) =>
                        element.typePlayer == TypePlayer.SORCIERE ||
                        element.isKill ||
                        element.id == player.id);
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
                child: GetBuilder<SorciereRoleController>(
                  builder: (_) {
                    return ButtonActionGame(
                      onTap: () {
                        print(_.playerSelected);
                        Server.instance
                            .choiceSorcierePlayerToKill(_.playerSelected!);
                        Future.delayed(
                            Duration(seconds: 1),
                            () => Server.instance
                                .nextPage(GameTour.SORCIERE_SLEEP));
                      },
                      isActive: _.playerSelected != null,
                      text: "SUIVANT",
                    );
                  },
                ),
              ),
            ),
          ],
        );
      }),
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
}
