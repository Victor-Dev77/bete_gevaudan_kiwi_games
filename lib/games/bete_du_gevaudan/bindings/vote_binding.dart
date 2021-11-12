import 'package:get/get.dart';
import 'package:kiwigames/games/bete_du_gevaudan/modules/vote/vote_controller.dart';

class VoteBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(VoteController());
  }
}
