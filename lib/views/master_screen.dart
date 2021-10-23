import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiwigames/shared/shared.dart';

class MasterScreen extends StatelessWidget {
  const MasterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: notLoggedAppBar,
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'create_lobby'.tr,
              style: Get.textTheme.headline5,
            ),
            const HeightSpacer(50.0),
            const LobbyTypeRow(),
            const HeightSpacer(50.0),
            OutlinedButton(
              child: Text('go_to_home'.tr),
              onPressed: () => Get.offAllNamed('/'),
            ),
          ],
        ),
      ),
    );
  }
}

class LobbyTypeRow extends StatelessWidget {
  const LobbyTypeRow({Key? key}) : super(key: key);

  void goToLobby(String type) {
    Get.toNamed('/lobby?type=$type');
  }

  @override
  Widget build(BuildContext context) {
    Axis direction;
    CrossAxisAlignment crossAxisAlignment;
    Widget spacer;
    if (MediaQuery.of(context).size.width <= 500) {
      direction = Axis.vertical;
      crossAxisAlignment = CrossAxisAlignment.stretch;
      spacer = const HeightSpacer(15.0);
    } else {
      direction = Axis.horizontal;
      crossAxisAlignment = CrossAxisAlignment.center;
      spacer = const WidthSpacer(15.0);
    }
    return Flex(
      direction: direction,
      crossAxisAlignment: crossAxisAlignment,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Tooltip(
          message: 'private_lobby_tooltip'.tr,
          child: BigButton(
            onPressed: () => goToLobby('private'),
            text: 'private_lobby'.tr,
          ),
        ),
        spacer,
        Tooltip(
          message: 'public_lobby_tooltip'.tr,
          child: BigButton(
            text: 'public_lobby'.tr,
            onPressed: () => goToLobby('public'),
          ),
        ),
      ],
    );
  }
}
