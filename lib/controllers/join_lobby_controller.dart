import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiwigames/controllers/controllers.dart';
import 'package:kiwigames/shared/shared.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

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
    loading(true);
    if (formKey.currentState!.validate()) {
      if (isGuest) {
        redirect(false);
      } else {
        Get.dialog(InfoAlert(
          onConfirm: () => redirect(true),
          onCancel: () => redirect(false),
        ));
      }
      // Get.offAllNamed('/join-lobby');
    }
    loading(false);
  }

  void redirect(bool host) {
    String username = isGuest
        ? pseudoController.text.trim()
        : Get.find<UserController>().user.username;
    String code = lobbyCodeController.text.trim();
    Get.put(
      LobbyController(
        screen: 'user',
        host: host,
        code: code,
        username: username,
      ),
      permanent: true,
    );
    String to = host ? '/browse' : '/lobby';
    Get.offAllNamed(to);
  }
}
