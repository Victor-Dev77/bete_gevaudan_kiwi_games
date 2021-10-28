class Game {
  final String name;
  final String catchPhrase;
  final String description;
  final String? gamePath;
  final String imagePath;
  final bool isAvailable;

  Game({
    required this.name,
    required this.catchPhrase,
    required this.description,
    this.gamePath,
    required this.imagePath,
    required this.isAvailable,
  });
}
