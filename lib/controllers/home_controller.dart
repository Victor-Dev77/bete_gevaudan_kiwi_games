import 'package:get/get.dart';

class HomeController extends GetxController {
  void goToMasterScreen() {
    Get.toNamed('/master-screen');
  }

  void goToPlayerScreen() {
    Get.toNamed('/login');
  }
}
