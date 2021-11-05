import 'package:kiwigames/games/bete_du_gevaudan/modules/roles/male_alpha/male_alpha_role_controller.dart';
import 'package:get/get.dart';

class MaleAlphaRoleBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MaleAlphaRoleController(), permanent: true);
  }
}
