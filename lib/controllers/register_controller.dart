import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kiwigames/controllers/controllers.dart';
import 'package:kiwigames/models/models.dart';
import 'package:kiwigames/shared/shared.dart';

class RegisterController extends GetxController {
  final loading = false.obs;
  final rememberMe = false.obs;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController telephoneController = TextEditingController();

  @override
  void onClose() {
    emailController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    telephoneController.dispose();
    super.onClose();
  }

  void register() async {
    loading(true);
    if (formKey.currentState!.validate()) {
      String email = emailController.text.trim();
      String username = usernameController.text.trim();
      String password = passwordController.text.trim();
      var res = await userProvider.register(
        email: email,
        username: username,
        password: password,
      );
      if (res.statusCode == 200) {
        if (rememberMe()) {
          GetStorage().write('login_uuid', res.body['user']['login_uuid']);
        }
        User user = User(email: email, username: username, isActive: true);
        Get.put(UserController(user), permanent: true);
        Get.offAllNamed('/join-lobby');
      } else {
        Get.dialog(ErrorAlert('user_already_exist'.tr));
      }
    }
    loading(false);
  }
}
