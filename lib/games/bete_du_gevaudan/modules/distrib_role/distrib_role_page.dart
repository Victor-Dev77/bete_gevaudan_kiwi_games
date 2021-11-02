import 'package:kiwigames/games/bete_du_gevaudan/modules/distrib_role/distrib_role_controller.dart';
import 'package:kiwigames/games/bete_du_gevaudan/modules/player/player_controller.dart';
import 'package:kiwigames/games/bete_du_gevaudan/modules/widgets_global/button_action_game.dart';
import 'package:kiwigames/games/bete_du_gevaudan/utils/constant/constant_color.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class DistribRolePage extends StatelessWidget {
  final controller = Get.put(DistribRoleController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () {
          if (!controller.playerHasRole)
            return Center(
              child: CircularProgressIndicator(),
            );
          if (controller.showRoleDetail) return _buildShowRoleDetail();
          return Container(
            child: Center(
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      PlayerController.to.player.nameTypePlayer,
                      style:
                          TextStyle(color: ConstantColor.white, fontSize: 22),
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
                          text: "Découvrir mon rôle",
                          isActive: true,
                        ),
                        SizedBox(height: 10),
                        ButtonActionGame(
                          onTap: () => controller.clickReady(),
                          text: "Je suis prêt",
                          isActive: true,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  _buildShowRoleDetail() {
    return Column(
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
                      color: ConstantColor.white,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                PlayerController.to.player.nameTypePlayer,
                style: TextStyle(color: ConstantColor.white, fontSize: 22),
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
                style: TextStyle(color: ConstantColor.white, fontSize: 22),
              ),
            ),
          ),
        ),
        Spacer(),
      ],
    );
  }
}
