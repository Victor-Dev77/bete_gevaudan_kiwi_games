import 'package:kiwigames/games/bete_du_gevaudan/utils/constant/constant_image.dart';
import 'package:flutter/material.dart';

class ButtonMusic extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: EdgeInsets.only(right: 15),
        child: Container(),/*Image.asset(
          ConstantImage.music,
          width: 30,
          height: 30,
        ),*/
      ),
    );
  }
}
