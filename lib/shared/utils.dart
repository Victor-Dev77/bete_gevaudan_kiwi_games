import 'package:get/get.dart';
import 'package:kiwigames/providers/providers.dart';

void back(String path) {
  Get.previousRoute == '' ? Get.offAllNamed(path) : Get.back();
}

String baseUrl = 'https://kiwigames.ovh';
var userProvider = UserProvider()..baseUrl = '$baseUrl/api/auth/';
var lobbyProvider = LobbyProvider()..baseUrl = '$baseUrl/test/';
