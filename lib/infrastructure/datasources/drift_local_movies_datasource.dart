import 'package:cinemapedia/config/database/database.dart';
import 'package:cinemapedia/domain/datasources/local_movies_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:drift/drift.dart' as drift;

class DriftLocalMoviesDatasource extends LocalMoviesDatasource {
  final AppDatabase database;

  DriftLocalMoviesDatasource([AppDatabase? databaseToUse])
    : database = databaseToUse ?? AppDatabase();

  @override
  Future<bool> isFavoriteMovie(int movieId) async {
    final query = database.select(database.favoriteMovies)
      ..where((favMovieTable) => favMovieTable.moiveId.equals(movieId));

    final favoriteMovie = await query.getSingleOrNull();

    return favoriteMovie != null;
  }

  @override
  Future<List<Movie>> loadFavoriteMovies({
    int limit = 10,
    int offset = 0,
  }) async {
    final query = database.select(database.favoriteMovies)
      ..limit(limit, offset: offset);

    final favoriteMoviesDb = await query.get();

    final movies = favoriteMoviesDb
        .map(
          (favMovie) => Movie(
            adult: false,
            backdropPath: favMovie.backdropPath,
            genreIds: const [],
            id: favMovie.moiveId,
            originalLanguage: '',
            originalTitle: favMovie.originalTitle,
            overview: '',
            popularity: 0.0,
            posterPath: favMovie.posterPath,
            releaseDate: DateTime.now(),
            title: favMovie.title,
            video: false,
            voteAverage: favMovie.voteAverage,
            voteCount: 0,
          ),
        )
        .toList();

    return movies;
  }

  @override
  Future<void> toggleFavoriteMovie(Movie movie) async {
    final isFavorite = await isFavoriteMovie(movie.id);

    // If movie exists in db, delete it
    if (isFavorite) {
      final deleteQuery = database.delete(database.favoriteMovies)
        ..where((favMovieTable) => favMovieTable.moiveId.equals(movie.id));

      await deleteQuery.go();

      return;
    }

    // If not exists in db, insert it
    await database
        .into(database.favoriteMovies)
        .insert(
          FavoriteMoviesCompanion.insert(
            moiveId: movie.id,
            backdropPath: movie.backdropPath,
            originalTitle: movie.originalTitle,
            posterPath: movie.posterPath,
            title: movie.title,
            voteAverage: drift.Value(movie.voteAverage),
          ),
        );
  }
}
