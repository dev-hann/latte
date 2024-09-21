import 'package:hive_flutter/hive_flutter.dart';
import 'package:latte/enum/loop_mode.dart';
import 'package:latte/enum/search_suggestion_type.dart';
import 'package:latte/model/duration.g.dart';
import 'package:latte/model/play_list.dart';
import 'package:latte/model/player_setting.dart';
import 'package:latte/model/search_suggestion.dart';
import 'package:latte/model/song.dart';

class DataBase<T> {
  DataBase(this.name);
  final String name;
  late Box<T> _box;

  Future openBox() async {
    _box = await Hive.openBox<T>(name);
  }

  Future clearBox() {
    return _box.clear();
  }

  Stream<BoxEvent> get stream {
    return _box.watch();
  }

  Future updateData(String key, T value) {
    return _box.put(key, value);
  }

  T? loadData(String key) {
    return _box.get(key);
  }

  static Future init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(SongAdapter());
    Hive.registerAdapter(PlayListAdapter());
    Hive.registerAdapter(DurationAdapter());
    Hive.registerAdapter(PlayerSettingAdapter());
    Hive.registerAdapter(SearchSuggesntionAdapter());
    Hive.registerAdapter(LatteLoopModeAdapter());
    Hive.registerAdapter(SearchSuggestionTypeAdapter());
  }
}
