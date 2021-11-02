import 'package:kiwigames/controllers/controllers.dart';
import 'package:get/get.dart';

class ForgotPasswordBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(ForgotPasswordController());
  }
}
