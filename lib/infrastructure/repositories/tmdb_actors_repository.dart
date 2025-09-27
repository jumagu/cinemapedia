import 'package:cinemapedia/domain/datasources/actors_datasource.dart';
import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/domain/repositories/actors_repository.dart';

class TmdbActorsRepository extends ActorsRepository {
  final ActorsDatasource actorsDatasource;

  TmdbActorsRepository(this.actorsDatasource);

  @override
  Future<List<Actor>> getActorsByMovieId({required String movieId}) {
    return actorsDatasource.getActorsByMovieId(movieId: movieId);
  }
}
