import 'dart:convert';

import 'package:kiwigames/games/bete_du_gevaudan/utils/constant/constant_image.dart';

enum TypePlayer {
  LOUP,
  SORCIERE,
  PETITE_FILLE,
  MEDIUM,
  PROTECTEUR,
  LE_PETIT_FARCEUR,
  MARIEUSE,
  MALE_ALPHA,
  VILLAGEOIS,
}

class Player {
  final int id;
  String name;
  TypePlayer? typePlayer;
  bool isKill;
  bool isSelectedToKill;
  bool isHost;
  String screen;
  bool isPrincipale;

  Player(
      {required this.id,
      required this.name,
      this.typePlayer,
      this.isKill: false,
      this.isSelectedToKill: false,
      this.isHost: false,
      this.screen: "user",
      this.isPrincipale: false});

  set setTypePlayer(TypePlayer value) => this.typePlayer = value;

  String get imageTypePlayer {
    switch (typePlayer) {
      case TypePlayer.LOUP:
        return ConstantImage.card_loup;
      case TypePlayer.SORCIERE:
        return ConstantImage.card_sorciere;
      case TypePlayer.PETITE_FILLE:
        return ConstantImage.card_petite_fille;
      case TypePlayer.MEDIUM:
        return ConstantImage.card_medium;
      case TypePlayer.PROTECTEUR:
        return ConstantImage.card_protecteur;
      case TypePlayer.LE_PETIT_FARCEUR:
        return ConstantImage.card_petit_farceur;
      case TypePlayer.MARIEUSE:
        return ConstantImage.card_marieuse;
      case TypePlayer.MALE_ALPHA:
        return ConstantImage.card_male_alpha;
      case TypePlayer.VILLAGEOIS:
        return ConstantImage.card_villageois;
      default:
        return ConstantImage.card_villageois;
    }
  }

  String get nameTypePlayer {
    switch (typePlayer) {
      case TypePlayer.LOUP:
        return "LOUP-GAROU";
      case TypePlayer.SORCIERE:
        return "SORCIERE";
      case TypePlayer.PETITE_FILLE:
        return "PETITE FILLE";
      case TypePlayer.MEDIUM:
        return "MEDIUM";
      case TypePlayer.PROTECTEUR:
        return "PROTECTEUR";
      case TypePlayer.LE_PETIT_FARCEUR:
        return "LE PETIT FARCEUR";
      case TypePlayer.MARIEUSE:
        return "MARIEUSE";
      case TypePlayer.MALE_ALPHA:
        return "MALE ALPHA";
      case TypePlayer.VILLAGEOIS:
        return "VILLAGEOIS";
      default:
        return "VILLAGEOIS";
    }
  }

  String get ruleTypePlayer {
    switch (typePlayer) {
      case TypePlayer.LOUP:
        return "lA NUIT, TU DEVIENS LOUP_GAROU ! TU DECIDES ALORS AVEC TES CONGENERES QUI SERA LA PROCHAINE VICTIME";
      case TypePlayer.SORCIERE:
        return "TU AS LE DROIT DE REMPLACER LA VICTIME DES LOUP-GAROU PAR UN AUTRE VILLAGEOIS. ATTENTION, TU NE POURRAS LE FAIRE QU'UNE FOIS !";
      case TypePlayer.PETITE_FILLE:
        return "DURANT TOUTE LA NUIT TU VAS POUVOIR ESPIONNER TOUT LE VILLAGE, MAIS RESTE DISCRETE SINON LA MORT TE GUETTE";
      case TypePlayer.MEDIUM:
        return "TU AS LE DROIT DE DECOUVRIR L'IDENTITE D'UNE PERSONNE DE TON CHOIX AU DEBUT DE LA PARTIE";
      case TypePlayer.PROTECTEUR:
        return "A CHAQUE DEBUT DE NUIT, TU AS LE POUVOIR DE PROTEGER UNE PERSONNE DE TON CHOIX";
      case TypePlayer.LE_PETIT_FARCEUR:
        return "A TA MORT, TU FERAS VIBRER LE TELEPHONE DES VILLAGEOIS, MAIS LE TELEPHONE DES LOUP-GAROUS RESTERA INERTE";
      case TypePlayer.MARIEUSE:
        return "AU DEBUT DE LA PREMIERE NUIT, TU UNIRAS DEUX PERSONNES DE TON CHOIX. SI L'UNE MEURT, L'AUTRE MOURRA AVEC ELLE";
      case TypePlayer.MALE_ALPHA:
        return "LA NUIT, TU DEVIENS LOUP-GAROU !\nTU DECIDES ALORS AVEC TES CONGENERES QUI SERA LA PROCHAINE VICTIME. EN TANT QUE MALE ALPHA, TU DESIGNE AU DEBUT DE LA PARTIE UN VILLAGEOIS QUI MOURRA A TA PLACE SI LE VILLAGE VOTE CONTRE TOI";
      case TypePlayer.VILLAGEOIS:
        return "TU ES VILLAGEOIS, TU DOIS DEBUSQUER LES LOUP-GAROUS ET ORIENTER LES VOTES CONTRE EUX AU MOMENT DES CONSEILS DU VILLAGE";
      default:
        return "TU ES VILLAGEOIS, TU DOIS DEBUSQUER LES LOUP-GAROUS ET ORIENTER LES VOTES CONTRE EUX AU MOMENT DES CONSEILS DU VILLAGE";
    }
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "name": name, "typePlayer": typePlayer.toString()};
  }

  @override
  String toString() => json.encode(toJson());

  /*factory Player.fromDocument(Map<dynamic, dynamic> map) {
    return Player(
      id: map['uid'],
    );
  }*/
}
