import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:latte/enum/search_suggestion_type.dart';
import 'package:latte/model/search_suggestion.dart';
import 'package:latte/service/data_base.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class SearchService {
  final dio = Dio();
  final youtubeService = YoutubeExplode();
  final searchBox = DataBase<List>("SearchBox");
  final searchKey = "SearchKey";

  Future init() {
    return searchBox.openBox();
  }

  Stream<List<SearchSuggesntion>> get stream {
    return searchBox.stream.map((data) {
      return data.value;
    });
  }

  Future updateSearchHistoryList(
      List<SearchSuggesntion> searchHistoryList) async {
    await searchBox.updateData(searchKey, searchHistoryList);
  }

  List<SearchSuggesntion> loadSearchHistoryList() {
    final list = searchBox.loadData(searchKey);
    if (list == null) {
      return [];
    }

    // https://github.com/isar/hive/issues/1266
    return list.sublist(0, min(list.length, 50)).map((e) {
      return e as SearchSuggesntion;
    }).toList();
  }

  Future<VideoSearchList> search(String query) {
    return youtubeService.search.search(query);
  }

  Future<List<SearchSuggesntion>> searchSuggestionList(String query) async {
    final url =
        "http://suggestqueries.google.com/complete/search?client=firefox&ds=yt&q=$query";
    final res = await dio.get(url);
    final data = res.data.toString();
    final jsonData = jsonDecode(data);
    final attributes = List<String>.from(jsonData[1]);
    return attributes.map((e) {
      return SearchSuggesntion(
        query: e,
        type: SearchSuggestionType.suggestion,
      );
    }).toList();
  }
}
