import 'dart:math';

import 'package:latte/service/data_base.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class SearchService {
  final youtubeService = YoutubeExplode();
  final searchBox = DataBase<List<String>>("SearchBox");
  final searchKey = "SearchKey";

  Future init() {
    return searchBox.openBox();
  }

  Stream<List<String>> get stream {
    return searchBox.stream.map((data) {
      return data.value;
    });
  }

  Future updateSearchHistoryList(List<String> searchHistoryList) async {
    await searchBox.updateData(searchKey, searchHistoryList);
  }

  List<String> loadSearchedList() {
    final list = searchBox.loadData(searchKey);
    if (list == null) {
      return [];
    }
    return list.sublist(0, min(list.length, 50)).toList();
  }

  Future<VideoSearchList> search(String query) {
    return youtubeService.search.search(query);
  }
}
