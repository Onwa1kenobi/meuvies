import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:meuvies/data/model/person.dart';
import 'package:meuvies/data/model/show.dart';
import 'package:meuvies/data/shows_repository.dart';
import 'package:meuvies/util/errors.dart';
import 'package:meuvies/util/network/connectivity.dart';

part 'shows_event.dart';

part 'shows_state.dart';

class ShowsBloc extends Bloc<ShowsEvent, ShowsState> {
  final NetworkConnectivity _connectivity = NetworkConnectivity(Connectivity());
  final ShowsRepository _showsRepository;

  List<Show> get favouriteShows => _favouriteShows;
  List<Show> _favouriteShows = [];

  List<Show> get showsSearchList => _showsSearchList;
  List<Show> _showsSearchList = [];

  List<Person> get peopleSearchList => _peopleSearchList;
  List<Person> _peopleSearchList = [];

  ShowsBloc(this._showsRepository) : super(ShowsInitial()) {
    on<SearchShows>((event, emit) async {
      try {
        emit(ShowsLoading());
        _showsSearchList = await _connectivity
            .safeNetworkCall(() => _showsRepository.searchShows(event.query));
        emit(ShowsLoaded(_showsSearchList));
      } on AppError catch (e) {
        emit(ShowError(e.message));
      }
    });

    on<GetShowDetails>((event, emit) async {
      try {
        emit(ShowsLoading());
        final show = await _connectivity
            .safeNetworkCall(() => _showsRepository.getShowDetails(event.id));
        emit(ShowDetailsLoaded(show));
      } on AppError catch (e) {
        emit(ShowError(e.message));
      }
    });

    on<GetFavouriteShows>((event, emit) async {
      try {
        _favouriteShows = await _showsRepository.getFavouriteShows();
        emit(ShowsLoaded(_favouriteShows));
      } on AppError catch (e) {
        emit(ShowError(e.message));
      }
    });

    on<AddShowToFavourites>((event, emit) async {
      try {
        await _showsRepository.saveShow(event.show);
        emit(const ShowFavouriteStatusLoaded(true));
        add(const GetFavouriteShows());
      } on AppError catch (e) {
        emit(ShowError(e.message));
      }
    });

    on<RemoveShowFromFavourites>((event, emit) async {
      try {
        await _showsRepository.deleteShow(event.id);
        emit(const ShowFavouriteStatusLoaded(false));
        add(const GetFavouriteShows());
      } on AppError catch (e) {
        emit(ShowError(e.message));
      }
    });

    on<GetShowFavouriteStatus>((event, emit) async {
      try {
        final result = await _showsRepository.isFavouriteShow(event.id);
        emit(ShowFavouriteStatusLoaded(result));
      } on AppError catch (e) {
        emit(ShowError(e.message));
      }
    });

    on<SearchPeople>((event, emit) async {
      try {
        emit(ShowsLoading());
        _peopleSearchList = await _connectivity
            .safeNetworkCall(() => _showsRepository.searchPeople(event.query));
        emit(PeopleLoaded(_peopleSearchList));
      } on AppError catch (e) {
        emit(ShowError(e.message));
      }
    });

    on<GetPersonShows>((event, emit) async {
      try {
        emit(ShowsLoading());
        final shows = await _connectivity
            .safeNetworkCall(() => _showsRepository.getPersonShows(event.id));
        emit(PersonShowsLoaded(shows));
      } on AppError catch (e) {
        emit(ShowError(e.message));
      }
    });
  }
}
