import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class LoginController extends GetxController {
  final loading = false.obs;
  final rememberMe = false.obs;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void onInit() async {
    print('inited controller');
    final _channel = WebSocketChannel.connect(
      Uri.parse('wss://kiwigames.ovh'),
    );
    _channel.stream.listen((data) {
      // data type = Uint8List, we have to decode it in order to have a string
      String dataString = utf8.decode(data);
      print(dataString);
    });
    print('send data');
    Map<String, String> data = {
      'event': 'action',
      'message': 'salut é à ù',
    };
    var jsonData = json.encode(data);
    _channel.sink.add(jsonData);
    super.onInit();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void login() async {
    loading(true);
    loading(false);
  }
}
