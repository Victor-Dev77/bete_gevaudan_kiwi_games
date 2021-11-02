import 'package:kiwigames/games/bete_du_gevaudan/model/player.dart';

class Sorciere extends Player {
  bool savePlayer;
  Player? playerWantKill;

  Sorciere(
      {required int id,
      required String name,
      this.playerWantKill,
      this.savePlayer: false})
      : super(id: id, name: name, typePlayer: TypePlayer.SORCIERE);
}
