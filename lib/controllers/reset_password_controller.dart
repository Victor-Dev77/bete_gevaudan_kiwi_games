import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiwigames/shared/shared.dart';

class ResetPasswordController extends GetxController {
  String? id = Get.parameters['id'];

  final loading = false.obs;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();

  String get newPassword => newPasswordController.text.trim();
  String get confirmNewPassword => confirmNewPasswordController.text.trim();

  void resetPassword() async {
    loading(true);
    if (formKey.currentState!.validate()) {
      await 1.delay();
      Get.dialog(
        InfoAlert(
          'password_reseted'.tr,
          onPressed: () => Get.offAllNamed('/login'),
        ),
      );
      print(newPassword);
      print(confirmNewPassword);
    }
    loading(false);
  }
}
