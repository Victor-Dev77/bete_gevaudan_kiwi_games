import 'package:chewie/chewie.dart';
import 'package:get/get.dart';
import 'package:kiwigames/games/bete_du_gevaudan/model/player.dart';
import 'package:video_player/video_player.dart';

class MaleAlphaRoleController extends GetxController {
  Player? playerSelected;

  final videoPlayerController = VideoPlayerController.asset(
      'assets/images/platform/games/bete_du_gevaudan/foret.mp4');
  ChewieController? _chewieController;
  ChewieController get chewieController => this._chewieController!;
  RxBool _videoCharged = false.obs;
  bool get videoCharged => _videoCharged.value;

  @override
  void onInit() {
    super.onInit();
    _initVideo();
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

  clickPlayer(Player player) {
    playerSelected = player;
    update();
  }

  isPlayer(Player player) => player.id == playerSelected?.id;
}
