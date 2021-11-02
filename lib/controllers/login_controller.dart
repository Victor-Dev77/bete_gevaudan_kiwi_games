import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiwigames/controllers/user_controller.dart';
import 'package:kiwigames/models/models.dart';
import 'package:kiwigames/shared/shared.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class LoginController extends GetxController {
  final loading = false.obs;
  final rememberMe = false.obs;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController pseudoController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void onClose() {
    pseudoController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void login() async {
    loading(true);
    if (formKey.currentState!.validate()) {
      String pseudo = pseudoController.text.trim();
      String password = passwordController.text.trim();
      var res = await userProvider.login(pseudo: pseudo, password: password);
      if (res.statusCode == 200) {
        User user = User.fromJson(res.body);
        Get.put(UserController(user), permanent: true);
        Get.offAllNamed('/join-lobby');
      } else {
        String errorMessage;
        switch (res.statusCode) {
          case 404:
            errorMessage = 'user_not_found';
            break;
          case 401:
            errorMessage = 'wrong_password';
            break;
          default:
            errorMessage = 'error';
            break;
        }
        Get.dialog(ErrorAlert(errorMessage.tr));
      }
    }
    loading(false);
  }
}
