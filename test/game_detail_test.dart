import 'package:flutter_test/flutter_test.dart';

import 'package:igdb/screens/game_detail.dart';
import 'package:igdb/models/cover.dart';
import 'package:igdb/models/game.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'test_helper.dart';

void main() {
  testWidgets('renders game information', (WidgetTester tester) async {
    var game = Game(id: 1, name: "Demon's Souls", cover: Cover(imageId: "123"));
    await mockNetworkImagesFor(
        () => tester.pumpWidget(buildTestableWidget(GameDetail(game: game))));
    await mockNetworkImagesFor(() => tester.pumpAndSettle());

    expect(find.text("Demon's Souls"), findsOneWidget);
  });
}
