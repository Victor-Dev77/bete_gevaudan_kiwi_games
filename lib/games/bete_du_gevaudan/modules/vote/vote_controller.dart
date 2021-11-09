import 'dart:math';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:kiwigames/games/bete_du_gevaudan/model/player.dart';
import 'package:kiwigames/games/bete_du_gevaudan/model/server.dart';
import 'package:kiwigames/games/bete_du_gevaudan/modules/player/player_controller.dart';
import 'package:video_player/video_player.dart';

class VoteController extends GetxController {
  static VoteController get to => Get.find();

  final AudioPlayer justAudioPlayer = AudioPlayer();
  final videoPlayerController = VideoPlayerController.asset(
      'assets/images/platform/games/bete_du_gevaudan/feu.mp4');
  ChewieController? _chewieController;
  ChewieController get chewieController => this._chewieController!;
  RxBool _videoCharged = false.obs;
  bool get videoCharged => _videoCharged.value;
  Player? playerSelected;
  RxBool _voted = false.obs;
  bool get voted => _voted.value;
  setVoted() {
    _voted.value = true;
    update();
  }

  Map<String, Map<String, dynamic>> playersVoted = {};

  @override
  void onInit() {
    super.onInit();
    if (PlayerController.to.player.isPrincipale) {
      _initPlayersVotedMap();
      _initAudio();
      _initVideo();
    }
  }

  _initPlayersVotedMap() {
    print("nb players: ${PlayerController.to.listPlayer.length}");
    PlayerController.to.listPlayer.forEach((p) {
      playersVoted[p.name] = {
        "cmpt": 0,
        "isDead": p.isKill,
        "votants": <Player>[],
      };
    });
    print(playersVoted);
  }

  updatePlayersVoted(Player player, Player auteur) {
    String? _key;
    int? index;
    playersVoted.forEach((key, value) {
      var i = value["votants"].indexWhere((item) => item.name == auteur.name);
      if (i != -1) {
        _key = key;
        index = i;
      }
    });
    if (_key != null) {
      playersVoted[_key]!['cmpt']--;
      playersVoted[_key]!['votants'].removeAt(index);
    }
    playersVoted[player.name]!['cmpt']++;
    playersVoted[player.name]!['votants'].add(auteur);
    update();
  }

  Player? getResultVote() {
    List<String> names = [];
    playersVoted.forEach((key, value) {
      if (value["cmpt"] > 0) {
        for (int i = 0; i < value["cmpt"]; i++) {
          names.add(key);
        }
      }
    });
    var majority = _getMajority(names, names.length);
    if (majority == null) {
      // Egalité
      print("egalité voted");
    } else {
      // Mort
      var ip1 = PlayerController.to.listPlayer
          .indexWhere((element) => element.name == majority);
      if (ip1 != -1) {
        var p = PlayerController.to.listPlayer[ip1];
        print("player voted dead => $p");
        return p;
      }
    }
    return null;
  }

  String? _getMajority(List<String> array, int size) {
    int count = 0;
    int i = 0;
    String? majorityElement;
    for (i = 0; i < size; i++) {
      if (count == 0) majorityElement = array[i];
      if (array[i] == majorityElement)
        count++;
      else
        count--;
    }
    count = 0;
    for (i = 0; i < size; i++) if (array[i] == majorityElement) count++;
    if (count > size / 2) return majorityElement;
    return null;
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
        "assets/images/platform/games/bete_du_gevaudan/voix/vote_$i.mp3");
    justAudioPlayer.play();
    /*justAudioPlayer.playerStateStream.listen((state) {
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
    });*/
  }

  clickPlayer(Player player) {
    playerSelected = player;
    update();
  }

  isPlayer(Player player) => player.id == playerSelected?.id;

  @override
  void onClose() {
    justAudioPlayer.dispose();
    super.onClose();
  }
}
