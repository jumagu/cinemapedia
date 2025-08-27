import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final nowPlayingMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
      final getNowPlaying = ref.watch(moviesRepositoryProvider).getNowPlaying;
      return MoviesNotifier(fetchMoviesFn: getNowPlaying);
    });

typedef MovieCallback = Future<List<Movie>> Function({int page});

class MoviesNotifier extends StateNotifier<List<Movie>> {
  int currentPage = 0;
  MovieCallback fetchMoviesFn;

  MoviesNotifier({required this.fetchMoviesFn}) : super([]);

  Future<void> loadNextPage() async {
    currentPage++;
    final List<Movie> movies = await fetchMoviesFn(page: currentPage);
    state = [...state, ...movies];
  }
}
