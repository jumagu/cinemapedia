import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infrastructure/models/tmdb/tmdb_movie.dart';

class MovieMapper {
  static Movie tmdbMovieToEntity(TmdbMovie tmdbMovie) {
    final String backdropPath = tmdbMovie.backdropPath != ''
        ? 'https://image.tmdb.org/t/p/w500/${tmdbMovie.backdropPath}'
        : 'https://bigtex.com/wp-content/uploads/2018/05/placeholder-1920x1080.png';

    final String posterPath = tmdbMovie.posterPath != ''
        ? 'https://image.tmdb.org/t/p/w500/${tmdbMovie.posterPath}'
        : 'https://www.juliedray.com/wp-content/uploads/2022/01/sans-affiche.png';

    return Movie(
      adult: tmdbMovie.adult,
      backdropPath: backdropPath,
      genreIds: tmdbMovie.genreIds
          .map((genreId) => genreId.toString())
          .toList(),
      id: tmdbMovie.id,
      originalLanguage: tmdbMovie.originalLanguage,
      originalTitle: tmdbMovie.originalTitle,
      overview: tmdbMovie.overview,
      popularity: tmdbMovie.popularity,
      posterPath: posterPath,
      releaseDate: tmdbMovie.releaseDate,
      title: tmdbMovie.title,
      video: tmdbMovie.video,
      voteAverage: tmdbMovie.voteAverage,
      voteCount: tmdbMovie.voteCount,
    );
  }
}
