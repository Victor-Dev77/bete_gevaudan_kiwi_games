import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiwigames/shared/colors.dart';

class KiwiGamesLogo extends StatelessWidget {
  const KiwiGamesLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/logos/logo.png',
      height: kToolbarHeight - 10.0,
    );
  }
}

class UserImage extends StatelessWidget {
  final String pseudo;
  final bool isActive;
  final String? url;
  final bool big;

  const UserImage({
    Key? key,
    required this.pseudo,
    required this.isActive,
    this.url,
    this.big = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double size;
    double padding;
    TextStyle textStyle;
    if (big) {
      size = 100.0;
      padding = 8.0;
      textStyle = Get.textTheme.headline5!;
    } else {
      size = 50.0;
      padding = 4.0;
      textStyle = Get.textTheme.headline6!;
    }

    final Widget child = url == null
        ? Container(
            alignment: Alignment.center,
            color: isActive ? primaryColor.color : inactiveColor.color,
            child: Text(
              pseudo[0],
              style: textStyle,
            ),
          )
        : CustomNetworkImage(
            url: url!,
            user: true,
          );
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Container(
          padding: EdgeInsets.all(padding),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive ? primaryColor.color : inactiveColor.color,
          ),
          width: size,
          height: size,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100.0),
            child: child,
          ),
        ),
      ],
    );
  }
}

class CustomNetworkImage extends StatelessWidget {
  final String url;
  final bool user;

  const CustomNetworkImage({
    Key? key,
    required this.url,
    this.user = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      fit: BoxFit.cover,
      loadingBuilder: (
        BuildContext context,
        Widget child,
        ImageChunkEvent? loadingProgress,
      ) {
        if (loadingProgress == null) {
          return child;
        }
        return Container(
          alignment: Alignment.center,
          padding: !user ? const EdgeInsets.symmetric(horizontal: 20.0) : null,
          child: user
              ? CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
                )
              : LinearProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
                ),
        );
      },
    );
  }
}
