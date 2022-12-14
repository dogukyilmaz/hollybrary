import 'dart:convert';

import 'package:hollybrary/utils/constants.dart';
import 'package:http/http.dart' as http;

import 'package:hollybrary/models/movie_model.dart';
import 'package:hollybrary/models/serie_model.dart';

class HomeDataRepo {
  Future<List<dynamic>> getHomePageMovies() async {
    MovieModelList trandingData;
    MovieModelList nowPlayeingData;
    MovieModelList topRatedData;
    MovieModelList upcomingData;
    SerieModelList tvshowData;
    SerieModelList topRatedTvData;

    final response = await http.get(
      Uri.parse('$BASE_URL/home'),
    );
    if (response.statusCode == 200) {
      trandingData =
          MovieModelList.fromJson(json.decode(response.body)['trandingMovies']);
      nowPlayeingData = MovieModelList.fromJson(
          json.decode(response.body)['nowPlayingMovies']);
      topRatedData =
          MovieModelList.fromJson(json.decode(response.body)['topRatedMovies']);
      upcomingData =
          MovieModelList.fromJson(json.decode(response.body)['upcoming']);
      tvshowData =
          SerieModelList.fromJson(json.decode(response.body)['trandingtv']);
      topRatedTvData =
          SerieModelList.fromJson(json.decode(response.body)['topRatedTv']);
      return [
        trandingData.movies,
        nowPlayeingData.movies,
        topRatedData.movies,
        upcomingData.movies,
        tvshowData.movies,
        topRatedTvData.movies
      ];
    } else {
      throw Exception('Failed to load data');
    }
  }
}
