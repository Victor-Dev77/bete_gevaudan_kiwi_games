import 'dart:math';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:kiwigames/games/bete_du_gevaudan/model/player.dart';
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
    print("-----  WAKE UP VILLAGE  -------");
    print(PlayerController.to.playerKillByLoup);
    print(PlayerController.to.married);
    print(PlayerController.to.playerProtected);
    print(PlayerController.to.playerWillKillIfMaleAlphaDie);
    print("-------------------------------");
    if (PlayerController.to.player.isPrincipale) {
      _checkSortOfTour();
      _initAudio();
      _initVideo();
    }
  }

  //TODO faire apres le ready des loups si plusieurs loup

  _checkSortOfTour() {
    List<Player> killsByLoup = PlayerController.to.playerKillByLoup;
    List<Player>? married = PlayerController.to.married;
    Player? playerProtected = PlayerController.to.playerProtected;
    Player? playerKillByMaleAlpha =
        PlayerController.to.playerWillKillIfMaleAlphaDie;
    //TODO manque sorciere
    if (killsByLoup.length == 1) {
      // Considere qu'il y a 1 mort minimum (s'il n'est pas sauvé par protecteur)
    } else {
      // Determiné majorité ou égalité
      Map<String, int> compteurOfPlayer = {};
      killsByLoup.forEach((victime) {
        compteurOfPlayer[victime.name] = compteurOfPlayer[victime.name] != null
            ? compteurOfPlayer[victime.name]! + 1
            : 0;
      });
      print("compteur of players: $compteurOfPlayer");
      compteurOfPlayer.values.reduce(max);
    }
  }

  Player _getMajority(List<Player> killsByLoup) {
    var modeMap = {};
    var maxEl = killsByLoup[0];
    var maxCount = 1;
    for (var i = 0; i < killsByLoup.length; i++) {
      var el = killsByLoup[i];
      if (modeMap[el.name] == null)
        modeMap[el.name] = 1;
      else
        modeMap[el.name]++;
      if (modeMap[el.name] > maxCount) {
        maxEl = el;
        maxCount = modeMap[el.name];
      }
    }
    return maxEl;
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
