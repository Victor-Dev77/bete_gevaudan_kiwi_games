import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:kiwigames/games/bete_du_gevaudan/model/server.dart';
import 'package:kiwigames/games/bete_du_gevaudan/modules/player/player_controller.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class SleepController extends GetxController {
  final assetsAudioPlayer = AssetsAudioPlayer.newPlayer();

  final videoPlayerController = VideoPlayerController.asset(
      'assets/images/platform/games/bete_du_gevaudan/foret.mp4');
  ChewieController? _chewieController;
  ChewieController get chewieController => this._chewieController!;
  RxBool _videoCharged = false.obs;
  bool get videoCharged => _videoCharged.value;

  @override
  void onInit() {
    super.onInit();
    //_initAudio();
    _initVideo();
    Future.delayed(Duration(seconds: 5), () {
      if (PlayerController.to.player.isPrincipale)
        Server.instance.nextPage(GameTour.MARIEUSE_WAKE);
    });
  }

  _initVideo() async {
    await videoPlayerController.initialize();
    _chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      aspectRatio: 16 / 9,
      autoInitialize: true,
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
    _videoCharged.value = true;
  }

  _initAudio() async {
    await assetsAudioPlayer.open(
      Audio("assets/images/platform/games/bete_du_gevaudan/foret_audio.mp3"),
      showNotification: false,
      autoStart: true,
      loopMode: LoopMode.single,
    );
    await assetsAudioPlayer.play();
  }

  /*_playAudio() async {
    _audioPlayerResult = await _audioPlayer.play();
    var duree = await _audioPlayerResult!.getDuration();
    print("result play audio: $duree");
  }*/

  @override
  void onClose() {
    // assetsAudioPlayer.dispose();
    super.onClose();
  }
}
