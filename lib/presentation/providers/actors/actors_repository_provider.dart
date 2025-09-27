import 'package:cinemapedia/infrastructure/datasources/tmdb_actors_datasource.dart';
import 'package:cinemapedia/infrastructure/repositories/tmdb_actors_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final actorsRepositoryProvider = Provider((ref) {
  return TmdbActorsRepository(TmdbActorsDatasource());
});
