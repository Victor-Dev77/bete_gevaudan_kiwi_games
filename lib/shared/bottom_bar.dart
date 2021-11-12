import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiwigames/shared/shared.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
      child: Row(
        children: [
          InteractiveText(
            text: 'about_us'.tr,
            function: () => print('about us'),
          ),
          const WidthSpacer(20.0),
          InteractiveText(
            text: 'cgu'.tr,
            function: () => print('cgu'),
          ),
          const WidthSpacer(20.0),
          InteractiveText(
            text: 'legal_mentions'.tr,
            function: () => print('about us'),
          ),
          const WidthSpacer(20.0),
          InteractiveText(
            text: 'contact_us'.tr,
            function: () => print('about us'),
          ),
          const Spacer(),
          InteractiveIcon(
            function: () => print('facebook pressed'),
            icon: Icons.facebook,
          ),
          const WidthSpacer(50.0),
          Text('copyright'.tr)
        ],
      ),
    );
  }
}
