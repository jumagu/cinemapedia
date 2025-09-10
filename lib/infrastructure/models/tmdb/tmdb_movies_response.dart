import 'package:cinemapedia/infrastructure/models/tmdb/tmdb_movie.dart';

class TmdbMoviesResponse {
  final TmdbNowPlayingResponseDates? dates;
  final int page;
  final List<TmdbMovie> results;
  final int totalPages;
  final int totalResults;

  TmdbMoviesResponse({
    required this.dates,
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory TmdbMoviesResponse.fromJson(Map<String, dynamic> json) =>
      TmdbMoviesResponse(
        dates: json["dates"] != null
            ? TmdbNowPlayingResponseDates.fromJson(json["dates"])
            : null,
        page: json["page"],
        results: List<TmdbMovie>.from(
          json["results"].map((x) => TmdbMovie.fromJson(x)),
        ),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );

  Map<String, dynamic> toJson() => {
    "dates": dates?.toJson(),
    "page": page,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
    "total_pages": totalPages,
    "total_results": totalResults,
  };
}

class TmdbNowPlayingResponseDates {
  final DateTime maximum;
  final DateTime minimum;

  TmdbNowPlayingResponseDates({required this.maximum, required this.minimum});

  factory TmdbNowPlayingResponseDates.fromJson(Map<String, dynamic> json) =>
      TmdbNowPlayingResponseDates(
        maximum: DateTime.parse(json["maximum"]),
        minimum: DateTime.parse(json["minimum"]),
      );

  Map<String, dynamic> toJson() => {
    "maximum":
        "${maximum.year.toString().padLeft(4, '0')}-${maximum.month.toString().padLeft(2, '0')}-${maximum.day.toString().padLeft(2, '0')}",
    "minimum":
        "${minimum.year.toString().padLeft(4, '0')}-${minimum.month.toString().padLeft(2, '0')}-${minimum.day.toString().padLeft(2, '0')}",
  };
}
