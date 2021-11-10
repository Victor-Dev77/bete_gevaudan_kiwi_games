import 'package:kiwigames/games/bete_du_gevaudan/model/player.dart';

class Marieuse extends Player {
  List<Player>? married;

  Marieuse({required int id, required String name, this.married})
      : super(id: id, name: name, typePlayer: TypePlayer.MARIEUSE);
}
