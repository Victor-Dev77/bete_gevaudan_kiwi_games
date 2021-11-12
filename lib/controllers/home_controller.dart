import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kiwigames/controllers/controllers.dart';
import 'package:kiwigames/models/models.dart';
import 'package:kiwigames/shared/shared.dart';

class HomeController extends GetxController {
  final loading = false.obs;

  void goToMasterScreen() {
    Get.toNamed('/master-screen');
    // Get.toNamed('/lobby?type=private&screen=principale&host=false');
  }

  void goToPlayerScreen() async {
    loading(true);
    String? loginUuid = GetStorage().read('login_uuid');
    if (loginUuid != null) {
      var res = await userProvider.loginWithUuid(loginUuid);
      if (res.statusCode == 200) {
        User user = User.fromJson(res.body);
        Get.put(UserController(user), permanent: true);
        Get.offAllNamed('/join-lobby');
      } else {
        Get.toNamed('/login');
      }
    } else {
      Get.toNamed('/login');
    }
    loading(false);
  }
}
