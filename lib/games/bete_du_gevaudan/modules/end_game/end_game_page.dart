import 'package:kiwigames/games/bete_du_gevaudan/modules/player/player_controller.dart';
import 'package:kiwigames/games/bete_du_gevaudan/modules/widgets_global/button_action_game.dart';
import 'package:kiwigames/games/bete_du_gevaudan/utils/constant/constant_image.dart';
import 'package:flutter/material.dart';

class EndGamePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ConstantImage.background),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(),//ConstantImage.logoImage,
            ),
            Expanded(
              flex: 3,
              child: _EndGameContent(
                isWin: true,
              ),
            ),
            Expanded(child: Container())
          ],
        ),
      ),
    );
  }
}

class _EndGameContent extends StatelessWidget {
  final bool isWin;
  _EndGameContent({this.isWin: false});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            isWin ? _buildWinText() : _buildLoseText(),
          ],
        ),
        SizedBox(height: 20),
        Container(),//Image.asset(isWin ? ConstantImage.win : ConstantImage.dead),
        SizedBox(height: 40),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            ButtonActionGame(
              onTap: () => PlayerController.to.reloadGame(),
              isActive: true,
              text: "Rejouer",
            ),
            ButtonActionGame(
              onTap: () => PlayerController.to.quitGame(),
              isActive: true,
              text: "Quitter",
            ),
          ],
        )
      ],
    );
  }

  Widget _buildLoseText() {
    return /*TextEndGame(
      text: "Vous avez perdu...",
      win: false,
    );*/Container();
  }

   Widget _buildWinText() {
    return Column(
      children: [
        /*TextEndGame(
          text: "Bravo !",
          win: true,
        ),
        TextEndGame(
          text: "Vous triomphez !",
          win: true,
        ),*/
      ],
    );
  }
}
