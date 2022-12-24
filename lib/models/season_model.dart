import '../utils/formated_time_genrator.dart';
import 'movie_model.dart';

class SeasonEpisodeModel {
  final String id;
  final String name;
  final String overview;
  final String seasonNumber;
  final String stillPath;
  final double voteAverage;
  final String date;
  final String number;
  final String customDate;
  final List<CastInfo> castInfoList;

  SeasonEpisodeModel({
    required this.id,
    required this.name,
    required this.overview,
    required this.seasonNumber,
    required this.stillPath,
    required this.voteAverage,
    required this.date,
    required this.number,
    required this.customDate,
    required this.castInfoList,
  });

  factory SeasonEpisodeModel.fromJson(json) {
    var string = "Not Available";
    getString() {
      try {
        string =
            "${monthgenrater(json['air_date'].split("-")[1])} ${json['air_date'].split("-")[2]}, ${json['air_date'].split("-")[0]}";
        // ignore: empty_catches
      } catch (e) {}
    }

    getString();
    return SeasonEpisodeModel(
      id: json['id'].toString(),
      name: json['name'] ?? '',
      overview: json['overview'] ?? '',
      seasonNumber: json['season_number'].toString(),
      stillPath: json['still_path'] != null
          ? "https://image.tmdb.org/t/p/w500" + json['still_path']
          : "https://images.pexels.com/photos/1983037/pexels-photo-1983037.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      voteAverage: json['vote_average'].toDouble() ?? 0.0,
      date: json['air_date'],
      number: json['episode_number'].toString(),
      castInfoList: (json['guest_stars'] as List)
          .map((star) => CastInfo.fromJson(star))
          .toList(),
      customDate: string,
    );
  }
}

class SeasonModel {
  final String name;
  final String overview;
  final String id;
  final String posterPath;
  final String seasonNumber;
  final String customDate;
  final List<SeasonEpisodeModel> episodes;
  SeasonModel({
    required this.name,
    required this.overview,
    required this.id,
    required this.posterPath,
    required this.seasonNumber,
    required this.customDate,
    required this.episodes,
  });

  factory SeasonModel.fromJson(json) {
    var string = "Not Available";
    getString() {
      try {
        string =
            "${monthgenrater(json['air_date'].split("-")[1])} ${json['air_date'].split("-")[2]}, ${json['air_date'].split("-")[0]}";
        // ignore: empty_catches
      } catch (e) {}
    }

    getString();
    return SeasonModel(
      name: json['name'] ?? '',
      overview: json['overview'] == "" ? "N/A" : json['overview'] ?? "",
      id: json['id'].toString(),
      posterPath: json['poster_path'] != null
          ? "https://image.tmdb.org/t/p/w500" + json['poster_path']
          : "https://images.pexels.com/photos/1983037/pexels-photo-1983037.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      seasonNumber: json['season_number'].toString(),
      episodes: ((json['episodes'] ?? []) as List)
          .map((episode) => SeasonEpisodeModel.fromJson(episode))
          .toList(),
      customDate: string,
    );
  }
}
