import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/config/helpers/format_number.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';

typedef SearchMoviesCallback =
    Future<List<Movie>> Function({required String query});

class SearchMovieDelegate extends SearchDelegate<Movie?> {
  final SearchMoviesCallback searchMoviesFn;
  List<Movie> initialMovies;
  StreamController<bool> isLoading = StreamController.broadcast();
  StreamController<List<Movie>> debouncedMovies = StreamController.broadcast();
  Timer? _debounceTimer;

  SearchMovieDelegate({
    required this.searchMoviesFn,
    required this.initialMovies,
  });

  void _onQueryChanged(String query) {
    isLoading.add(true);

    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();

    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      final movies = await searchMoviesFn(query: query);
      initialMovies = movies;
      debouncedMovies.add(movies);
      isLoading.add(false);
    });
  }

  void _clearStreams() {
    debouncedMovies.close();
  }

  @override
  String? get searchFieldLabel => 'Search movie...';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      StreamBuilder(
        stream: isLoading.stream,
        builder: (context, snapshot) {
          final isLoading = snapshot.data ?? false;

          if (isLoading) {
            return Padding(
              padding: EdgeInsets.only(right: 17),
              child: SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  semanticsLabel: 'Loading...',
                ),
              ),
            );
          }

          return FadeIn(
            duration: Duration(milliseconds: 150),
            animate: query.isNotEmpty && !isLoading,
            child: IconButton(
              onPressed: () => query = '',
              icon: Icon(Icons.clear),
            ),
          );
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        _clearStreams();
        close(context, null);
      },
      icon: Icon(Icons.arrow_back_rounded),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildResultsAndSuggestions();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _onQueryChanged(query.trim());

    return buildResultsAndSuggestions();
  }

  Widget buildResultsAndSuggestions() {
    return StreamBuilder(
      initialData: initialMovies,
      stream: debouncedMovies.stream,
      builder: (context, snapshot) {
        final suggestedMovies = snapshot.data ?? [];

        return ListView.builder(
          itemCount: suggestedMovies.length,
          itemBuilder: (context, index) {
            final suggestedMovie = suggestedMovies[index];

            return _MovieSearchItem(
              movie: suggestedMovie,
              onMovieTap: (context, movie) {
                _clearStreams();
                close(context, movie);
              },
            );
          },
        );
      },
    );
  }
}

class _MovieSearchItem extends StatelessWidget {
  final Movie movie;
  final void Function(BuildContext context, Movie movie) onMovieTap;

  const _MovieSearchItem({required this.movie, required this.onMovieTap});

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => onMovieTap(context, movie),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.05,
          vertical: 5,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: size.width * 0.025,
          children: [
            // ? Movie Image
            SizedBox(
              width: size.width * 0.25,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(movie.posterPath),
              ),
            ),

            // ? Movie Description
            SizedBox(
              width: size.width * 0.6,
              child: Column(
                spacing: 1.5,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    maxLines: 2,
                    style: textStyles.titleMedium?.copyWith(
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (movie.overview.isNotEmpty)
                    Text(
                      movie.overview,
                      maxLines: 2,
                      style: TextStyle(overflow: TextOverflow.ellipsis),
                    ),
                  Row(
                    spacing: 2,
                    children: [
                      Icon(
                        Icons.star_half_rounded,
                        color: Colors.yellow.shade800,
                      ),
                      Text(
                        FormatNumber.short(movie.voteAverage, 1),
                        style: textStyles.bodyMedium?.copyWith(
                          color: Colors.yellow.shade900,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
