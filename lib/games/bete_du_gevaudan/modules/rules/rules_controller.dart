import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiwigames/games/bete_du_gevaudan/modules/player/player_controller.dart';
import 'package:video_player/video_player.dart';

class RulesController extends GetxController {
  String pathVideo =
      "assets/images/platform/games/bete_du_gevaudan/clair_de_lune_no_sound.mp4";
  late VideoPlayerController videoPlayerController;
  ChewieController? _chewieController;
  ChewieController get chewieController => this._chewieController!;
  RxBool _videoCharged = false.obs;
  bool get videoCharged => _videoCharged.value;
  RxBool _introGame = true.obs;
  bool get introGame => _introGame.value;

  @override
  void onInit() {
    super.onInit();
    if (PlayerController.to.player.isPrincipale)
      pathVideo =
          "assets/images/platform/games/bete_du_gevaudan/clair_de_lune.mp4";
    videoPlayerController = VideoPlayerController.asset(pathVideo);
    videoPlayerController.setLooping(true);
    _initVideo();
  }

  _initVideo() async {
    await videoPlayerController.initialize();
    _chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      aspectRatio: 16 / 9,
      autoPlay: true,
      looping: true,
      showControls: false,
      showOptions: false,
      fullScreenByDefault: true,
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(
            errorMessage,
            style: TextStyle(color: Colors.red),
          ),
        );
      },
    );
    videoPlayerController.play();
    _videoCharged.value = true;
    Future.delayed(Duration(seconds: 7), () => _introGame.value = false);
  }
}
