import 'package:kiwigames/games/bete_du_gevaudan/model/player.dart';

class MaleAlpha extends Player {
  Player? playerWillKill;

  MaleAlpha({required int id, required String name, this.playerWillKill})
      : super(id: id, name: name, typePlayer: TypePlayer.MALE_ALPHA);
}
