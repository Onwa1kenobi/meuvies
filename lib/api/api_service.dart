import 'package:dio/dio.dart';
import 'package:meuvies/api/api_constants.dart';
import 'package:meuvies/data/model/cast_credit_show_dto.dart';
import 'package:meuvies/data/model/person_search_dto.dart';
import 'package:meuvies/data/model/show.dart';
import 'package:meuvies/data/model/show_search_dto.dart';
import 'package:retrofit/retrofit.dart';

part 'api_service.g.dart';

// flutter pub run build_runner watch

@RestApi(baseUrl: APIs.baseUrl)
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @GET('${APIs.shows}?page={page}')
  Future<List<Show>> getShows(@Path('page') int page);

  @GET('${APIs.search}${APIs.shows}')
  Future<List<ShowSearchDTO>> searchShows(@Query('q') String query);

  @GET('${APIs.shows}/{id}?embed=episodes')
  Future<Show> getShowDetails(@Path('id') int id);

  @GET('${APIs.search}${APIs.people}')
  Future<List<PersonSearchDTO>> searchPeople(@Query('q') String query);

  @GET('${APIs.people}/{id}/castcredits?embed=show')
  Future<List<CastCreditShowDTO>> getPersonShows(@Path('id') int id);
}
