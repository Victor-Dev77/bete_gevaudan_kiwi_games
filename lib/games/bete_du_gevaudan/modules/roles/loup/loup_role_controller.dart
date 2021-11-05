import 'dart:math';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:kiwigames/games/bete_du_gevaudan/model/player.dart';
import 'package:kiwigames/games/bete_du_gevaudan/model/server.dart';
import 'package:kiwigames/games/bete_du_gevaudan/modules/player/player_controller.dart';
import 'package:video_player/video_player.dart';

class LoupRoleController extends GetxController {
  static LoupRoleController get to => Get.find();

  Player? playerSelected;

  AudioPlayer justAudioPlayer = AudioPlayer();
  final videoPlayerController = VideoPlayerController.asset(
      'assets/images/platform/games/bete_du_gevaudan/foret.mp4');
  ChewieController? _chewieController;
  ChewieController get chewieController => this._chewieController!;
  RxBool _videoCharged = false.obs;
  bool get videoCharged => _videoCharged.value;
  bool changeAudio = false;
  RxBool _voiceOffFinish = false.obs;
  bool get voiceOffFinish => _voiceOffFinish.value;
  setVoiceOffFinish() => _voiceOffFinish.value = true;

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

  changeAudioForSleep() async {
    if (!changeAudio && PlayerController.to.player.isPrincipale) {
      AudioPlayer.clearAssetCache();
      justAudioPlayer = AudioPlayer();
      int i = 1 + Random().nextInt(3);
      await justAudioPlayer.setAsset(
          "assets/images/platform/games/bete_du_gevaudan/voix/sleep_loup_$i.mp3");
      justAudioPlayer.play();
      changeAudio = true;
    }
  }

  _initAudio() async {
    int i = 1 + Random().nextInt(3);
    await justAudioPlayer.setAsset(
        "assets/images/platform/games/bete_du_gevaudan/voix/appel_loup_$i.mp3");
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
          Server.instance.finishVoiceOff(
            PlayerController.to.getUsernameForTypePlayer(TypePlayer.LOUP),
            TypePlayer.LOUP,
          );
          break;
      }
    });
  }

  clickPlayer(Player player) {
    playerSelected = player;
    update();
  }

  isPlayer(Player player) => player.id == playerSelected?.id;

  @override
  void onClose() {
    justAudioPlayer.dispose();
    //videoPlayerController.dispose();
    //_chewieController?.dispose();
    Get.delete<LoupRoleController>(force: true);
    super.onClose();
  }
}
