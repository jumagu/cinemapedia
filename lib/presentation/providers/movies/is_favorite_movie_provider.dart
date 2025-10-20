import 'package:cinemapedia/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ? family indicates that the provider receives an argument.
// ? autoDispose: Marks the provider as automatically disposed when no longer listened to.
// final isFavoriteMovieProvider = FutureProvider.family.autoDispose<bool, int>((
final isFavoriteMovieProvider = FutureProvider.family<bool, int>((
  ref,
  movieId,
) {
  final localMoviesRepository = ref.watch(localMoviesRepositoryProvider);
  return localMoviesRepository.isFavoriteMovie(movieId);
});
