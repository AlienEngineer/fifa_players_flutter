import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:fifa_players/repository/player_repository.dart';
import '../models/player.dart';
import './bloc.dart';

class PlayerListingBloc extends Bloc<PlayerListingEvent, PlayerListingState> {
  PlayerRepository playerRepository;

  PlayerListingBloc({this.playerRepository}) : assert(playerRepository != null);
  @override
  PlayerListingState get initialState => InitialPlayerListingState();

  @override
  Stream<PlayerListingState> mapEventToState(
    PlayerListingEvent event,
  ) async* {
    yield LoadingPlayerListingState();
    List<Players> players;

    try {
      if (event is ChangedCountryEvent) {
        players = await playerRepository
            .fetchPlayersByCountry(event.nationModel.countryId);
      } else if (event is SearchPlayerEvent) {
        players = await playerRepository.fetchPlayersByName(event.searchTerm);
      }

      if (players.length > 0) {
        yield LoadedPlayerListingState(players: players);
      } else {
        yield EmptyPlayerListingState();
      }
    } catch (_) {
      yield ErrorPlayerListingState();
    }
  }
}
