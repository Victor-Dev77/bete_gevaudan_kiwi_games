import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiwigames/controllers/user_controller.dart';
import 'package:kiwigames/models/models.dart';
import 'package:kiwigames/shared/shared.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class LobbyController extends GetxController {
  static LobbyController get to => Get.find();

  static final TextTheme textTheme = Get.textTheme;

  final String screen;
  final String? code;
  final String? username;
  bool host;
  final bool isGuest;

  final loading = false.obs;
  final lobbyCode = ''.obs;
  final userList = <LobbyUser>[].obs;

  UserController? userController;
  WebSocketChannel? lobby;
  // TODO "brancher" le controlleur du jeu au streamcontroller ci dessous
  StreamController gameStream = StreamController();

  LobbyController({
    required this.screen,
    this.code,
    this.username,
    required this.host,
    this.isGuest = false,
  });

  @override
  void onInit() {
    userController = screen != 'principale' ? UserController.to : null;
    createLobby();
    super.onInit();
  }

  void sendToLobby(Map<String, dynamic> data) {
    String jsonData = jsonEncode(data);
    lobby?.sink.add(jsonData);
  }

  void bindLobbyControllerListener() {
    lobby?.stream.listen(
      (data) {
        Map<String, dynamic> res = jsonDecode(data);
        print(res);
        String? type = res['type'];
        // TODO nouveau event user :
        // notif user disconnected
        // notif user reconnected
        if (type == 'notif new user' ||
            type == 'first connect' ||
            type == 'notif new host' ||
            type == 'notif leave user') {
          handleLobbyPlayers(res);
        } else if (res['message'] is! String) {
          if (res['message']['play game'] != null) {
            String gamePath = res['message']['play game'];
            Get.offAllNamed(gamePath);
          }
        } else {
          // si c'est pour le jeu
          gameStream.add(res);
        }
      },
      onDone: () => print('ws done'),
      onError: (error) => print(error),
      cancelOnError: false,
    );
  }

  void createLobby() async {
    loading(true);
    Map<String, dynamic> data = {
      'type': 'first connect',
      'screen': screen,
      'host': host,
    };
    if (code == null) {
      var lobby = await lobbyProvider.createLobby();
      String _code = lobby.body['url'];
      lobbyCode(_code.substring(1));
    } else {
      lobbyCode(code);
    }
    if (username != null) {
      data['user'] = LobbyUser(
        username: username!,
        screen: screen,
        isHost: host,
      ).toJson();
    }
    lobby = lobbyProvider.connectToLobby(lobbyCode());
    bindLobbyControllerListener();
    sendToLobby(data);
    loading(false);
  }

  void handleLobbyPlayers(Map<String, dynamic> res) {
    var users = res['data'];
    if (users == null || users.isEmpty) return;
    LobbyUser lastUser = LobbyUser.fromJson(users.last);
    if ((res['type'] == 'notif new user' &&
            userController?.user.username != username) ||
        screen == 'principale') {
      showNewPlayer(lastUser);
    }
    List<LobbyUser> newUsers = [];
    for (final user in users) {
      newUsers.add(LobbyUser.fromJson(user));
    }
    userList(newUsers);
  }

  void showNewPlayer(LobbyUser user) {
    Get.snackbar(
      '',
      '',
      titleText: Text(
        'new_player'.tr,
        style: textTheme.headline6,
      ),
      messageText: Text(
        user.username,
        style: textTheme.headline5!.copyWith(color: primaryColor.color),
      ),
    );
  }

  void setHost() {
    print('setting host');
    host = true;
    sendToLobby({
      'type': 'first connect',
      'screen': screen,
      'host': host,
      'user': LobbyUser(
        username: username!,
        screen: screen,
        isHost: host,
      ).toJson(),
    });
    Get.offAllNamed('/browse');
  }
}
