// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:fifa_players/models/player.dart';
import 'package:fifa_players/repository/player_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fifa_players/main.dart';
import 'package:mockito/mockito.dart';

class PlayerRepositoryMock extends Mock implements PlayerRepository {}

void main() {
  var repository = PlayerRepositoryMock();

  when(repository.fetchPlayersByCountry("54")).thenAnswer((_) => Future.value([
        Players(name: "Neymar Jr", headshot: Headshot(imgUrl: "")),
      ]));

  testWidgets('selecting Brazil displays Neymar Jr',
      (WidgetTester tester) async {
    await tester.pumpWidget(MyApp(playerRepository: repository));

    await tester.tap(find.byKey(Key("Country1")));
    await tester.pump();

    expect(find.text("Neymar Jr"), findsOneWidget);
  });
}
