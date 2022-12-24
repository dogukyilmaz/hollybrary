import 'dart:convert';

import 'package:hive_flutter/adapters.dart';
import 'package:http/http.dart' as http;

import 'package:hollybrary/utils/constants.dart';
import 'package:hollybrary/models/error_model.dart';
import 'package:hollybrary/models/movie_model.dart';
import 'package:hollybrary/models/tv_model.dart';

class FetchTvShowDetail {
  Future<List<dynamic>> getTvDetails(String id) async {
    TvInfoModel info;
    TrailerList trailerList;
    ImageBackdropList backdropList;
    var images = [];
    CastInfoList castInfoList;
    TvModelList similarshows;
    var box = Hive.box('Tv');
    dynamic tv;
    var res = await http.get(Uri.parse('$BASE_URL/tv/$id'));

    if (res.statusCode == 200) {
      tv = jsonDecode(res.body);
      box.put(id, jsonDecode(res.body));
    } else {
      throw FetchDataError('Something went wrong');
    }

    info = TvInfoModel.fromJson(tv['data']);
    trailerList = TrailerList.fromJson(tv['videos']);
    images.addAll(tv['images']['backdrops']);
    images.addAll(tv['images']['posters']);
    images.addAll(tv['images']['logos']);
    backdropList = ImageBackdropList.fromJson(images);
    castInfoList = CastInfoList.fromJson(tv['credits']);
    similarshows = TvModelList.fromJson(tv['similar']['results']);
    return [
      info,
      trailerList.trailers,
      backdropList.backdrops,
      castInfoList.castList,
      similarshows.movies,
    ];
  }
}
