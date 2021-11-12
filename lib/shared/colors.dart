import 'package:flutter/material.dart';

class AppColor {
  final int hexadecimal;

  AppColor(this.hexadecimal);

  Color get color => Color(hexadecimal);
  Map<int, Color> get mapColor => {
        50: color.withOpacity(.1),
        100: color.withOpacity(.2),
        200: color.withOpacity(.3),
        300: color.withOpacity(.4),
        400: color.withOpacity(.5),
        500: color.withOpacity(.6),
        600: color.withOpacity(.7),
        700: color.withOpacity(.8),
        800: color.withOpacity(.9),
        900: color,
      };
  MaterialColor get materialColor => MaterialColor(hexadecimal, mapColor);
  MaterialStateProperty<Color> get materialStateColor =>
      MaterialStateProperty.all<Color>(color);
}

AppColor primaryColor = AppColor(0xffadc22f);
AppColor backGroundColor = AppColor(0xff343434);
AppColor textColor = AppColor(0xffffffff);
AppColor inactiveColor = AppColor(0xfffa983e);
AppColor inputColor = AppColor(0xffcdcdcd);
AppColor textShadowColor = AppColor(0xff000000);
AppColor gameShadowColor = AppColor(0x4d000000);
AppColor dividerColor = AppColor(0xff7d7d7d);
AppColor labelColor = AppColor(0xff5a5a5a);
AppColor dialogColor = AppColor(0xffe5e5e5);
