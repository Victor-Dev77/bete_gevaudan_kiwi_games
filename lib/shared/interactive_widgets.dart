import 'package:flutter/material.dart';
import 'package:kiwigames/shared/colors.dart';

class InteractiveText extends StatelessWidget {
  final String text;
  final VoidCallback function;
  final Color? color;

  const InteractiveText({
    Key? key,
    required this.text,
    required this.function,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: InkWell(
        onTap: function,
        child: Text(
          text,
          style: TextStyle(color: color ?? textColor.color),
        ),
      ),
    );
  }
}

class InteractiveIcon extends StatelessWidget {
  final IconData icon;
  final VoidCallback function;
  final Color? color;

  const InteractiveIcon({
    Key? key,
    required this.icon,
    required this.function,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: function,
        child: Icon(
          icon,
          color: color ?? textColor.color,
        ),
      ),
    );
  }
}
