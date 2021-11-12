import 'package:get/get.dart';
import 'package:kiwigames/controllers/controllers.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
  }
}
