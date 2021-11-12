import 'dart:convert';

class Game {
  final String name;
  final String catchPhrase;
  final String description;
  final String? gamePath;
  final String imagePath;
  final bool isAvailable;
  final int minPlayers;
  final int maxPlayers;
  final int duration;

  Game({
    required this.name,
    required this.catchPhrase,
    required this.description,
    this.gamePath,
    required this.imagePath,
    required this.isAvailable,
    required this.minPlayers,
    required this.maxPlayers,
    required this.duration,
  });

  Game copyWith({
    String? name,
    String? catchPhrase,
    String? description,
    String? gamePath,
    String? imagePath,
    bool? isAvailable,
    int? minPlayers,
    int? maxPlayers,
    int? duration,
  }) {
    return Game(
      name: name ?? this.name,
      catchPhrase: catchPhrase ?? this.catchPhrase,
      description: description ?? this.description,
      gamePath: gamePath ?? this.gamePath,
      imagePath: imagePath ?? this.imagePath,
      isAvailable: isAvailable ?? this.isAvailable,
      minPlayers: minPlayers ?? this.minPlayers,
      maxPlayers: maxPlayers ?? this.maxPlayers,
      duration: duration ?? this.duration,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'catchPhrase': catchPhrase,
      'description': description,
      'gamePath': gamePath,
      'imagePath': imagePath,
      'isAvailable': isAvailable,
      'minPlayers': minPlayers,
      'maxPlayers': maxPlayers,
      'duration': duration,
    };
  }

  factory Game.fromMap(Map<String, dynamic> map) {
    return Game(
      name: map['name'],
      catchPhrase: map['catchPhrase'],
      description: map['description'],
      gamePath: map['gamePath'] != null ? map['gamePath'] : null,
      imagePath: map['imagePath'],
      isAvailable: map['isAvailable'],
      minPlayers: map['minPlayers'],
      maxPlayers: map['maxPlayers'],
      duration: map['duration'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Game.fromJson(String source) => Game.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Game(name: $name, catchPhrase: $catchPhrase, description: $description, gamePath: $gamePath, imagePath: $imagePath, isAvailable: $isAvailable, minPlayers: $minPlayers, maxPlayers: $maxPlayers, duration: $duration)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Game &&
        other.name == name &&
        other.catchPhrase == catchPhrase &&
        other.description == description &&
        other.gamePath == gamePath &&
        other.imagePath == imagePath &&
        other.isAvailable == isAvailable &&
        other.minPlayers == minPlayers &&
        other.maxPlayers == maxPlayers &&
        other.duration == duration;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        catchPhrase.hashCode ^
        description.hashCode ^
        gamePath.hashCode ^
        imagePath.hashCode ^
        isAvailable.hashCode ^
        minPlayers.hashCode ^
        maxPlayers.hashCode ^
        duration.hashCode;
  }
}
