import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiwigames/controllers/controllers.dart';
import 'package:kiwigames/shared/shared.dart';
import 'package:qr_flutter/qr_flutter.dart';

class Lobby extends StatelessWidget {
  const Lobby({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: notLoggedAppBar,
      body: Center(
        child: ListView(
          padding: const EdgeInsets.all(25.0),
          shrinkWrap: true,
          children: const [
            LobbyCode(),
            HeightSpacer(50.0),
            UserRow(),
          ],
        ),
      ),
    );
  }
}

class LobbyCode extends GetView<LobbyController> {
  static final TextStyle textStyle = Get.textTheme.headline5!;

  const LobbyCode({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'flash_this_qrcode'.tr,
          style: Get.textTheme.bodyText1!.copyWith(color: dividerColor.color),
        ),
        const HeightSpacer(10.0),
        QrImage(
          data: controller.lobbyCode(),
          size: 300.0,
          backgroundColor: Colors.white,
        ),
        const HeightSpacer(15.0),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: textStyle,
            children: [
              TextSpan(text: 'lobby_code'.tr + ' : '),
              TextSpan(
                text: controller.lobbyCode().toString(),
                style: textStyle.copyWith(color: primaryColor.color),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class UserRow extends GetView<LobbyController> {
  const UserRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 700.0),
        child: Obx(() {
          final List<UserImage> userList = controller.userList
              .map(
                (user) => UserImage(
                  isActive: user.isActive,
                  pseudo: user.pseudo,
                  url: user.imagePath,
                  big: true,
                ),
              )
              .toList();
          if (userList.isEmpty) {
            return Text('empty_lobby'.tr, style: Get.textTheme.headline6);
          }
          return Wrap(
            alignment: WrapAlignment.center,
            spacing: 25.0,
            runSpacing: 25.0,
            children: userList,
          );
        }),
      ),
    );
  }
}
