import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiwigames/controllers/controllers.dart';
import 'package:kiwigames/models/models.dart';
import 'package:kiwigames/shared/shared.dart';
import 'package:qr_flutter/qr_flutter.dart';

class Lobby extends GetView<LobbyController> {
  const Lobby({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() {
          bool hasHost = false;
          for (final user in controller.userList) {
            if (user.isHost) {
              hasHost = true;
            }
          }
          MainAxisAlignment mainAxisAlignment;
          List<Widget> children;
          if (hasHost ||
              controller.screen == 'principale' ||
              controller.isGuest) {
            mainAxisAlignment = MainAxisAlignment.start;
            children = const [KiwiGamesLogo()];
          } else {
            mainAxisAlignment = MainAxisAlignment.spaceBetween;
            children = [
              const KiwiGamesLogo(),
              ElevatedButton(
                child: Text('become_host_lobby'.tr),
                onPressed: controller.setHost,
              ),
            ];
          }
          return Row(
            mainAxisAlignment: mainAxisAlignment,
            children: children,
          );
        }),
      ),
      body: Center(
        child: Obx(() => controller.loading()
            ? const CircularProgressIndicator()
            : ListView(
                padding: const EdgeInsets.all(25.0),
                shrinkWrap: true,
                children: const [
                  LobbyCode(),
                  HeightSpacer(50.0),
                  UserRow(),
                ],
              )),
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
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: textStyle,
            children: [
              TextSpan(text: 'go_on'.tr),
              TextSpan(
                text: 'https://kiwigames.ovh',
                style: textStyle.copyWith(color: primaryColor.color),
              ),
            ],
          ),
        ),
        const HeightSpacer(25.0),
        Text(
          'flash_this_qrcode'.tr,
          style: Get.textTheme.bodyText1!.copyWith(color: dividerColor.color),
        ),
        const HeightSpacer(10.0),
        QrImage(
          data: 'https://kiwigames.ovh',
          size: 300.0,
          backgroundColor: Colors.white,
        ),
        const HeightSpacer(25.0),
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
                  username: user.username,
                  url: user.imagePath,
                  big: true,
                  isHost: user.isHost,
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
