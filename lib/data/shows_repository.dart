import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:dio_logging_interceptor/dio_logging_interceptor.dart';
import 'package:hive/hive.dart';
import 'package:meuvies/api/api_service.dart';
import 'package:meuvies/data/model/person.dart';
import 'package:meuvies/data/model/show.dart';
import 'package:meuvies/util/errors.dart';

abstract class ShowsRepository {
  static const String LOCAL_STORAGE_BOX = 'local_storage';

  Future<List<Show>> getShows(int page);

  Future<List<Show>> searchShows(String query);

  Future<Show> getShowDetails(int id);

  Future<void> saveShow(Show show);

  Future<void> deleteShow(int id);

  Future<bool> isFavouriteShow(int id);

  Future<List<Show>> getFavouriteShows();

  Future<List<Person>> searchPeople(String query);

  Future<List<Show>> getPersonShows(int id);
}

class ShowsRepositoryImpl extends ShowsRepository {
  final _storage = Hive.box(ShowsRepository.LOCAL_STORAGE_BOX);
  late ApiClient _client;

  ShowsRepositoryImpl() {
    _client = ApiClient(Dio()
      ..interceptors.add(
        DioLoggingInterceptor(
          level: Level.body,
          compact: false,
        ),
      ));
  }

  @override
  Future<List<Show>> getShows(int page) async {
    return await _client.getShows(page).then((response) {
      return Future.value(response);
    }).catchError((error) {
      var errorMessage = getErrorMessage(error);
      throw AppError(errorMessage);
    });
  }

  @override
  Future<List<Show>> searchShows(String query) async {
    return await _client.searchShows(query).then((response) {
      return Future.value(response.map((element) => element.show).toList());
    }).catchError((error) {
      var errorMessage = getErrorMessage(error);
      throw AppError(errorMessage);
    });
  }

  @override
  Future<Show> getShowDetails(int id) async {
    return await _client.getShowDetails(id).then((response) {
      return Future.value(response);
    }).catchError((error) {
      var errorMessage = getErrorMessage(error);
      throw AppError(errorMessage);
    });
  }

  @override
  Future<void> saveShow(Show show) async {
    await _storage.put(show.id, show.toJson());
  }

  @override
  Future<void> deleteShow(int id) async {
    await _storage.delete(id);
  }

  @override
  Future<bool> isFavouriteShow(int id) async {
    final result = (await _storage.get(id, defaultValue: null)) != null;
    return Future.value(result);
  }

  @override
  Future<List<Show>> getFavouriteShows() async {
    final data = _storage.values;
    return data
        .map((element) => Show.fromJson(Map<String, dynamic>.from(element)))
        .toList()
        .sortedBy((show) => show.name);
  }

  @override
  Future<List<Person>> searchPeople(String query) async {
    return await _client.searchPeople(query).then((response) {
      return Future.value(response.map((element) => element.person).toList());
    }).catchError((error) {
      var errorMessage = getErrorMessage(error);
      throw AppError(errorMessage);
    });
  }

  @override
  Future<List<Show>> getPersonShows(int id) async {
    return await _client.getPersonShows(id).then((response) {
      return Future.value(response.map((element) => element.show).toList());
    }).catchError((error) {
      var errorMessage = getErrorMessage(error);
      throw AppError(errorMessage);
    });
  }
}
