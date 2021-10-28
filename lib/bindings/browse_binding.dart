import 'package:get/get.dart';
import 'package:kiwigames/controllers/controllers.dart';

class BrowseBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(BrowseController());
  }
}
