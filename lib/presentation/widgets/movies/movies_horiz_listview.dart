import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/config/helpers/format_number.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';

class MoviesHorizListview extends StatefulWidget {
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
  State<MoviesHorizListview> createState() => _MoviesHorizListviewState();
}

class _MoviesHorizListviewState extends State<MoviesHorizListview> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (widget.loadNextMovies == null) return;

      final maxScroll = scrollController.position.maxScrollExtent;
      final scrollPosition = scrollController.position.pixels + 200;

      if (scrollPosition >= maxScroll) {
        widget.loadNextMovies!();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 360,
      child: Column(
        spacing: 10,
        children: [
          if (widget.title != null || widget.label != null)
            _Header(title: widget.title, label: widget.label),
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: widget.movies.length,
              itemBuilder: (context, index) {
                final movie = widget.movies[index];
                return FadeInRight(child: _Slide(movie: movie));
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
      height: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        spacing: 5,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ? Image
          SizedBox(
            width: 150,
            height: 225,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                movie.posterPath,
                width: 150,
                height: double.infinity,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress != null) {
                    return Container(
                      padding: EdgeInsets.all(0.8),
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
