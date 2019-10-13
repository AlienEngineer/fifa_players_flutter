import 'package:meta/meta.dart';

import '../models/player.dart';

@immutable
abstract class PlayerListingState {}

class InitialPlayerListingState extends PlayerListingState {}

class LoadedPlayerListingState extends PlayerListingState {
  final List<Players> players;
  LoadedPlayerListingState({this.players}) : assert(players != null);
}

class LoadingPlayerListingState extends PlayerListingState {}

class ErrorPlayerListingState extends PlayerListingState {}

class EmptyPlayerListingState extends PlayerListingState {}
