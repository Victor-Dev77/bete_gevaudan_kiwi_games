import 'package:get/get.dart';
import 'package:kiwigames/games/bete_du_gevaudan/modules/distrib_role/distrib_role_controller.dart';


class DistribRoleBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DistribRoleController());
  }
}