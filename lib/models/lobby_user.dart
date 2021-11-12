class LobbyUser {
  final String username;
  final bool isActive;
  final String? imagePath;
  final String? screen;
  final bool isHost;

  LobbyUser({
    required this.username,
    this.isActive = true,
    this.imagePath,
    this.screen = 'user',
    this.isHost = false,
  });

  Map<String, dynamic> toJson() => {
        'username': username,
        'isActive': isActive,
        'imagePath': imagePath,
        'screen': screen,
        'isHost': isHost,
      };

  LobbyUser.fromJson(Map<String, dynamic> json)
      : username = json['username'],
        isActive = json['isActive'] ?? true,
        imagePath = json['imagePath'],
        screen = json['screen'] ?? 'user',
        isHost = json['isHost'] ?? false;
}
