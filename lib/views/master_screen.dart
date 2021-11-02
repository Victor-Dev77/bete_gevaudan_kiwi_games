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
              'master_screen'.tr,
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

  void createLobby() {
    Get.toNamed('/lobby');
  }

  void joinLobby() {
    Get.offAllNamed('/join-lobby?master-screen');
  }

  @override
  Widget build(BuildContext context) {
    Axis direction;
    CrossAxisAlignment crossAxisAlignment;
    Widget spacer;
    if (MediaQuery.of(context).size.width <= 600) {
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
        BigButton(
          onPressed: createLobby,
          text: 'create_lobby'.tr,
        ),
        spacer,
        BigButton(
          text: 'join_lobby'.tr,
          onPressed: joinLobby,
        ),
      ],
    );
  }
}
