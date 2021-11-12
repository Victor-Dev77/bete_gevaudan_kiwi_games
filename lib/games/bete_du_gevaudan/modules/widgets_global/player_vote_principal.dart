import 'package:flutter/material.dart';
import 'package:kiwigames/games/bete_du_gevaudan/model/player.dart';
import 'package:kiwigames/games/bete_du_gevaudan/utils/constant/constant_color.dart';

class PlayerVotePrincipal extends StatelessWidget {
  final Player player;
  final Map<String, dynamic> playerShow;
  PlayerVotePrincipal({required this.player, required this.playerShow});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            player.name,
            style: TextStyle(
              color: playerShow["isDead"]
                  ? ConstantColor.grey
                  : ConstantColor.white,
              fontSize: 22,
            ),
          ),
          SizedBox(width: 20),
          Container(
            width: 50,
            height: 50,
            color:
                playerShow["isDead"] ? ConstantColor.grey : ConstantColor.white,
            child: Center(
              child: Text(
                playerShow["isDead"] ? "X" : playerShow["cmpt"].toString(),
                style: TextStyle(
                  color: ConstantColor.black,
                  fontSize: 22,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
