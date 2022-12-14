import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:hollybrary/utils/constants.dart';
import 'package:hollybrary/models/error_model.dart';
import 'package:hollybrary/models/movie_model.dart';
import 'package:hollybrary/models/season_model.dart';

class GetSeasonDetail {
  Future<List<dynamic>> getSeasonDetail(String id, String snum) async {
    SeasonModel seasonInfo;
    CastInfoList castList;
    TrailerList trailerList;
    ImageBackdropList backdropList;

    var res = await http.get(Uri.parse('$BASE_URL/tv/$id/season/$snum'));

    if (res.statusCode == 200) {
      seasonInfo = SeasonModel.fromJson(jsonDecode(res.body)['data']);
      castList = CastInfoList.fromJson(jsonDecode(res.body)['credits']);
      trailerList = TrailerList.fromJson(jsonDecode(res.body)['videos']);
      backdropList =
          ImageBackdropList.fromJson(jsonDecode(res.body)['images']['posters']);
      return [
        seasonInfo,
        castList.castList,
        trailerList.trailers,
        backdropList.backdrops,
      ];
    } else {
      throw ErrorDataModel('Something Went wrong!');
    }
  }
}
