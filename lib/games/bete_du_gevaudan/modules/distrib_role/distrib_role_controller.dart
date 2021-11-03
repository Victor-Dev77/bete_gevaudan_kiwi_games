import 'package:chewie/chewie.dart';
import 'package:kiwigames/games/bete_du_gevaudan/model/server.dart';
import 'package:kiwigames/games/bete_du_gevaudan/modules/player/player_controller.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class DistribRoleController extends GetxController {
  static DistribRoleController get to => Get.find();

  RxBool _playerHasRole = false.obs;
  bool get playerHasRole => _playerHasRole.value;
  setPlayerHasRole(bool value) => _playerHasRole.value = value;

  RxBool _clickReadyBtn = false.obs;
  bool get clickReadyBtn => _clickReadyBtn.value;

  RxBool _showRoleDetail = false.obs;
  bool get showRoleDetail => _showRoleDetail.value;

  final videoPlayerController = VideoPlayerController.asset(
      'assets/images/platform/games/bete_du_gevaudan/feu.mp4');
  ChewieController? _chewieController;
  ChewieController get chewieController => this._chewieController!;
  RxBool _videoCharged = false.obs;
  bool get videoCharged => _videoCharged.value;

  @override
  void onInit() {
    super.onInit();
    _initVideo();
    var res = PlayerController.to.attributTypePlayer();
    _playerHasRole.value = res;
  }

  @override
  void onClose() {
    videoPlayerController.dispose();
    _chewieController?.dispose();
    super.onClose();
  }

  _initVideo() async {
    await videoPlayerController.initialize();
    _chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      autoPlay: true,
      looping: true,
      showControls: false,
      showOptions: false,
      fullScreenByDefault: true,
    );
    _videoCharged.value = true;
  }

  clickShowRole() {
    _showRoleDetail.value = true;
  }

  closeShowRole() {
    _showRoleDetail.value = false;
  }

  clickReady() {
    Server.instance.imReady();
    _clickReadyBtn.value = true;
  }
}
