import 'package:kiwigames/games/bete_du_gevaudan/utils/constant/constant_image.dart';
import 'package:flutter/material.dart';

class WakePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ConstantImage.backgroundNuitIntro),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(), //ConstantImage.logoImage,
            ),
            Spacer(flex: 3),
            Expanded(
              child: Container(), //RowPlayerWithMusic(),
            )
          ],
        ),
      ),
    );
  }
}
