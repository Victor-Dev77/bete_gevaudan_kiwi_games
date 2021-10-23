class User {
  final String pseudo;
  final String? imagePath;
  final bool isActive;

  User({
    required this.pseudo,
    this.imagePath,
    required this.isActive,
  });
}
