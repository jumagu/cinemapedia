import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchQueryProvider = StateProvider<String>((ref) => '');

final searchedMoviesProvider =
    StateNotifierProvider<SearchedMoviesNotifier, List<Movie>>((ref) {
      final searchMovies = ref.read(moviesRepositoryProvider).searchMovies;
      return SearchedMoviesNotifier(searchMoviesFn: searchMovies, ref: ref);
    });

typedef SearchMoviesCallback =
    Future<List<Movie>> Function({required String query});

class SearchedMoviesNotifier extends StateNotifier<List<Movie>> {
  final SearchMoviesCallback searchMoviesFn;
  final Ref ref;

  SearchedMoviesNotifier({required this.searchMoviesFn, required this.ref})
    : super([]);

  Future<List<Movie>> searchMoviesByQuery({required String query}) async {
    ref.read(searchQueryProvider.notifier).update((state) => query);

    if (query.isEmpty) {
      state = [];
      return [];
    }

    final List<Movie> movies = await searchMoviesFn(query: query);

    state = movies;

    return movies;
  }
}
