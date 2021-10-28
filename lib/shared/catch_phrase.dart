import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiwigames/shared/shared.dart';

class CatchPhrase extends StatelessWidget {
  static final TapGestureRecognizer joinLobby = TapGestureRecognizer()
    ..onTap = () => Get.toNamed('/join-lobby?guest');

  const CatchPhrase({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle defaultTextStyle = DefaultTextStyle.of(context).style;
    TextStyle defaultTextStylePrimaryColor =
        defaultTextStyle.copyWith(color: primaryColor.color);
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'no_need_account'.tr,
            style: Get.textTheme.headline5,
          ),
          const HeightSpacer(40.0),
          RichText(
            text: TextSpan(
              style: defaultTextStyle,
              children: [
                TextSpan(text: 'wont_connect'.tr),
                TextSpan(
                  recognizer: joinLobby,
                  text: 'join_friends'.tr,
                  style: defaultTextStylePrimaryColor,
                ),
              ],
            ),
          ),
          const HeightSpacer(25.0),
          ElevatedButton(
            child: Text('join_as_master_screen'.tr),
            onPressed: () =>
                Get.toNamed('/lobby?type=private&screen=principale&host=false'),
          ),
        ],
      ),
    );
  }
}
