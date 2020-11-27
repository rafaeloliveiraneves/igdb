import 'package:flutter/material.dart';
import 'package:igdb/models/game.dart';

class GameDetail extends StatelessWidget {
  final Game game;

  GameDetail({Key key, @required this.game}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
              width: MediaQuery.of(context).size.width,
              child: Image.network(
                  "https://images.igdb.com/igdb/image/upload/t_screenshot_big/${game.cover.imageId}.jpg",
                  fit: BoxFit.fitWidth)),
          Container(
              margin: EdgeInsets.only(top: 20.0, left: 10.0),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(game.name,
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.w700))))
        ],
      ),
    );
  }
}
