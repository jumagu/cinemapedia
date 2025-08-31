import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/config/helpers/format_number.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';

class MoviesHorizListview extends StatelessWidget {
  final List<Movie> movies;
  final String? title;
  final String? label;
  final VoidCallback? loadNextMovies;

  const MoviesHorizListview({
    super.key,
    required this.movies,
    this.title,
    this.label,
    this.loadNextMovies,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Column(
        children: [
          if (title != null || label != null)
            _Header(title: title, label: label),
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: movies.length,
              itemBuilder: (context, index) {
                final movie = movies[index];
                return _Slide(movie: movie);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final String? title;
  final String? label;

  const _Header({this.title, this.label});

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleLarge;

    return Container(
      padding: const EdgeInsets.only(top: 10),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          if (title != null) Text(title!, style: titleStyle),
          const Spacer(),
          if (label != null)
            FilledButton.tonal(
              onPressed: () {},
              style: const ButtonStyle(visualDensity: VisualDensity.compact),
              child: Text(label!),
            ),
        ],
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final Movie movie;

  const _Slide({required this.movie});

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        spacing: 5,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ? Image
          SizedBox(
            width: 150,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                movie.posterPath,
                width: 150,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress != null) {
                    return Container(
                      padding: EdgeInsetsGeometry.all(8.0),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                  return FadeIn(child: child);
                },
              ),
            ),
          ),

          // ? Title
          SizedBox(
            width: 150,
            child: Text(movie.title, maxLines: 2, style: textStyles.titleSmall),
          ),

          // ? Rating
          SizedBox(
            width: 150,
            child: Row(
              spacing: 3,
              children: [
                Icon(Icons.star_half_outlined, color: Colors.yellow.shade800),
                Text(
                  '${movie.voteAverage}',
                  style: textStyles.bodyMedium?.copyWith(
                    color: Colors.yellow.shade800,
                  ),
                ),
                const Spacer(),
                Text(
                  FormatNumber.short(movie.popularity),
                  style: textStyles.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
