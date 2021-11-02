import 'package:kiwigames/games/bete_du_gevaudan/utils/constant/constant_color.dart';
import 'package:flutter/material.dart';
import 'custom_gradient.dart';

class TextEndGame extends StatelessWidget {
  final Key? key;
  final String text;
  final bool win;

  TextEndGame({this.key, this.text: "", this.win: false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: win
          ? BoxDecoration(
              gradient: CustomGradient(),
              borderRadius: BorderRadius.circular(15),
            )
          : BoxDecoration(
              color: ConstantColor.white,
              borderRadius: BorderRadius.circular(15),
            ),
      child: win
          ? Center(child: _buildText)
          : ShaderMask(
              shaderCallback: (Rect bounds) =>
                  CustomGradient().createShader(Offset.zero & bounds.size),
              child: Center(
                child: _buildText,
              ),
            ),
    );
  }

  Text get _buildText => Text(
        text,
        style: TextStyle(
          fontSize: 27,
          fontWeight: FontWeight.w600,
          color: ConstantColor.white,
        ),
      );
}
