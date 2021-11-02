import 'package:kiwigames/games/bete_du_gevaudan/utils/constant/constant_color.dart';
import 'package:flutter/material.dart';

class CustomGradient extends LinearGradient {
  CustomGradient({
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: const [
      ConstantColor.colorBackgroundBegin,
      ConstantColor.colorBackgroundEnd
    ],
  }) : super(
          begin: begin,
          end: end,
          colors: colors,
        );
}
