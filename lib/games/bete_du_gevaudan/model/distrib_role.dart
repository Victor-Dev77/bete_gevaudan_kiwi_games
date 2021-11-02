import 'dart:math';
import 'package:kiwigames/games/bete_du_gevaudan/model/player.dart';

class DistribRole {
  static List<TypePlayer> _listRole = [
    TypePlayer.LOUP,
    TypePlayer.MALE_ALPHA,
    TypePlayer.VILLAGEOIS,
    TypePlayer.SORCIERE,
    TypePlayer.PETITE_FILLE,
    TypePlayer.MEDIUM,
    TypePlayer.PROTECTEUR,
    TypePlayer.LE_PETIT_FARCEUR,
    TypePlayer.MARIEUSE
  ];

  static Map<int, TypePlayer> _players = {};
  static List<int> _listPlayerWithRole = [];

  static Random _rnd = Random();

  static Map<int, TypePlayer> distribRoles(int nbPlayer) {
    print("Nombre de joueurs: $nbPlayer");

    // Nombre de loup en fonction nb joueur
    int nbLoup = _getNbLoupByNbPlayer(nbPlayer);
    print("Loup: $nbLoup");
    // Repartir les loups dans les joueurs
    int i = 0;
    do {
      // verifie si joueur n'a pas deja un role
      int indexPlayer = -1;
      do {
        indexPlayer = 1 + _rnd.nextInt(nbPlayer);
      } while (_listPlayerWithRole.contains(indexPlayer));
      // assigne role au joueur index X
      _players[indexPlayer] = _listRole[0];
      // ajout dans list deja role
      _listPlayerWithRole.add(indexPlayer);
      i++;
    } while (i < nbLoup);

    // supprime role loup dans liste
    _listRole.removeAt(0);

    // recupere index des autres joueurs
    List<int> anotherPlayer =
        _getListOtherPlayer(_listPlayerWithRole, nbPlayer);
    print(anotherPlayer);
    int lengthListOtherPlayer = anotherPlayer.length;
    for (int i = 0; i < lengthListOtherPlayer; i++) {
      // si plus de role => alors villageois
      if (_listRole.length == 0)
        _players[anotherPlayer[i]] = TypePlayer.VILLAGEOIS;
      else {
        // Trouve un role aleatoire
        int indexRole = _rnd.nextInt(_listRole.length);
        // Assigne le role au joueur
        _players[anotherPlayer[i]] = _listRole[indexRole];
        // Supprime le role de la liste
        _listRole.removeAt(indexRole);
      }

      _listPlayerWithRole.add(anotherPlayer[i]);
    }

    // Affichage des joueurs
    print(_players);
    return _players;
  }

  static int _getNbLoupByNbPlayer(int nbPlayer) {
    var listNbLoup = _getListNbLoup(nbPlayer);
    int nbLoupFinal = 0;
    if (listNbLoup.length == 1)
      nbLoupFinal = listNbLoup.first;
    else
      nbLoupFinal = _getNbLoupFinal(listNbLoup[0], listNbLoup[1]);
    return nbLoupFinal;
  }

  static List<int> _getListNbLoup(int nbPlayer) {
    List<int> list = [];
    var res = 0.5 * nbPlayer - 1;
    if (res - res.floor() == 0.5) {
      list.add(res.floor());
      list.add(res.floor() + 1);
    } else {
      list.add(res.toInt());
    }
    return list;
  }

  static int _getNbLoupFinal(int min, int max) {
    Random rnd = Random();
    return min + rnd.nextInt(max - min + 1);
  }

  static List<int> _getListOtherPlayer(List<int> listWithRole, int nbPlayer) {
    List<int> list = [];
    for (int i = 1; i <= nbPlayer; i++) {
      if (!listWithRole.contains(i)) list.add(i);
    }
    return list;
  }
}
