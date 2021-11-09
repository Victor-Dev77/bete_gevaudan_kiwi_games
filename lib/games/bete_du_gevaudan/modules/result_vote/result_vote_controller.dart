import 'dart:math';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:kiwigames/games/bete_du_gevaudan/model/player.dart';
import 'package:kiwigames/games/bete_du_gevaudan/model/server.dart';
import 'package:kiwigames/games/bete_du_gevaudan/modules/player/player_controller.dart';
import 'package:video_player/video_player.dart';

class ResultVoteController extends GetxController {
  final AudioPlayer justAudioPlayer = AudioPlayer();
  VideoPlayerController videoPlayerController = VideoPlayerController.asset(
      'assets/images/platform/games/bete_du_gevaudan/feu.mp4');
  ChewieController? _chewieController;
  ChewieController get chewieController => this._chewieController!;
  RxBool _videoCharged = false.obs;
  bool get videoCharged => _videoCharged.value;
  RxBool _voteWithDead = false.obs;
  bool get voteWithDead => _voteWithDead.value;
  Player? playerDead;

  @override
  void onInit() {
    super.onInit();
    if (PlayerController.to.player.isPrincipale) {
      _initAudio();
      _initVideo();
    }
  }

  _initVideo() async {
    if (PlayerController.to.playerKillByVote != null) {
      videoPlayerController = VideoPlayerController.asset(
          'assets/images/platform/games/bete_du_gevaudan/execution.mp4');
    }
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
    String audioPath = "result_vote_without_dead_";
    // result_vote_without_dead_
    // result_vote_dead_loup_
    // result_vote_dead_villageois_
    if (PlayerController.to.playerKillByVote != null) {
      _voteWithDead.value = true;
      playerDead = PlayerController.to.playerKillByVote;
      if (PlayerController.to.playerKillByVote!.typePlayer == TypePlayer.LOUP)
        audioPath = "result_vote_dead_loup_";
      else
        audioPath = "result_vote_dead_villageois_";
    }
    await justAudioPlayer.setAsset(
        "assets/images/platform/games/bete_du_gevaudan/voix/$audioPath$i.mp3");
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
          Server.instance.nextPage(GameTour.SLEEP);
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
