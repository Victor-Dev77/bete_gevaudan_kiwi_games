import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiwigames/controllers/controllers.dart';
import 'package:kiwigames/shared/shared.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: notLoggedAppBar,
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(25.0),
        child: const ScreenTypeChoice(),
      ),
    );
  }
}

class ScreenTypeChoice extends GetView<HomeController> {
  const ScreenTypeChoice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.loading()) {
        return const CircularProgressIndicator();
      }
      Axis direction;
      CrossAxisAlignment crossAxisAlignment;
      Widget spacer;
      if (MediaQuery.of(context).size.width <= 850) {
        direction = Axis.vertical;
        crossAxisAlignment = CrossAxisAlignment.stretch;
        spacer = const HeightSpacer(25.0);
      } else {
        direction = Axis.horizontal;
        crossAxisAlignment = CrossAxisAlignment.center;
        spacer = const WidthSpacer(25.0);
      }
      return Flex(
        direction: direction,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: crossAxisAlignment,
        children: [
          BigButton(
            text: 'join_as_master_screen'.tr,
            onPressed: controller.goToMasterScreen,
          ),
          spacer,
          BigButton(
            text: 'join_as_player'.tr,
            onPressed: controller.goToPlayerScreen,
          ),
        ],
      );
    });
  }
}
