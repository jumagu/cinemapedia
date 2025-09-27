import 'package:cinemapedia/infrastructure/datasources/tmdb_movies_datasource.dart';
import 'package:cinemapedia/infrastructure/repositories/tmdb_movies_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Readonly repository
final moviesRepositoryProvider = Provider((ref) {
  return TmdbMoviesRepository(TmdbMoviesDatasource());
});
