import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiwigames/controllers/controllers.dart';

class BrowseMiddleWare extends GetMiddleware {
  @override
  int? get priority => 0;

  @override
  RouteSettings? redirect(String? route) {
    if (!Get.isRegistered<UserController>()) {
      return const RouteSettings(name: '/login');
    }
  }
}
