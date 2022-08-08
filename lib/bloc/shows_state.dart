part of 'shows_bloc.dart';

abstract class ShowsState extends Equatable {
  const ShowsState();
}

class ShowsInitial extends ShowsState {
  @override
  List<Object> get props => [];
}

class ShowsLoading extends ShowsState {
  @override
  List<Object> get props => [];
}

class ShowsLoaded extends ShowsState {
  final List<Show> shows;

  const ShowsLoaded(this.shows);

  @override
  List<Object> get props => [shows];
}

class ShowDetailsLoaded extends ShowsState {
  final Show show;

  const ShowDetailsLoaded(this.show);

  @override
  List<Object> get props => [show];
}

class ShowError extends ShowsState {
  final String message;

  const ShowError(this.message);

  @override
  List<Object> get props => [message];
}

class ShowFavouriteStatusLoaded extends ShowsState {
  final bool isFavourite;

  const ShowFavouriteStatusLoaded(this.isFavourite);

  @override
  List<Object> get props => [isFavourite];
}

class PeopleLoaded extends ShowsState {
  final List<Person> people;

  const PeopleLoaded(this.people);

  @override
  List<Object> get props => [people];
}

class PersonShowsLoaded extends ShowsState {
  final List<Show> shows;

  const PersonShowsLoaded(this.shows);

  @override
  List<Object> get props => [shows];
}
