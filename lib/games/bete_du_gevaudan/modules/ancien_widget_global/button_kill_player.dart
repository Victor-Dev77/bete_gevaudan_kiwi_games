import 'package:kiwigames/games/bete_du_gevaudan/model/player.dart';
import 'package:kiwigames/games/bete_du_gevaudan/utils/constant/constant_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'custom_gradient.dart';

class ButtonKillPlayer extends StatelessWidget {
  final Key? key;
  bool isSelected, showTypePlayer;
  final Function(Player) onTap;
  final Player player;

  ButtonKillPlayer(
      {this.key,
      this.isSelected: false,
      required this.onTap,
      required this.player,
      this.showTypePlayer: false});

  @override
  Widget build(BuildContext context) {
    isSelected = player.isSelectedToKill;
    return GestureDetector(
      key: key,
      onTap: () => onTap(player),
      child: Container(
        width: Get.width - Get.width / 3,
        height: 50,
        decoration: isSelected
            ? BoxDecoration(
                gradient: CustomGradient(),
                borderRadius: BorderRadius.circular(5),
              )
            : BoxDecoration(
                color: ConstantColor.white,
                borderRadius: BorderRadius.circular(5),
              ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              /* Padding(
                padding: EdgeInsets.only(left: 15),
                child: !showTypePlayer ? Icon(null) : Image.asset(
                  player.imageTypePlayer,
                  width: 30,
                  height: 30,
                ),
              ),*/
              Text(
                player.name,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color:
                        isSelected ? ConstantColor.white : ConstantColor.black),
              ),
              /*Padding(
                padding: EdgeInsets.only(right: 15),
                child: Opacity(
                    opacity: 0,
                    child: Image.asset(
                      player.imageTypePlayer,
                      width: 30,
                      height: 30,
                    )),
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}
