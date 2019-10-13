import 'package:fifa_players/models/nation.dart';
import 'package:meta/meta.dart';

@immutable
abstract class PlayerListingEvent {}

class ChangedCountryEvent extends PlayerListingEvent {
  final NationModel nationModel;
  ChangedCountryEvent({this.nationModel}) : assert(nationModel != null);
}

class SearchPlayerEvent extends PlayerListingEvent {
  final String searchTerm;
  SearchPlayerEvent({this.searchTerm}) : assert(searchTerm != null);
}
