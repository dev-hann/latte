import 'package:hive_flutter/hive_flutter.dart';
import 'package:latte/model/duration.g.dart';
import 'package:latte/model/play_list.dart';
import 'package:latte/model/song.dart';

class DataBase<T> {
  DataBase(this.name);
  final String name;
  late Box _box;

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
    Hive.registerAdapter(DurationAdapter());
    Hive.registerAdapter(PlayListAdapter());
    Hive.registerAdapter(SongAdapter());
  }
}
