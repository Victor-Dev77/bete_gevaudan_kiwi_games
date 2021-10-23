import 'package:kiwigames/controllers/controllers.dart';
import 'package:get/get.dart';

class TabBarBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(TabBarController());
  }
}
