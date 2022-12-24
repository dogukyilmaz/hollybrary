import 'dart:convert';

import 'package:hive_flutter/adapters.dart';
import 'package:http/http.dart' as http;

import 'package:hollybrary/utils/constants.dart';
import 'package:hollybrary/models/error_model.dart';
import 'package:hollybrary/models/movie_model.dart';
import 'package:hollybrary/models/serie_model.dart';

class GetSerieDetail {
  Future<List<dynamic>> getTvDetails(String id) async {
    SerieDetailModel info;
    TrailerList trailerList;
    ImageBackdropList backdropList;
    var images = [];
    CastInfoList castInfoList;
    SerieModelList similarshows;
    var box = Hive.box('Tv');
    dynamic tv;
    var res = await http.get(Uri.parse('$BASE_URL/tv/$id'));

    if (res.statusCode == 200) {
      tv = jsonDecode(res.body);
      box.put(id, jsonDecode(res.body));
    } else {
      throw ErrorDataModel('Something went wrong');
    }

    info = SerieDetailModel.fromJson(tv['data']);
    trailerList = TrailerList.fromJson(tv['videos']);
    images.addAll(tv['images']['backdrops']);
    images.addAll(tv['images']['posters']);
    images.addAll(tv['images']['logos']);
    backdropList = ImageBackdropList.fromJson(images);
    castInfoList = CastInfoList.fromJson(tv['credits']);
    similarshows = SerieModelList.fromJson(tv['similar']['results']);
    return [
      info,
      trailerList.trailers,
      backdropList.backdrops,
      castInfoList.castList,
      similarshows.movies,
    ];
  }
}
