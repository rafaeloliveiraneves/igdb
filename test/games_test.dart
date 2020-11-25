import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:igdb/screens/games.dart';
import 'package:igdb/models/cover.dart';
import 'package:igdb/models/game.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:igdb/repositories/game_repository.dart';
import 'test_helper.dart';

List<Game> _buildGameList() {
  return [
    Game(
        id: 1,
        name: "Demon's Souls",
        releaseDate: 1606338010228,
        rating: 98.0,
        cover: Cover(imageId: "654321")),
    Game(
        id: 1,
        name: "Miles Morales",
        releaseDate: 1506448010228,
        rating: 80.0,
        cover: Cover(imageId: "123456"))
  ];
}

class MockGameRepository extends Mock implements GameRepository {}

void main() {
  GameRepository gameRepository;

  setUp(() {
    gameRepository = MockGameRepository();
  });

  testWidgets('renders game titles', (WidgetTester tester) async {
    var gameList = _buildGameList();
    when(gameRepository.fetchGames())
        .thenAnswer((_) async => Future.value(gameList));

    await mockNetworkImagesFor(() => tester.pumpWidget(
        buildTestableWidget(Games(gameRepository: gameRepository))));
    await mockNetworkImagesFor(() => tester.pumpAndSettle());

    verify(gameRepository.fetchGames()).called(1);
    expect(find.text("Demon's Souls"), findsOneWidget);
    expect(find.text("Miles Morales"), findsOneWidget);
  });

  testWidgets('renders CircularProgressIndicator widget',
      (WidgetTester tester) async {
    when(gameRepository.fetchGames())
        .thenAnswer((_) async => Future.delayed(Duration(milliseconds: 1)));

    await mockNetworkImagesFor(() => tester.pumpWidget(
        buildTestableWidget(Games(gameRepository: gameRepository))));
    await mockNetworkImagesFor(() => tester.pump(Duration(milliseconds: 1)));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('renders error', (WidgetTester tester) async {
    when(gameRepository.fetchGames())
        .thenAnswer((_) async => Future.error("Error"));

    await mockNetworkImagesFor(() => tester.pumpWidget(
        buildTestableWidget(Games(gameRepository: gameRepository))));
    await mockNetworkImagesFor(() => tester.pump());

    expect(find.text("Error"), findsOneWidget);
  });
}
