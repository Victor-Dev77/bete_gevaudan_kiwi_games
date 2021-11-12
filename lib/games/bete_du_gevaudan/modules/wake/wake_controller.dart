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
  RxInt _resultVoteDead = 0.obs;
  int get resultVoteDead => _resultVoteDead.value;
  List<Player> playerVoted = [];

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

    // Determiné majorité ou égalité
    var playerVote = _getMajority(killsByLoup, killsByLoup.length);
    if (playerVote == null) {
      // Egalité mais verifier sorciere

      // Egalité
      print("egalité");
      _resultVoteDead.value = 1;
      _initAudio("wake_without_dead_");
    } else {
      // Joueur voté
      if (playerKillByMaleAlpha != null &&
          playerVote.typePlayer == TypePlayer.MALE_ALPHA) {
        //Mort Male Alpha mais transferer a autre joueur
        playerVote = playerKillByMaleAlpha;
        print("male alpha");
      }
      if (playerProtected != null && playerProtected.name == playerVote.name) {
        // Pas de mort grace au protecteur
        print("sauvé par le protecteur");
        _resultVoteDead.value = 1;
        _initAudio("wake_without_dead_");
      } else {
        // Mort
        if (married != null) {
          var index =
              married.indexWhere((element) => element.name == playerVote!.name);
          if (index != -1) {
            // Marrié donc 2 mort
            print("married");
            playerVoted.addAll(married);
            _resultVoteDead.value = 2;
            _initAudio("wake_with_dead_");
            Server.instance.deadPlayerList(playerVoted);
          } else {
            // Juste playerVote de mort
            print("dead");
            _resultVoteDead.value = 2;
            playerVoted.add(playerVote);
            _initAudio("wake_with_dead_");
            Server.instance.deadPlayer(playerVote);
          }
        } else {
          // Juste playerVote de mort
          print("dead");
          _resultVoteDead.value = 2;
          _initAudio("wake_with_dead_");
          playerVoted.add(playerVote);
          Server.instance.deadPlayer(playerVote);
        }
      }
    }
  }

  Player? _getMajority(List<Player> array, int size) {
    int count = 0;
    int i = 0;
    Player? majorityElement;
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

  _initAudio(String prefix) async {
    int i = 1 + Random().nextInt(3);
    await justAudioPlayer.setAsset(
        "assets/images/platform/games/bete_du_gevaudan/voix/$prefix$i.mp3");
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
          Server.instance.nextPage(GameTour.VOTE);
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
