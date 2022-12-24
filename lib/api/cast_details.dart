import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:hollybrary/utils/constants.dart';
import 'package:hollybrary/models/cast_model.dart';
import 'package:hollybrary/models/error_model.dart';
import 'package:hollybrary/models/movie_model.dart';
import 'package:hollybrary/models/serie_model.dart';

class GetCastById {
  Future<List<dynamic>> getCastDetails(String id) async {
    CastModel prinfo;
    SocialMediaInfo socialMedia;
    ImageBackdropList backdrops;
    MovieModelList movies;
    SerieModelList tv;
    var response = await http.get(Uri.parse('$BASE_URL/cast/$id'));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      prinfo = CastModel.fromJson(data['data']);
      socialMedia = SocialMediaInfo.fromJson(data['socialmedia']);
      backdrops = ImageBackdropList.fromJson(data['images']['profiles']);

      movies = MovieModelList.fromJson(data['movies']['cast']);
      tv = SerieModelList.fromJson(data['tv']['cast']);

      return [
        prinfo,
        socialMedia,
        backdrops.backdrops,
        movies.movies,
        tv.movies,
      ];
    } else {
      throw ErrorDataModel('Failure to fetch data');
    }
  }
}
