import 'package:fifa_players/bloc/bloc.dart';
import 'package:fifa_players/pages/player_listing.dart';
import 'package:fifa_players/repository/player_repository.dart';
import 'package:fifa_players/widgets/components_factory.dart';
import 'package:fifa_players/widgets/horizontalBar.dart';
import 'package:fifa_players/widgets/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  final PlayerRepository playerRepository;
  final IComponentsFactory componentsFactory;

  HomePage({this.playerRepository, this.componentsFactory});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PlayerListingBloc _playerListingBloc;

  @override
  void initState() {
    super.initState();
    _playerListingBloc =
        PlayerListingBloc(playerRepository: widget.playerRepository);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      builder: (BuildContext context) => _playerListingBloc,
      child: Scaffold(
        backgroundColor: Colors.blue[900],
        appBar: AppBar(
          elevation: 0.0,
          title: Text(
            'Football Players',
            style: TextStyle(
              color: Colors.white,
              fontSize: 30.0,
            ),
          ),
          backgroundColor: Colors.transparent,
        ),
        body: Column(
          children: <Widget>[
            HorizontalBar(),
            SizedBox(
              height: 20.0,
            ),
            SearchBar(),
            SizedBox(
              height: 20.0,
            ),
            PlayerListing(
              componentsFactory: widget.componentsFactory,
            ),
          ],
        ),
      ),
    );
  }
}
