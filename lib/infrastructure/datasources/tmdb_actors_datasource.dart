import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/domain/datasources/actors_datasource.dart';
import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/infrastructure/mappers/actor_mapper.dart';
import 'package:cinemapedia/infrastructure/models/tmdb/tmdb_movie_credits_response.dart';
import 'package:dio/dio.dart';

class TmdbActorsDatasource extends ActorsDatasource {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {'api_key': Environment.tmdbApiKey},
    ),
  );

  @override
  Future<List<Actor>> getActorsByMovieId({required String movieId}) async {
    final response = await _dio.get('/movie/$movieId/credits');

    final tmdbMovieCredits = TmdbMovieCreditsResponse.fromJson(response.data);

    final List<Actor> actors = tmdbMovieCredits.cast
        .map((castItem) => ActorMapper.tmdbCastItemToEntity(castItem))
        .toList();

    return actors;
  }
}
