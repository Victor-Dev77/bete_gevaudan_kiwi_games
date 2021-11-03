import 'package:chewie/chewie.dart';
import 'package:kiwigames/games/bete_du_gevaudan/modules/distrib_role/distrib_role_controller.dart';
import 'package:kiwigames/games/bete_du_gevaudan/modules/player/player_controller.dart';
import 'package:kiwigames/games/bete_du_gevaudan/modules/widgets_global/button_action_game.dart';
import 'package:kiwigames/games/bete_du_gevaudan/utils/constant/constant.dart';
import 'package:kiwigames/games/bete_du_gevaudan/utils/constant/constant_color.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class DistribRolePage extends StatelessWidget {
  final controller = Get.put(DistribRoleController());

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
              return Chewie(controller: controller.chewieController);
            return Container();
          }),
          Container(
            child: Center(
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Center(
                      child: Text(
                        Constant.beginGame,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: ConstantColor.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
          ),
        ],
      );
    }
    return Obx(
      () {
        if (!controller.playerHasRole)
          return Center(
            child: CircularProgressIndicator(),
          );
        if (controller.showRoleDetail) return _buildShowRoleDetail();
        return Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(PlayerController.to.player.imageTypePlayer),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Center(
                    child: Text(
                      PlayerController.to.player.nameTypePlayer,
                      style: TextStyle(fontSize: 22),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: SizedBox(),
                ),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      ButtonActionGame(
                        onTap: () => controller.clickShowRole(),
                        text: "Découvrir",
                        isPrimaryColor: true,
                      ),
                      SizedBox(height: 10),
                      Obx(() {
                        if (controller.clickReadyBtn)
                          return CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  ConstantColor.primary));
                        return ButtonActionGame(
                          onTap: () => controller.clickReady(),
                          text: "Je suis prêt",
                        );
                      }),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  _buildShowRoleDetail() {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(PlayerController.to.player.imageTypePlayer),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: <Widget>[
          Expanded(
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    IconButton(
                      onPressed: () => controller.closeShowRole(),
                      icon: Icon(
                        FontAwesomeIcons.times,
                        color: ConstantColor.black,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  PlayerController.to.player.nameTypePlayer,
                  style: TextStyle(fontSize: 22),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  PlayerController.to.player.ruleTypePlayer,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 22),
                ),
              ),
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
