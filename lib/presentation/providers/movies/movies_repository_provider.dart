import 'package:cinemapedia/infrastructure/datasources/tmdb_datasource.dart';
import 'package:cinemapedia/infrastructure/repositories/movies_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Readonly repository
final moviesRepositoryProvider = Provider((ref) {
  return MoviesRepositoryImpl(TmdbDatasource());
});
