import 'package:fifa_players/pages/home.dart';
import 'package:fifa_players/repository/player_repository.dart';
import 'package:fifa_players/widgets/components_factory.dart';
import 'package:flutter/material.dart';

void main() {
  PlayerRepository _playerRepository = new PlayerRepository();
  runApp(MyApp(playerRepository: _playerRepository));
}

class MyApp extends StatelessWidget {
  final PlayerRepository playerRepository;
  // This widget is the root of your application.
  MyApp({this.playerRepository});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fifa Players using Flutter and BloC',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(
        playerRepository: playerRepository,
        componentsFactory: ComponentsFactory(),
      ),
    );
  }
}
