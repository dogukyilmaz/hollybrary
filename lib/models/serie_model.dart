import '../utils/formated_time_genrator.dart';

class SerieModel {
  final String title;
  final String poster;
  final String id;
  final String backdrop;
  final double voteAverage;
  final String year;
  final String releaseDate;
  SerieModel({
    required this.title,
    required this.poster,
    required this.id,
    required this.backdrop,
    required this.voteAverage,
    required this.year,
    required this.releaseDate,
  });

  factory SerieModel.fromJson(Map<String, dynamic> json) {
    var string = "Not Available";
    getString() {
      try {
        string =
            "${monthgenrater(json['first_air_date'].split("-")[1])} ${json['first_air_date'].split("-")[2]}, ${json['first_air_date'].split("-")[0]}";
      } catch (e) {
        // ignore: avoid_print
      }
    }

    getString();
    return SerieModel(
      backdrop: json['backdrop_path'] != null
          ? "https://image.tmdb.org/t/p/w500" + json['backdrop_path']
          : "https://images.pexels.com/photos/1983037/pexels-photo-1983037.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      poster: json['poster_path'] != null
          ? "https://image.tmdb.org/t/p/w500" + json['poster_path']
          : "https://images.pexels.com/photos/1983037/pexels-photo-1983037.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      id: json['id'].toString(),
      title: json['name'],
      year: json['first_air_date'].toString(),
      voteAverage: json['vote_average'].toDouble() ?? 0.0,
      releaseDate: string,
    );
  }
}

class SerieModelList {
  final List<SerieModel> movies;
  SerieModelList({
    required this.movies,
  });
  factory SerieModelList.fromJson(List<dynamic> json) {
    return SerieModelList(
        movies: (json).map((list) => SerieModel.fromJson(list)).toList());
  }
}

class SerieDetailModel {
  final String tmdbId;
  final String overview;
  final String title;
  final List languages;
  final String backdrops;
  final String poster;
  final String tagline;
  final double rating;
  final String homepage;
  final List GenreModel;
  final List<Seasons> seasons;
  final List created;
  final List networks;
  final String numberOfSeasons;
  final String date;
  final String formatedDate;
  final String episoderuntime;
  SerieDetailModel({
    required this.tmdbId,
    required this.overview,
    required this.title,
    required this.languages,
    required this.backdrops,
    required this.poster,
    required this.tagline,
    required this.rating,
    required this.homepage,
    required this.GenreModel,
    required this.seasons,
    required this.created,
    required this.networks,
    required this.numberOfSeasons,
    required this.date,
    required this.formatedDate,
    required this.episoderuntime,
  });
  factory SerieDetailModel.fromJson(json) {
    var string = "Not Available";
    try {
      string =
          "${monthgenrater(json['first_air_date'].split("-")[1])} ${json['first_air_date'].split("-")[2]}, ${json['first_air_date'].split("-")[0]}";
      // ignore: empty_catches
    } catch (e) {}
    return SerieDetailModel(
      title: json['name'] ?? '',
      homepage: json['homepage'] ?? "",
      languages: (json['spoken_languages'] as List)
          .map((laung) => laung['english_name'])
          .toList(),
      created:
          (json['created_by'] as List).map((laung) => laung['name']).toList(),
      GenreModel:
          (json['GenreModel'] as List).map((laung) => laung['name']).toList(),
      networks:
          (json['networks'] as List).map((laung) => laung['name']).toList(),
      overview: json['overview'] ?? '',
      backdrops: json['backdrop_path'] != null
          ? "https://image.tmdb.org/t/p/w500" + json['backdrop_path']
          : "https://images.pexels.com/photos/1983037/pexels-photo-1983037.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      poster: json['poster_path'] != null
          ? "https://image.tmdb.org/t/p/w500" + json['poster_path']
          : "https://images.pexels.com/photos/1983037/pexels-photo-1983037.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      rating: json['vote_average'].toDouble() ?? 0.0,
      tagline: json['tagline'] ?? '',
      tmdbId: json['id'].toString(),
      numberOfSeasons: json['number_of_seasons'].toString(),
      seasons: (json['seasons'] as List)
          .map((season) => Seasons.fromJson(season))
          .toList(),
      date: json['first_air_date'] ?? '',
      episoderuntime: (json['episode_run_time'] as List).isNotEmpty
          ? json['episode_run_time'][0].toString() + " Minutes"
          : "N/A",
      formatedDate: string,
    );
  }
}

class Seasons {
  final String overview;
  final String name;
  final String id;
  final String image;
  final String date;
  final String customOverView;
  final String episodes;
  final String snum;
  Seasons({
    required this.overview,
    required this.name,
    required this.id,
    required this.image,
    required this.date,
    required this.customOverView,
    required this.episodes,
    required this.snum,
  });

  factory Seasons.fromJson(json) {
    var string = "Not Available";
    getString() {
      try {
        string =
            "premiered on ${monthgenrater(json['air_date'].split("-")[1])} ${json['air_date'].split("-")[2]}, ${json['air_date'].split("-")[0]}";
        // ignore: empty_catches
      } catch (e) {}
    }

    getString();
    return Seasons(
      date: json['air_date'] ?? '',
      episodes: json['episode_count'].toString(),
      id: json['id'].toString(),
      image: json['poster_path'] != null
          ? "https://image.tmdb.org/t/p/w500" + (json['poster_path'] ?? "")
          : "https://images.pexels.com/photos/1983037/pexels-photo-1983037.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      name: json['name'] ?? '',
      overview: json['overview'] == "" ? "N/A" : json['overview'] ?? "",
      customOverView: string,
      snum: json['season_number'].toString(),
    );
  }
}
