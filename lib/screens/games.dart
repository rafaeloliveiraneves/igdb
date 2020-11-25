import 'package:flutter/material.dart';

import 'package:igdb/models/game.dart';
import 'package:igdb/repositories/game_repository.dart';

class Games extends StatefulWidget {
  final GameRepository gameRepository;

  Games({Key key, @required this.gameRepository}) : super(key: key);

  _GamesState createState() => _GamesState();
}

class _GamesState extends State<Games> {
  Future<List<Game>> _futureGames;

  @override
  void initState() {
    _futureGames = widget.gameRepository.fetchGames();
    super.initState();
  }

  FutureBuilder<List<Game>> _buildGameList() {
    return FutureBuilder<List<Game>>(
      future: _futureGames,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }

        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        return ListView.separated(
            separatorBuilder: (BuildContext context, int index) => Divider(),
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              return ListTile(
                  leading: SizedBox(
                      height: 100.0,
                      width: 100.0,
                      child: Image.network(
                          "https://images.igdb.com/igdb/image/upload/t_cover_big/${snapshot.data[index].cover.imageId}.jpg",
                          fit: BoxFit.fill)),
                  title: Text(
                    snapshot.data[index].name,
                  ));
            });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Games")),
        body: Center(child: _buildGameList()));
  }
}
