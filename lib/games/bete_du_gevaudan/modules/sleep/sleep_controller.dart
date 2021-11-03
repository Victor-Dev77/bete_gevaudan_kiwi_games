import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:kiwigames/games/bete_du_gevaudan/model/server.dart';
import 'package:kiwigames/games/bete_du_gevaudan/modules/player/player_controller.dart';
import 'package:get/get.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class SleepController extends GetxController {
  final videoPlayerController = VideoPlayerController.asset(
      'assets/images/platform/games/bete_du_gevaudan/foret.mp4');
  ChewieController? _chewieController;
  ChewieController get chewieController => this._chewieController!;
  RxBool _videoCharged = false.obs;
  bool get videoCharged => _videoCharged.value;

  final assetsAudioPlayer = AssetsAudioPlayer.newPlayer();

  @override
  void onInit() {
    super.onInit();
    _initVideo();
    //_initAudio();
  }

  _initVideo() async {
    await videoPlayerController.initialize();
    _chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      autoPlay: true,
      looping: true,
      showControls: false,
      showOptions: false,
      fullScreenByDefault: true,
    );
    _videoCharged.value = true;
    Future.delayed(Duration(seconds: 5), () {
      if (PlayerController.to.player.isPrincipale)
        Server.instance.nextPage(GameTour.MARIEUSE_WAKE);
    });
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
    videoPlayerController.dispose();
    _chewieController?.dispose();
    assetsAudioPlayer.dispose();
    super.onClose();
  }
}
