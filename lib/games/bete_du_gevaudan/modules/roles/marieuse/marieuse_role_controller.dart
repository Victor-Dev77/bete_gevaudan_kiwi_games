import 'dart:math';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:kiwigames/games/bete_du_gevaudan/model/player.dart';
import 'package:kiwigames/games/bete_du_gevaudan/modules/player/player_controller.dart';
import 'package:video_player/video_player.dart';

class MarieuseRoleController extends GetxController {
  static MarieuseRoleController get to => Get.find();

  List<Player> listPlayerUnis = [];
  final AudioPlayer justAudioPlayer = AudioPlayer();

  final videoPlayerController = VideoPlayerController.asset(
      'assets/images/platform/games/bete_du_gevaudan/foret.mp4');
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
        "assets/images/platform/games/bete_du_gevaudan/voix/appel_marieuse_$i.mp3");
    justAudioPlayer.play();
  }

  bool isUnionValid() => listPlayerUnis.length == 2;

  bool isContainPlayer(Player player) {
    return listPlayerUnis.contains(player);
  }

  clickPlayer(Player player) {
    if (listPlayerUnis.length < 2 && !listPlayerUnis.contains(player))
      listPlayerUnis.add(player);
    else if (listPlayerUnis.contains(player))
      listPlayerUnis.remove(player);
    else
      listPlayerUnis[1] = player;
    update();
  }

  @override
  void onClose() {
    justAudioPlayer.dispose();
    //videoPlayerController.dispose();
    //_chewieController?.dispose();
    super.onClose();
  }
}
