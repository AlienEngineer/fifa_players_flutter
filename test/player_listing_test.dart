// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:fifa_players/repository/player_repository.dart';
import 'package:fifa_players/widgets/components_factory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:fifa_players/models/player.dart';
import 'package:fifa_players/pages/home.dart';

class PlayerRepositoryMock extends Mock implements PlayerRepository {}

class ComponentsFactoryMock extends Mock implements IComponentsFactory {}

class TestableApp extends StatelessWidget {
  final PlayerRepository playerRepository;
  final IComponentsFactory componentsFactory;

  TestableApp(
    this.componentsFactory,
    this.playerRepository,
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Fifa Players using Flutter and BloC',
        home: HomePage(
          playerRepository: playerRepository,
          componentsFactory: componentsFactory,
        ));
  }
}

void main() {
  var repository = PlayerRepositoryMock();
  var componentsFactory = ComponentsFactoryMock();

  when(repository.fetchPlayersByCountry("54")).thenAnswer((_) => Future.value([
        Players(
          name: "Neymar Jr",
          firstName: "Neymar",
          lastName: "Jr",
          age: 27,
          positionFull: "",
          birthdate: "",
          headshot: Headshot(imgUrl: ""),
          nation: Nation(
            imageUrls: NationImageUrls(small: ""),
          ),
          club: Club(name: "x"),
          league: League(name: ""),
        ),
      ]));

  when(componentsFactory.makeNetworkImage(any))
      .thenAnswer((_) => Text("MyImage"));

  testWidgets('selecting Brazil displays Neymar Jr',
      (WidgetTester tester) async {
    // Arrange
    await tester.pumpWidget(TestableApp(
      componentsFactory,
      repository,
    ));

    // Act
    await tester.tap(find.byKey(Key("Country1")));
    await tester.pump();

    // Assert
    expect(find.text("Neymar Jr"), findsOneWidget);
  });

  testWidgets('selecting Neymar Jr displays his details',
      (WidgetTester tester) async {
    // Arrange
    await tester.pumpWidget(TestableApp(
      componentsFactory,
      repository,
    ));
    await tester.tap(find.byKey(Key("Country1")));
    await tester.pump();

    // Act
    await tester.tap(find.byKey(Key("bt_details")));
    await tester.pump();

    // Assert
    expect(find.text("Neymar Jr"), findsOneWidget);
  });
}
