import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiwigames/controllers/controllers.dart';
import 'package:kiwigames/models/models.dart';
import 'package:kiwigames/providers/providers.dart';
import 'package:kiwigames/shared/shared.dart';

class JoinLobbyController extends GetxController {
  final loading = false.obs;
  bool isGuest = Get.parameters['guest'] != null;
  bool isMasterScreen = Get.parameters['master-screen'] != null;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController pseudoController = TextEditingController();
  final TextEditingController lobbyCodeController = TextEditingController();

  String get pseudo => pseudoController.text.trim();
  String get lobbyCode => lobbyCodeController.text.trim();

  @override
  void onInit() {
    if (Get.isRegistered<LobbyController>()) {
      Get.delete<LobbyController>(force: true);
    }
    super.onInit();
  }

  @override
  void onClose() {
    pseudoController.dispose();
    lobbyCodeController.dispose();
    super.onClose();
  }

  void joinLobby() async {
    loading(true);
    if (formKey.currentState!.validate()) {
      var res = await lobbyProvider.checkLobby(lobbyCode);
      if (res.statusCode == 404) {
        Get.dialog(ErrorAlert('could_not_find_lobby'.tr));
      } else {
        if (isGuest) {
          bool pseudoAlreadyExist = res.body['user'].any((el) {
            LobbyUser user = LobbyUser.fromJson(el);
            return user.username == pseudo;
          });
          if (pseudoAlreadyExist) {
            Get.dialog(ErrorAlert('username_already_used'.tr));
          } else {
            Get.put(
              UserController(User(username: pseudo)),
              permanent: true,
            );
            redirect(false);
          }
        } else if (isMasterScreen) {
          redirect(false);
        } else {
          if (res.body['host'] != null) {
            redirect(false);
          } else {
            Get.dialog(NoHostAlert(
              onConfirm: () => redirect(true),
              onCancel: () => redirect(false),
            ));
          }
        }
      }
    }
    loading(false);
  }

  void redirect(bool host) {
    String screen = isMasterScreen ? 'principale' : 'user';
    String? username = isMasterScreen
        ? null
        : isGuest
            ? pseudo
            : UserController.to.user.username;
    String code = lobbyCode;
    Get.put(
      LobbyController(
        screen: screen,
        host: host,
        code: code,
        username: username,
        isGuest: isGuest,
      ),
      permanent: true,
    );
    String to = host ? '/browse' : '/lobby';
    Get.offAllNamed(to);
  }
}
