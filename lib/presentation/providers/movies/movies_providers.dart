import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final nowPlayingMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
      final getNowPlaying = ref.watch(moviesRepositoryProvider).getNowPlaying;
      return MoviesNotifier(fetchMoviesFn: getNowPlaying);
    });

final popularMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
      final getPopular = ref.watch(moviesRepositoryProvider).getPopular;
      return MoviesNotifier(fetchMoviesFn: getPopular);
    });

final upcomingMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
      final getUpcoming = ref.watch(moviesRepositoryProvider).getUpcoming;
      return MoviesNotifier(fetchMoviesFn: getUpcoming);
    });

final topRatedMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
      final getTopRated = ref.watch(moviesRepositoryProvider).getTopRated;
      return MoviesNotifier(fetchMoviesFn: getTopRated);
    });

typedef MovieCallback = Future<List<Movie>> Function({int page});

class MoviesNotifier extends StateNotifier<List<Movie>> {
  int currentPage = 0;
  bool isLoading = false;
  MovieCallback fetchMoviesFn;

  MoviesNotifier({required this.fetchMoviesFn}) : super([]);

  Future<void> loadNextPage() async {
    if (isLoading) return;

    isLoading = true;
    currentPage++;

    final List<Movie> movies = await fetchMoviesFn(page: currentPage);

    state = [...state, ...movies];

    await Future.delayed(const Duration(milliseconds: 300));

    isLoading = false;
  }
}
