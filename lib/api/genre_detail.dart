import 'dart:convert';

import 'package:hollybrary/utils/constants.dart';
import 'package:http/http.dart' as http;

import 'package:hollybrary/models/error_model.dart';
import 'package:hollybrary/models/movie_model.dart';
import 'package:hollybrary/models/serie_model.dart';

class GenreDataRepo {
  Future<List<dynamic>> getmovies(String query, int page) async {
    var res = await http.get(
        Uri.parse(BASE_URL + '/genre/movie?id=$query&page=${page.toString()}'));
    if (res.statusCode == 200) {
      return [
        (jsonDecode(res.body)['data'] as List)
            .map((list) => MovieModel.fromJson(list))
            .toList(),
        jsonDecode(res.body)['total_pages'],
      ];
    } else {
      throw ErrorDataModel("Something went wrong!");
    }
  }

  Future<List<dynamic>> getSeries(String query, int page) async {
    var res = await http.get(
        Uri.parse(BASE_URL + '/genre/tv?id=$query&page=${page.toString()}'));
    if (res.statusCode == 200) {
      return [
        (jsonDecode(res.body)['data'] as List)
            .map((list) => SerieModel.fromJson(list))
            .toList(),
        jsonDecode(res.body)['total_pages'],
      ];
    } else {
      throw ErrorDataModel("Something went wrong!");
    }
  }
}
