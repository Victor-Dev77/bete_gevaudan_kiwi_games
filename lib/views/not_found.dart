import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiwigames/shared/shared.dart';

class NotFound extends StatelessWidget {
  const NotFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('not_found'.tr, style: Get.textTheme.headline5),
            const HeightSpacer(30.0),
            BigButton(
              text: 'go_to_home'.tr,
              onPressed: () => Get.offAllNamed('/login'),
            ),
          ],
        ),
      ),
    );
  }
}
