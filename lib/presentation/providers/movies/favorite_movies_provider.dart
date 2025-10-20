import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/domain/repositories/local_movies_repository.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final favoriteMoviesProvider =
    StateNotifierProvider<FavoriteMoviesNotifier, Map<int, Movie>>((ref) {
      final localMoviesRepository = ref.watch(localMoviesRepositoryProvider);

      return FavoriteMoviesNotifier(
        localMoviesRepository: localMoviesRepository,
      );
    });

class FavoriteMoviesNotifier extends StateNotifier<Map<int, Movie>> {
  int page = 0;
  final LocalMoviesRepository localMoviesRepository;

  FavoriteMoviesNotifier({required this.localMoviesRepository}) : super({});

  Future<void> toggleFavoriteMovie(Movie movie) async {
    final isFavorite = await localMoviesRepository.isFavoriteMovie(movie.id);

    await localMoviesRepository.toggleFavoriteMovie(movie);

    if (isFavorite) {
      state.remove(movie.id);
      state = {...state};
      return;
    }

    state = {...state, movie.id: movie};
  }

  Future<List<Movie>> loadNextPage() async {
    final movies = await localMoviesRepository.loadFavoriteMovies(
      limit: 10,
      offset: page * 10,
    );

    page++;

    final tempMovies = <int, Movie>{};
    for (final movie in movies) {
      tempMovies[movie.id] = movie;
    }

    state = {...state, ...tempMovies};

    return movies;
  }
}
