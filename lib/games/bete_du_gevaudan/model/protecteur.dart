import 'package:kiwigames/games/bete_du_gevaudan/model/player.dart';

class Protecteur extends Player {
  Player? protected;

  Protecteur({this.protected, required int id, required String name})
      : super(id: id, name: name, typePlayer: TypePlayer.PROTECTEUR);
}
