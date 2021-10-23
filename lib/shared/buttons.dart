import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BigButton extends StatelessWidget {
  static final TextStyle textStyle = Get.textTheme.headline6!;
  static final ButtonStyle buttonStyle =
      Get.theme.elevatedButtonTheme.style!.copyWith(
    padding: MaterialStateProperty.all(
      const EdgeInsets.symmetric(horizontal: 40.0, vertical: 25.0),
    ),
  );

  final String text;
  final VoidCallback onPressed;

  const BigButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(text, style: textStyle),
      style: buttonStyle,
    );
  }
}
