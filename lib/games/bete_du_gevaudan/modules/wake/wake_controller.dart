import 'dart:math';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:kiwigames/games/bete_du_gevaudan/model/server.dart';
import 'package:kiwigames/games/bete_du_gevaudan/modules/player/player_controller.dart';
import 'package:video_player/video_player.dart';

class WakeController extends GetxController {
  static WakeController get to => Get.find();
  final AudioPlayer justAudioPlayer = AudioPlayer();

  final videoPlayerController = VideoPlayerController.asset(
      'assets/images/platform/games/bete_du_gevaudan/reveil_village.mp4');
  ChewieController? _chewieController;
  ChewieController get chewieController => this._chewieController!;
  RxBool _videoCharged = false.obs;
  bool get videoCharged => _videoCharged.value;

  @override
  void onInit() {
    super.onInit();
    if (PlayerController.to.player.isPrincipale) {
      _initAudio();
      _initVideo();
    }
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
    _videoCharged.value = true;
  }

  _initAudio() async {
    int i = 1 + Random().nextInt(3);
    await justAudioPlayer.setAsset(
        "assets/images/platform/games/bete_du_gevaudan/voix/wake_without_dead_$i.mp3");
    justAudioPlayer.play();
    justAudioPlayer.playerStateStream.listen((state) {
      print(state.processingState);
      switch (state.processingState) {
        case ProcessingState.idle:
          break;
        case ProcessingState.loading:
          break;
        case ProcessingState.buffering:
          break;
        case ProcessingState.ready:
          break;
        case ProcessingState.completed:
          Future.delayed(PlayerController.to.durationChrono, () {
            Server.instance.nextPage(GameTour.VOTE);
          });
          break;
      }
    });
  }

  @override
  void onClose() {
    justAudioPlayer.dispose();
    super.onClose();
  }
}
