import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class TabBarController extends GetxController
    with SingleGetTickerProviderMixin {
  int tabControllerLength = 3;
  TabController? tabController;
  Timer? timer;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(vsync: this, length: tabControllerLength);
    timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      int currentTab = tabController!.index;
      int nextTab = currentTab + 1;
      int newTab = nextTab >= tabControllerLength ? 0 : nextTab;
      tabController?.animateTo(newTab);
    });
  }

  @override
  void onClose() {
    tabController?.dispose();
    timer?.cancel();
    super.onClose();
  }
}
