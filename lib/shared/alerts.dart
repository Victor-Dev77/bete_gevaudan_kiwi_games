import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiwigames/shared/colors.dart';
import 'package:kiwigames/shared/shared.dart';

class InfoAlert extends StatelessWidget {
  static final TextTheme textTheme = Get.textTheme;

  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  const InfoAlert({
    Key? key,
    required this.onConfirm,
    required this.onCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      textStyle: textTheme.bodyText1,
      type: MaterialType.transparency,
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(25.0),
          decoration: BoxDecoration(
            color: backGroundColor.color,
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'information'.tr,
                style: textTheme.headline5,
              ),
              const HeightSpacer(25.0),
              Text('lobby_no_host'.tr),
              const HeightSpacer(10.0),
              Text('become_host'.tr),
              const HeightSpacer(10.0),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                    child: Text('yes'.tr),
                    onPressed: onConfirm,
                  ),
                  const WidthSpacer(10.0),
                  OutlinedButton(
                    child: Text('no'.tr),
                    onPressed: onCancel,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ErrorAlert extends StatelessWidget {
  static final TextTheme textTheme = Get.textTheme;

  final String message;

  const ErrorAlert(this.message, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      textStyle: textTheme.bodyText1,
      type: MaterialType.transparency,
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(25.0),
          decoration: BoxDecoration(
            color: backGroundColor.color,
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'error'.tr,
                style: textTheme.headline5,
              ),
              const HeightSpacer(25.0),
              Text(message),
              const HeightSpacer(25.0),
              ElevatedButton(
                child: Text('ok'.tr),
                onPressed: Get.back,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
