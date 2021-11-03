import 'package:kiwigames/games/bete_du_gevaudan/utils/constant/constant_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ButtonActionGame extends StatelessWidget {
  final Key? key;
  final VoidCallback onTap;
  final String text;
  final double? width;
  final bool isActive, isPrimaryColor;
  ButtonActionGame(
      {this.key,
      required this.onTap,
      this.text: "",
      this.width,
      this.isActive: true,
      this.isPrimaryColor: false});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isActive ? 1 : 0.3,
      child: GestureDetector(
        onTap: isActive ? onTap : null,
        child: Container(
          height: 55,
          width: width ?? Get.width - 100,
          padding: EdgeInsets.symmetric(horizontal: 40),
          color: isPrimaryColor ? ConstantColor.primary : ConstantColor.white,
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color:
                    isPrimaryColor ? ConstantColor.white : ConstantColor.black,
                fontSize: 22,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
