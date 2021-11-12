import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiwigames/shared/shared.dart';

class ResetPasswordController extends GetxController {
  String? code = Get.parameters['code'];

  final loading = false.obs;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();

  String get newPassword => newPasswordController.text.trim();
  String get confirmNewPassword => confirmNewPasswordController.text.trim();

  void resetPassword() async {
    loading(true);
    if (formKey.currentState!.validate()) {
      var res =
          await userProvider.resetPassword(password: newPassword, code: code!);
      Widget alert = res.body['sucess']
          ? InfoAlert(
              'password_reseted'.tr,
              onPressed: () => Get.offAllNamed('/login'),
            )
          : ErrorAlert(
              'reset_error'.tr,
              onPressed: () => Get.offAllNamed('/forgot-password'),
            );
      Get.dialog(alert);
    }
    loading(false);
  }
}
