import 'package:get/get.dart';

class HomeController extends GetxController {
  void goToMasterScreen() {
    // Get.toNamed('/master-screen');
    Get.toNamed('/lobby?type=private&screen=principale&host=false');
  }

  void goToPlayerScreen() {
    Get.toNamed('/login');
  }
}
