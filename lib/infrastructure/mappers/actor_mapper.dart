import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/infrastructure/models/tmdb/tmdb_movie_credits_response.dart';

class ActorMapper {
  static Actor tmdbCastItemToEntity(Cast castItem) {
    final String profilePath = castItem.profilePath != null
        ? 'https://image.tmdb.org/t/p/w500${castItem.profilePath}'
        : 'https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png';

    return Actor(
      id: castItem.id,
      name: castItem.name,
      profilePath: profilePath,
      character: castItem.character,
    );
  }
}
