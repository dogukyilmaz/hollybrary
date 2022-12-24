import 'dart:convert';

import 'package:hollybrary/utils/constants.dart';
import 'package:http/http.dart' as http;

import 'package:hollybrary/models/error_model.dart';
import 'package:hollybrary/models/movie_model.dart';

class GetMovieById {
  Future<List<dynamic>> getDetails(String id) async {
    MovieInfoModel movieData;
    MovieInfoImdb omdbData;
    TrailerList trailersData;
    ImageBackdropList backdropsData;
    CastInfoList castData;
    MovieModelList similarData;
    var images = [];
    dynamic movie;
    var response = await http.get(Uri.parse('$BASE_URL/movie/$id'));
    if (response.statusCode == 200) {
      movie = jsonDecode(response.body);
    } else {
      throw ErrorDataModel('Something went wrong');
    }

    movieData = MovieInfoModel.fromJson(movie['data']);
    trailersData = TrailerList.fromJson(movie['videos']);
    images.addAll(movie['images']['backdrops']);
    images.addAll(movie['images']['posters']);
    images.addAll(movie['images']['logos']);

    backdropsData = ImageBackdropList.fromJson(images);

    castData = CastInfoList.fromJson(movie['credits']);
    similarData = MovieModelList.fromJson(movie['similar']['results']);

    var imdbId = movieData.imdbId;
    final omdbResponse =
        await http.get(Uri.parse('$BASE_URL/movie/omdb/' + imdbId.toString()));
    if (omdbResponse.statusCode == 200) {
      omdbData = MovieInfoImdb.fromJson(jsonDecode(omdbResponse.body)['data']);
    } else {
      throw ErrorDataModel('Error Fetching data');
    }
    return [
      movieData,
      trailersData.trailers,
      backdropsData.backdrops,
      castData.castList,
      omdbData,
      similarData.movies,
    ];
  }
}
