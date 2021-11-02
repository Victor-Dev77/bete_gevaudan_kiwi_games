import 'package:kiwigames/games/bete_du_gevaudan/utils/constant/constant_color.dart';
import 'package:flutter/material.dart';
import 'custom_gradient.dart';

class ButtonActionGame extends StatelessWidget {
  final Key? key;
  final VoidCallback onTap;
  final String text;
  final double? width;
  final Color borderColor;
  final bool isActive, withGradient;
  ButtonActionGame(
      {this.key,
      required this.onTap,
      this.text: "",
      this.width,
      this.borderColor: ConstantColor.white,
      this.isActive: false,
      this.withGradient: true});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isActive ? 1 : 0.3,
      child: GestureDetector(
        onTap: isActive ? onTap : null,
        child: Container(
          height: 55,
          width: width,
          padding: EdgeInsets.symmetric(horizontal: 40),
          decoration: BoxDecoration(
              gradient: withGradient ? CustomGradient() : null,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: borderColor)),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: ConstantColor.white,
                fontSize: 22,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
