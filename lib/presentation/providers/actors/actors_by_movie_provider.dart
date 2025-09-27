import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/presentation/providers/actors/actors_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final actorsByMovieProvider =
    StateNotifierProvider<ActorsByMovieMapNotifier, Map<String, List<Actor>>>((
      ref,
    ) {
      final getActorsByMovieId = ref
          .watch(actorsRepositoryProvider)
          .getActorsByMovieId;
      return ActorsByMovieMapNotifier(getMovieActorsFn: getActorsByMovieId);
    });

typedef GetMovieActorsCallback =
    Future<List<Actor>> Function({required String movieId});

class ActorsByMovieMapNotifier extends StateNotifier<Map<String, List<Actor>>> {
  final GetMovieActorsCallback getMovieActorsFn;

  ActorsByMovieMapNotifier({required this.getMovieActorsFn}) : super({});

  Future<void> loadMovieActors(String movieId) async {
    if (state[movieId] != null) return;

    final movieActors = await getMovieActorsFn(movieId: movieId);

    state = {...state, movieId: movieActors};
  }
}
