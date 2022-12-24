import 'dart:convert';

import 'package:hollybrary/utils/constants.dart';
import 'package:http/http.dart' as http;

import 'package:hollybrary/models/error_model.dart';
import 'package:hollybrary/models/movie_model.dart';
import 'package:hollybrary/models/people_model.dart';
import 'package:hollybrary/models/serie_model.dart';

class SearchResultsRepo {
  Future<List<dynamic>> getmovies(String query, int page) async {
    var res = await http.get(Uri.parse(
        BASE_URL + '/search/movie?text=$query&page=${page.toString()}'));
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

  Future<List<dynamic>> gettvShows(String query, int page) async {
    var res = await http.get(
        Uri.parse('$BASE_URL/search/tv?text=$query&page=${page.toString()}'));
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

  Future<List<dynamic>> getPersons(String query, int page) async {
    var res = await http.get(Uri.parse(
        BASE_URL + '/search/person?text=$query&page=${page.toString()}'));
    if (res.statusCode == 200) {
      return [
        (jsonDecode(res.body)['data'] as List)
            .map((list) => PerformerModel.fromJson(list))
            .toList(),
        jsonDecode(res.body)['total_pages'],
      ];
    } else {
      throw ErrorDataModel("Something went wrong!");
    }
  }
}
