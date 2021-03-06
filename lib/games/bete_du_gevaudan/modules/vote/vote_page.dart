import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiwigames/games/bete_du_gevaudan/model/server.dart';
import 'package:kiwigames/games/bete_du_gevaudan/modules/player/player_controller.dart';
import 'package:kiwigames/games/bete_du_gevaudan/modules/vote/vote_controller.dart';
import 'package:kiwigames/games/bete_du_gevaudan/modules/widgets_global/button_action_game.dart';
import 'package:kiwigames/games/bete_du_gevaudan/modules/widgets_global/button_select_player.dart';
import 'package:kiwigames/games/bete_du_gevaudan/modules/widgets_global/player_vote_principal.dart';
import 'package:kiwigames/games/bete_du_gevaudan/utils/constant/constant.dart';
import 'package:kiwigames/games/bete_du_gevaudan/utils/constant/constant_color.dart';

class VotePage extends GetView<VoteController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildScreen(),
    );
  }

  _buildScreen() {
    //Future.delayed(Duration(seconds: 3),
    //  () => PlayerController.to.switchGameTour(GameTour.RESULT_VOTE));
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
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Center(
                    child: Text(
                      Constant.vote,
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(color: ConstantColor.white, fontSize: 22),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Center(
                    child: Container(
                      child: GetBuilder<VoteController>(
                        builder: (_) {
                          var itemCount = PlayerController.to.listPlayer.length;
                          var nbRow = (itemCount / 2).ceil();
                          return Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: List.generate(nbRow, (index) {
                                    var player =
                                        PlayerController.to.listPlayer[index];
                                    var playerShow =
                                        _.playersVoted[player.name]!;
                                    return PlayerVotePrincipal(
                                      player: player,
                                      playerShow: playerShow,
                                    );
                                  }),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children:
                                      List.generate(itemCount - nbRow, (index) {
                                    var newIndex = index + nbRow;
                                    var player = PlayerController
                                        .to.listPlayer[newIndex];
                                    var playerShow =
                                        _.playersVoted[player.name]!;
                                    return PlayerVotePrincipal(
                                      player: player,
                                      playerShow: playerShow,
                                    );
                                  }),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
        ],
      );
    }
    if (PlayerController.to.player.isKill)
      return PlayerController.to.killPlayerWidget();
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
                  "CONTRE QUI VEUX-TU VOTER ?",
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
              child: GetBuilder<VoteController>(
                builder: (_) {
                  var listPlayer = PlayerController.to.listPlayer;
                  listPlayer.removeWhere((element) =>
                      element.name == PlayerController.to.player.name ||
                      element.isKill);
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
                        onTap: _.voted
                            ? (_player) {}
                            : (_player) {
                                _.clickPlayer(_player);
                                Server.instance.selectPlayerVote(_player);
                              },
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
                if (!controller.voted)
                  return GetBuilder<VoteController>(
                    builder: (_) {
                      return ButtonActionGame(
                        onTap: () {
                          print(_.playerSelected);
                          _.setVoted();
                          Server.instance.imReadyVoted();
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
