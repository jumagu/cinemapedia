import 'package:cinemapedia/presentation/providers/movies/favorite_movies_provider.dart';
import 'package:cinemapedia/presentation/widgets/movies/movies_masonry_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritesView extends ConsumerStatefulWidget {
  const FavoritesView({super.key});

  @override
  ConsumerState<FavoritesView> createState() => _FavoritesViewState();
}

class _FavoritesViewState extends ConsumerState<FavoritesView> {
  @override
  void initState() {
    super.initState();
    ref.read(favoriteMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final favoriteMovies = ref.watch(favoriteMoviesProvider).values.toList();

    final colorPrimary = Theme.of(context).colorScheme.primary;

    if (favoriteMovies.isEmpty) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.favorite_outline, size: 100, color: colorPrimary),
              const Text(
                'You do not have any favorite movies.',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      body: MoviesMasonryGrid(
        movies: favoriteMovies,
        loadNextPage: ref.read(favoriteMoviesProvider.notifier).loadNextPage,
      ),
    );
  }
}
