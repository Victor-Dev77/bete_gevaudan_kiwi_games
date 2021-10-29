import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiwigames/controllers/controllers.dart';
import 'package:kiwigames/models/models.dart';

class BrowseController extends GetxController
    with SingleGetTickerProviderMixin {
  final carouselSlides = <Game>[
    Game(
      name: 'La bête du Gévaudan',
      catchPhrase: 'Le jeu du loup-garou version Kiwi games',
      // TODO change game path
      gamePath: '/loup-du-gevaudan',
      description: '''
Nous sommes en l’an 1764, un loup-garou sévit dans le Gévaudan et se cache parmi les villageois.
Vous êtes ces villageois, et certains d’entre vous ont des choses à cacher...
Chaque nuit, lorsque les villageois dorment, les bêtes se réveillent et tuent leur proie. Ce sera aux villageois de voter pour tuer l’un d’entre eux en espérant qu’il soit fautif des meurtres comis.
Les bêtes doivent décimer tous les villageois pour gagner, ce sera l’inverse pour que les villageois gagnent.

3 joueurs et +
20 min de jeu
''',
      imagePath: 'assets/images/platform/games/bete_du_gevaudan.jpg',
      isAvailable: true,
    ),
    Game(
      name: 'Funny Guess',
      catchPhrase: 'Mimes et devinettes',
      description: '''
Chaque joueur doit se mettre en groupe de 2 (le dernier peut rejoindre le moins bon groupe pour aider !)
Funny Guess se joue en 3 manches sur une base de 20 mots :
· A la 1ère manche, tu dois faire deviner un maximum de mots à ton co-équipier en 30 sec, tu ne peux pas traduire des mots dans une autre langue ou utiliser des mots de la même racine.
· A la 2ème manche, tu n’as plus droit qu’à un mot clé comme indice pour faire deviner le mot.
· A la 3ème manche, plus le droit de parler, tout se fait en mimant !
L’équipe gagnante est celle qui aura fait gagné le plus de mots !

3 joueurs et +
20 min de jeu
''',
      imagePath: 'assets/images/platform/games/funny_guess.jpg',
      isAvailable: false,
    ),
    Game(
      name: 'Devine dessine',
      catchPhrase: 'Le téléphone arabe du dessin',
      description: '''
Chaque participant prend un papier et un stylo.
Chacun se voit attribuer un mot qu’il doit dessiner en 1 minute puis prendre en photo pour l’envoyer au joueur suivant.
Chaque dessin est envoyé au prochain joueur qui doit deviner ce qui a été dessiné, et doit l’écrire pour l’envoyer à son tour.
Le même scénario se répète jusqu’à effectuer un tour complet.

3 joueurs et +
20 min de jeu
''',
      imagePath: 'assets/images/platform/games/devine_dessine.jpg',
      isAvailable: false,
    ),
    Game(
      name: 'Le Bouc Émissaire',
      catchPhrase: 'Noms de code avec mot clé chiffrés',
      description: '''
Les joueurs disposent d’une grille de 16 mots aléatoires. Un maître du jeu est désigné. La moitié de ces mots est rouge, l’autre est verte. Seul le maître du jeu connaît cette répartition. Il doit faire deviner aux autres joueurs les mots verts. 
Le maître du jeu gagne si :
· La découverte de toutes les cartes vertes par un joueur se fait avant la fin du 5ème tour
· Le Bouc Emissaire (désigné aléatoirement en début de partie) n’est pas ce dernier joueur
Pour les autres joueurs :
· Le premier à avoir découvert toutes les cases vertes gagne (indépendamment de la mission du maître du jeu)
· La découverte de 3 cartes rouges sont éliminatoires

3 joueurs et +
20 min de jeu
''',
      imagePath: 'assets/images/platform/games/bouc_emissaire.jpg',
      isAvailable: false,
    ),
    Game(
      name: 'Gif and Co',
      catchPhrase: 'Ayez le commentaire de GIF le plus drôle !',
      description: '''
Il y a 5 manches, à chaque manche, un GIF est montré. Chacun doit donner un commentaire à ce GIF.
Chaque commentaire est montré à l’écran puis chaque joueur doit voter pour le commentaire le plus drôle (sauf le sien !).
La personne ayant remporté le plus de votes gagne !

3 joueurs et +
20 min de jeu
''',
      imagePath: 'assets/images/platform/games/gif_and_co.jpg',
      isAvailable: false,
    ),
  ].obs;
  final gameList = <Game>[
    Game(
      name: 'La bête du Gévaudan',
      catchPhrase: 'Le jeu du loup-garou version Kiwi games',
      // TODO change game path
      gamePath: '/loup-du-gevaudan',
      description: '''
Nous sommes en l’an 1764, un loup-garou sévit dans le Gévaudan et se cache parmi les villageois.
Vous êtes ces villageois, et certains d’entre vous ont des choses à cacher...
Chaque nuit, lorsque les villageois dorment, les bêtes se réveillent et tuent leur proie. Ce sera aux villageois de voter pour tuer l’un d’entre eux en espérant qu’il soit fautif des meurtres comis.
Les bêtes doivent décimer tous les villageois pour gagner, ce sera l’inverse pour que les villageois gagnent.

3 joueurs et +
20 min de jeu
''',
      imagePath: 'assets/images/platform/games/bete_du_gevaudan.jpg',
      isAvailable: true,
    ),
    Game(
      name: 'Funny Guess',
      catchPhrase: 'Mimes et devinettes',
      description: '''
Chaque joueur doit se mettre en groupe de 2 (le dernier peut rejoindre le moins bon groupe pour aider !)
Funny Guess se joue en 3 manches sur une base de 20 mots :
· A la 1ère manche, tu dois faire deviner un maximum de mots à ton co-équipier en 30 sec, tu ne peux pas traduire des mots dans une autre langue ou utiliser des mots de la même racine.
· A la 2ème manche, tu n’as plus droit qu’à un mot clé comme indice pour faire deviner le mot.
· A la 3ème manche, plus le droit de parler, tout se fait en mimant !
L’équipe gagnante est celle qui aura fait gagné le plus de mots !

3 joueurs et +
20 min de jeu
''',
      imagePath: 'assets/images/platform/games/funny_guess.jpg',
      isAvailable: false,
    ),
    Game(
      name: 'Devine dessine',
      catchPhrase: 'Le téléphone arabe du dessin',
      description: '''
Chaque participant prend un papier et un stylo.
Chacun se voit attribuer un mot qu’il doit dessiner en 1 minute puis prendre en photo pour l’envoyer au joueur suivant.
Chaque dessin est envoyé au prochain joueur qui doit deviner ce qui a été dessiné, et doit l’écrire pour l’envoyer à son tour.
Le même scénario se répète jusqu’à effectuer un tour complet.

3 joueurs et +
20 min de jeu
''',
      imagePath: 'assets/images/platform/games/devine_dessine.jpg',
      isAvailable: false,
    ),
    Game(
      name: 'Le Bouc Émissaire',
      catchPhrase: 'Noms de code avec mot clé chiffrés',
      description: '''
Les joueurs disposent d’une grille de 16 mots aléatoires. Un maître du jeu est désigné. La moitié de ces mots est rouge, l’autre est verte. Seul le maître du jeu connaît cette répartition. Il doit faire deviner aux autres joueurs les mots verts. 
Le maître du jeu gagne si :
· La découverte de toutes les cartes vertes par un joueur se fait avant la fin du 5ème tour
· Le Bouc Emissaire (désigné aléatoirement en début de partie) n’est pas ce dernier joueur
Pour les autres joueurs :
· Le premier à avoir découvert toutes les cases vertes gagne (indépendamment de la mission du maître du jeu)
· La découverte de 3 cartes rouges sont éliminatoires

3 joueurs et +
20 min de jeu
''',
      imagePath: 'assets/images/platform/games/bouc_emissaire.jpg',
      isAvailable: false,
    ),
    Game(
      name: 'Gif and Co',
      catchPhrase: 'Ayez le commentaire de GIF le plus drôle !',
      description: '''
Il y a 5 manches, à chaque manche, un GIF est montré. Chacun doit donner un commentaire à ce GIF.
Chaque commentaire est montré à l’écran puis chaque joueur doit voter pour le commentaire le plus drôle (sauf le sien !).
La personne ayant remporté le plus de votes gagne !

3 joueurs et +
20 min de jeu
''',
      imagePath: 'assets/images/platform/games/gif_and_co.jpg',
      isAvailable: false,
    ),
  ].obs;

  TabController? tabController;
  Timer? timer;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(vsync: this, length: carouselSlides.length);
    timer = Timer.periodic(const Duration(seconds: 10), (Timer timer) {
      int currentTab = tabController!.index;
      int nextTab = currentTab + 1;
      int newTab = nextTab >= carouselSlides.length ? 0 : nextTab;
      tabController?.animateTo(newTab);
    });
  }

  void launchGame(String gamePath) {
    LobbyController.instance.sendToLobby({
      'type': 'to all',
      'message': {
        'play game': gamePath,
      }
    });
  }
}
