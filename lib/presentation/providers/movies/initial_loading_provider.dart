import 'package:cinemapedia/presentation/providers/movies/movies_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final initialLoadingProvider = Provider<bool>((ref) {
  final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider).isNotEmpty;
  final upcomingMovies = ref.watch(upcomingMoviesProvider).isNotEmpty;
  final popularMovies = ref.watch(popularMoviesProvider).isNotEmpty;
  final topRatedMovies = ref.watch(topRatedMoviesProvider).isNotEmpty;

  if (nowPlayingMovies && upcomingMovies && popularMovies && topRatedMovies) {
    return false;
  }

  return true;
});
