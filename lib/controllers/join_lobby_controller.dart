import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiwigames/bindings/user_binding.dart';
import 'package:kiwigames/shared/colors.dart';
import 'package:kiwigames/shared/shared.dart';

class JoinLobbyController extends GetxController {
  final loading = false.obs;
  bool isGuest = Get.parameters['guest'] != null;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController pseudoController = TextEditingController();
  final TextEditingController lobbyCodeController = TextEditingController();

  @override
  void onClose() {
    pseudoController.dispose();
    lobbyCodeController.dispose();
    super.onClose();
  }

  void joinLobby() async {
    /*  String pseudo = pseudoController.text.trim();
    String lobbyCode = lobbyCodeController.text.trim();
    if (lobbyCode.isEmpty) {
      return;
    }
    if (isGuest && pseudo.isEmpty) {
      return;
    } */
    loading(true);
    await Future.delayed(const Duration(seconds: 1));
    Get.dialog(InfoAlert(
      onConfirm: () => Get.offAllNamed('/browse'),
      onCancel: () => Get.offAllNamed('/lobby'),
    ));
    loading(false);
  }
}
