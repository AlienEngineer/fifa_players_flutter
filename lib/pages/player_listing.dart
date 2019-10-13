import 'package:fifa_players/bloc/bloc.dart';
import 'package:fifa_players/models/player.dart';
import 'package:fifa_players/pages/player_profile.dart';
import 'package:fifa_players/widgets/components_factory.dart';
import 'package:fifa_players/widgets/message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlayerListing extends StatelessWidget {
  final IComponentsFactory componentsFactory;

  PlayerListing({this.componentsFactory});

  IComponentsFactory get _factory =>
      this.componentsFactory ?? ComponentsFactory();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: BlocProvider.of<PlayerListingBloc>(context),
        builder: (context, state) {
          if (state is InitialPlayerListingState) {
            return Message(
              message: 'Not Loaded yet',
            );
          } else if (state is ErrorPlayerListingState) {
            return Message(
              message: 'Error Loading Players',
            );
          } else if (state is LoadingPlayerListingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            final loadedPlayersState = state as LoadedPlayerListingState;
            final players = loadedPlayersState.players;

            return buildPlayersList(players);
          }
        });
  }

  Widget buildPlayersList(List<Players> players) {
    return Expanded(
      child: ListView.separated(
        itemBuilder: (BuildContext context, index) {
          Players player = players[index];
          return Container(
            color: Colors.white30,
            child: ListTile(
              leading: CircleAvatar(
                child: _factory.makeNetworkImage(player.headshot.imgUrl),
                radius: 30.0,
                backgroundColor: Colors.blue[50],
              ),
              title: Text(
                player.name,
                style: TextStyle(fontSize: 22.0, color: Colors.black),
              ),
              subtitle: Text(
                "Age: " + player.age.toString(),
                style: TextStyle(fontSize: 16.0, color: Colors.black87),
              ),
              trailing: IconButton(
                icon: Icon(Icons.chevron_right),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PlayerProfile(player)));
                },
              ),
            ),
          );
        },
        separatorBuilder: (BuildContext context, index) {
          return Divider(
            height: 8.0,
            color: Colors.transparent,
          );
        },
        itemCount: players.length,
      ),
    );
  }
}
