import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:igdb/models/game.dart';

class GameRepository {
  Future<List<Game>> fetchGames() async {
    final response = await http.post('https://api.igdb.com/v4/games',
        body:
            "fields name,cover.*, first_release_date, rating; where cover != null & first_release_date != n & rating != n; limit 50; sort rating desc;",
        headers: {
          "Client-ID": "",
          "Authorization": "Bearer accessToken",
        });

    if (response.statusCode == 200) {
      List games = json.decode(response.body);
      return games.map((game) => new Game.fromJson(game)).toList();
    } else {
      throw Exception('Failed to load album');
    }
  }
}
