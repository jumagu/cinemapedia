import 'package:cinemapedia/domain/datasources/local_movies_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/domain/repositories/local_movies_repository.dart';

class LocalMoviesRepositoryImpl extends LocalMoviesRepository {
  final LocalMoviesDatasource datasource;

  LocalMoviesRepositoryImpl(this.datasource);

  @override
  Future<bool> isFavoriteMovie(int movieId) {
    return datasource.isFavoriteMovie(movieId);
  }

  @override
  Future<List<Movie>> loadFavoriteMovies({int limit = 10, int offset = 0}) {
    return datasource.loadFavoriteMovies(limit: limit, offset: offset);
  }

  @override
  Future<void> toggleFavoriteMovie(Movie movie) {
    return datasource.toggleFavoriteMovie(movie);
  }
}
