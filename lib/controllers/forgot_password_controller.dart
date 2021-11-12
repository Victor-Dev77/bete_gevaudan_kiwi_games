import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiwigames/shared/shared.dart';

class ForgotPasswordController extends GetxController {
  final loading = false.obs;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

  String get email => emailController.text.trim();

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }

  void resetPassword() async {
    loading(true);
    if (formKey.currentState!.validate()) {
      await userProvider.checkResetPassword(email);
      Get.dialog(InfoAlert('email_sent'.tr));
    }
    loading(false);
  }
}
