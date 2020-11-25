import 'cover.dart';

class Game {
  final int id;
  final String name;
  final Cover cover;
  final int releaseDate;
  final double rating;

  Game({this.id, this.name, this.cover, this.releaseDate, this.rating});

  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
      id: json['id'],
      name: json['name'],
      releaseDate: json['first_release_date'],
      rating: json["rating"],
      cover: Cover.fromJson(json["cover"]),
    );
  }
}
