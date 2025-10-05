import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infrastructure/models/tmdb/tmdb_movie.dart';
import 'package:cinemapedia/infrastructure/models/tmdb/tmdb_movie_detail.dart';

class MovieMapper {
  static Movie tmdbMovieToEntity(TmdbMovie tmdbMovie) {
    final String backdropPath = tmdbMovie.backdropPath != ''
        ? 'https://image.tmdb.org/t/p/w500${tmdbMovie.backdropPath}'
        : 'https://bigtex.com/wp-content/uploads/2018/05/placeholder-1920x1080.png';

    final String posterPath = tmdbMovie.posterPath != ''
        ? 'https://image.tmdb.org/t/p/w500${tmdbMovie.posterPath}'
        : 'no-poster';

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
      releaseDate: tmdbMovie.releaseDate ?? DateTime.now(),
      title: tmdbMovie.title,
      video: tmdbMovie.video,
      voteAverage: tmdbMovie.voteAverage,
      voteCount: tmdbMovie.voteCount,
    );
  }

  static Movie tmdbMovieDetailToEntity(TmdbMovieDetail tmdbMovieDetail) {
    final String backdropPath = tmdbMovieDetail.backdropPath != ''
        ? 'https://image.tmdb.org/t/p/w500${tmdbMovieDetail.backdropPath}'
        : 'https://bigtex.com/wp-content/uploads/2018/05/placeholder-1920x1080.png';

    final String posterPath = tmdbMovieDetail.posterPath != ''
        ? 'https://image.tmdb.org/t/p/w500${tmdbMovieDetail.posterPath}'
        : 'https://www.juliedray.com/wp-content/uploads/2022/01/sans-affiche.png';

    return Movie(
      adult: tmdbMovieDetail.adult,
      backdropPath: backdropPath,
      genreIds: tmdbMovieDetail.genres.map((e) => e.name).toList(),
      id: tmdbMovieDetail.id,
      originalLanguage: tmdbMovieDetail.originalLanguage,
      originalTitle: tmdbMovieDetail.originalTitle,
      overview: tmdbMovieDetail.overview,
      popularity: tmdbMovieDetail.popularity,
      posterPath: posterPath,
      releaseDate: tmdbMovieDetail.releaseDate,
      title: tmdbMovieDetail.title,
      video: tmdbMovieDetail.video,
      voteAverage: tmdbMovieDetail.voteAverage,
      voteCount: tmdbMovieDetail.voteCount,
    );
  }
}
