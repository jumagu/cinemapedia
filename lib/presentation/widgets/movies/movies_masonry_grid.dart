import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/widgets/movies/movie_poster_link.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class MoviesMasonryGrid extends StatefulWidget {
  final List<Movie> movies;
  final Future<List<Movie>> Function()? loadNextPage;

  const MoviesMasonryGrid({super.key, required this.movies, this.loadNextPage});

  @override
  State<MoviesMasonryGrid> createState() => _MoviesMasonryGridState();
}

class _MoviesMasonryGridState extends State<MoviesMasonryGrid> {
  bool isLastPage = false;
  bool isLoading = false;
  final scrollContoller = ScrollController();

  Future<void> loadNextMoviePage() async {
    if (widget.loadNextPage == null) return;

    if (isLoading || isLastPage) return;

    isLoading = true;

    final movies = await widget.loadNextPage!();

    isLoading = false;

    if (movies.isEmpty) {
      isLastPage = true;
    }
  }

  @override
  void initState() {
    super.initState();

    scrollContoller.addListener(() {
      if (scrollContoller.position.pixels + 200 >=
          scrollContoller.position.maxScrollExtent) {
        loadNextMoviePage();
      }
    });
  }

  @override
  void dispose() {
    scrollContoller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 10),
      child: MasonryGridView.count(
        controller: scrollContoller,
        crossAxisCount: 3,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        itemCount: widget.movies.length,
        itemBuilder: (context, index) {
          if (index == 1) {
            return Column(
              children: [
                const SizedBox(height: 30),
                MoviePosterLink(movie: widget.movies[index]),
              ],
            );
          }

          return MoviePosterLink(movie: widget.movies[index]);
        },
      ),
    );
  }
}
