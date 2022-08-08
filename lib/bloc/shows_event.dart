part of 'shows_bloc.dart';

abstract class ShowsEvent extends Equatable {
  const ShowsEvent();
}

class GetShowDetails extends ShowsEvent {
  final int id;

  const GetShowDetails(this.id);

  @override
  List<Object?> get props => [id];
}

class SearchShows extends ShowsEvent {
  final String query;

  const SearchShows(this.query);

  @override
  List<Object?> get props => [query];
}

class GetFavouriteShows extends ShowsEvent {
  const GetFavouriteShows();

  @override
  List<Object?> get props => [];
}

class AddShowToFavourites extends ShowsEvent {
  final Show show;

  const AddShowToFavourites(this.show);

  @override
  List<Object?> get props => [show];
}

class RemoveShowFromFavourites extends ShowsEvent {
  final int id;

  const RemoveShowFromFavourites(this.id);

  @override
  List<Object?> get props => [id];
}

class GetShowFavouriteStatus extends ShowsEvent {
  final int id;

  const GetShowFavouriteStatus(this.id);

  @override
  List<Object?> get props => [id];
}

class GetPersonShows extends ShowsEvent {
  final int id;

  const GetPersonShows(this.id);

  @override
  List<Object?> get props => [id];
}

class SearchPeople extends ShowsEvent {
  final String query;

  const SearchPeople(this.query);

  @override
  List<Object?> get props => [query];
}
