import 'package:get/get.dart';
import 'package:kiwigames/games/bete_du_gevaudan/modules/result_vote/result_vote_controller.dart';

class ResultVoteBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ResultVoteController());
  }
}
