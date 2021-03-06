import 'dart:math';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
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

  final AudioPlayer justAudioPlayer = AudioPlayer();

  @override
  void onInit() {
    super.onInit();
    if (PlayerController.to.player.isPrincipale) {
      _initAudio();
      _initVideo();
    }
    var res = PlayerController.to.attributTypePlayer();
    _playerHasRole.value = res;
  }

  @override
  void onClose() {
    justAudioPlayer.dispose();
    videoPlayerController.dispose();
    _chewieController?.dispose();
    super.onClose();
  }

  _initAudio() async {
    int i = 1 + Random().nextInt(3);
    await justAudioPlayer.setAsset(
        "assets/images/platform/games/bete_du_gevaudan/voix/attribution_des_roles_$i.mp3");
    justAudioPlayer.play();
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
