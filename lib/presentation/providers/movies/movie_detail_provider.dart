import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final movieDetailProvider =
    StateNotifierProvider<MovieMapNotifier, Map<String, Movie>>((ref) {
      final getMovieById = ref.watch(moviesRepositoryProvider).getMovieById;
      return MovieMapNotifier(getMovieFn: getMovieById);
    });

typedef GetMovieCallback = Future<Movie> Function({required String id});

class MovieMapNotifier extends StateNotifier<Map<String, Movie>> {
  final GetMovieCallback getMovieFn;

  MovieMapNotifier({required this.getMovieFn}) : super({});

  Future<void> loadMovie(String movieId) async {
    if (state[movieId] != null) return;

    final movie = await getMovieFn(id: movieId);

    state = {...state, movieId: movie};
  }
}
