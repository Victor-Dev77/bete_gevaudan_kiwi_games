import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:kiwigames/games/bete_du_gevaudan/modules/player/player_controller.dart';
import 'package:get/get.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class SleepController extends GetxController {
  final videoPlayerController = VideoPlayerController.asset('assets/foret.mp4');
  ChewieController? _chewieController;
  ChewieController get chewieController => this._chewieController!;
  RxBool _videoCharged = false.obs;
  bool get videoCharged => _videoCharged.value;

  final assetsAudioPlayer = AssetsAudioPlayer.newPlayer();

  @override
  void onInit() {
    super.onInit();
    _initVideo();
    _initAudio();
    //Future.delayed(Duration(seconds: 5),
    //    () => PlayerController.to.switchGameTour(GameTour.MARIEUSE_WAKE));
  }

  _initVideo() async {
    await videoPlayerController.initialize();
    _chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      autoPlay: true,
      looping: true,
      showControls: false,
      showOptions: false,
    );
    _videoCharged.value = true;
  }

  _initAudio() async {
    assetsAudioPlayer.open(
      Audio("assets/foret_audio.mp3"),
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
