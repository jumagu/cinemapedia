import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infrastructure/mappers/movie_mapper.dart';
import 'package:cinemapedia/infrastructure/models/tmdb/tmdb_movie_detail.dart';
import 'package:cinemapedia/infrastructure/models/tmdb/tmdb_movies_response.dart';
import 'package:dio/dio.dart';

class TmdbMoviesDatasource extends MoviesDatasource {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {'api_key': Environment.tmdbApiKey},
    ),
  );

  List<Movie> _jsonToMovies(Map<String, dynamic> json) {
    final tmdbResponse = TmdbMoviesResponse.fromJson(json);

    final List<Movie> movies = tmdbResponse.results
        .where((tmdbMovie) => tmdbMovie.posterPath != 'no-poster')
        .map((tmdbMovie) => MovieMapper.tmdbMovieToEntity(tmdbMovie))
        .toList();

    return movies;
  }

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response = await _dio.get(
      '/movie/now_playing',
      queryParameters: {'page': page},
    );

    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) async {
    final response = await _dio.get(
      '/movie/popular',
      queryParameters: {'page': page},
    );

    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getTopRated({int page = 1}) async {
    final response = await _dio.get(
      '/movie/top_rated',
      queryParameters: {'page': page},
    );

    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getUpcoming({int page = 1}) async {
    final response = await _dio.get(
      '/movie/upcoming',
      queryParameters: {'page': page},
    );

    return _jsonToMovies(response.data);
  }

  @override
  Future<Movie> getMovieById({required String id}) async {
    final response = await _dio.get('/movie/$id');

    if (response.statusCode != 200) {
      throw Exception('Movie with id: $id not found.');
    }

    final tmdbMovieDetail = TmdbMovieDetail.fromJson(response.data);

    final Movie movie = MovieMapper.tmdbMovieDetailToEntity(tmdbMovieDetail);

    return movie;
  }

  @override
  Future<List<Movie>> searchMovies({required String query}) async {
    final response = await _dio.get(
      '/search/movie',
      queryParameters: {'query': query},
    );

    return _jsonToMovies(response.data);
  }
}
