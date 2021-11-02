import 'package:kiwigames/games/bete_du_gevaudan/model/player.dart';
import 'package:kiwigames/games/bete_du_gevaudan/utils/constant/constant_color.dart';
import 'package:flutter/material.dart';

class ButtonSelectPlayer extends StatelessWidget {
  final Player player;
  final Function(Player) onTap;
  final bool enabled;

  ButtonSelectPlayer(
      {required this.player, required this.onTap, this.enabled: false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(player),
      child: Container(
        color: enabled ? ConstantColor.white : Colors.transparent,
        child: Center(
          child: Text(
            player.name,
            style: TextStyle(
              color: enabled ? ConstantColor.primary : ConstantColor.white,
              fontSize: 22,
            ),
          ),
        ),
      ),
    );
  }
}
