import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  final loading = false.obs;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

  String get email => emailController.text.trim();

  void reinitialisePassword() {
    loading(true);
    if (formKey.currentState!.validate()) {}
    loading(false);
  }
}
