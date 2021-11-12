import 'package:kiwigames/games/bete_du_gevaudan/utils/constant/constant_color.dart';
import 'package:flutter/material.dart';

class PlayerDeadPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text(
            "TU ES MORT",
            style: TextStyle(
              color: ConstantColor.white,
              fontSize: 22,
            ),
          ),
        ),
      ),
    );
  }
}
