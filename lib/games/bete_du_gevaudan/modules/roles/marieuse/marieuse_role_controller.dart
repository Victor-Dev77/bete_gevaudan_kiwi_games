import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiwigames/games/bete_du_gevaudan/model/player.dart';
import 'package:video_player/video_player.dart';

class MarieuseRoleController extends GetxController {
  static MarieuseRoleController get to => Get.find();

  List<Player> listPlayerUnis = [];

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
}
