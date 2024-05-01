import 'package:latte/model/play_list.dart';
import 'package:latte/service/data_base.dart';

class PlayListService {
  final playListBox = DataBase<PlayList>("PlayListBox");
  final playListKey = "PlayListKey";

  Future init() {
    return playListBox.openBox();
  }

  Stream<PlayList?> get stream {
    return playListBox.stream.map((data) {
      return data.value;
    });
  }

  Future updatePlayList(PlayList playList) {
    return playListBox.updateData(playListKey, playList);
  }

  PlayList? loadPlayList() {
    return playListBox.loadData(playListKey);
  }
}
