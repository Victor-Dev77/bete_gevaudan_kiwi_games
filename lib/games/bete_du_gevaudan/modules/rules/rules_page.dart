import 'package:kiwigames/games/bete_du_gevaudan/model/server.dart';
import 'package:kiwigames/games/bete_du_gevaudan/modules/player/player_controller.dart';
import 'package:kiwigames/games/bete_du_gevaudan/modules/widgets_global/button_action_game.dart';
import 'package:kiwigames/games/bete_du_gevaudan/routes/app_pages.dart';
import 'package:kiwigames/games/bete_du_gevaudan/utils/constant/constant.dart';
import 'package:kiwigames/games/bete_du_gevaudan/utils/constant/constant_color.dart';
import 'package:kiwigames/games/bete_du_gevaudan/utils/constant/constant_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RulesPage extends StatelessWidget {
/*
Padding(
            padding: EdgeInsets.symmetric(horizontal: Get.width / 10),
            child: CupertinoTextField(
              controller: controller.pseudoController,
              cursorColor: ConstantColor.black,
              maxLines: 1,
              maxLength: 10,
              padding: EdgeInsets.all(10),
            ),
          ),

*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(ConstantImage.background),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      //ConstantImage.logoImage,
                      SizedBox(height: 20),
                      Text(
                        PlayerController.to.player.isPrincipale ? "PRINCIPALE" : "LA BETE DU GEVAUDAN",
                        style: TextStyle(
                          fontSize: 27,
                          fontWeight: FontWeight.bold,
                          color: ConstantColor.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                    flex: 3,
                    child: Text(
                      Constant.introGameText,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: ConstantColor.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w600),
                    )),
                Expanded(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        /*StreamBuilder(
                          stream: channel.stream,
                          builder: (context, snapshot) {
                            print(snapshot.data);
                            return Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: snapshot.hasData ? Text(
                                '${snapshot.data}',
                                style: TextStyle(color: Colors.red),
                              ) : CircularProgressIndicator(),
                            );
                          },
                        ),*/
                        if (PlayerController.to.player.isHost)
                          ButtonActionGame(
                            onTap: () {
                              print("click");
                              Server.instance.startGame();
                              //channel.sink
                              // .add("${Random().nextInt(10)}");
                            }, //Get.offAllNamed(Routes.SLEEP),
                            text: "Jouer",
                            isActive: true,
                          ),
                        Container(), //ButtonMusic(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
