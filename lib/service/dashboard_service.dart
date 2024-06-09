import 'package:dio/dio.dart';
import 'package:html/parser.dart';
import 'package:latte/model/dashboard.dart';

class DashboardService {
  final top100URL = "https://www.melon.com/chart/index.htm";
  final hot100URL = "https://www.melon.com/chart/hot100/index.htm";
  final new50URL = "https://www.melon.com/new/index.htm";

  final dio = Dio();

  Future<Dashboard> requestDashboard() async {
    return Dashboard(
      top100List: await requuestSongList(top100URL),
      hot100List: await requuestSongList(hot100URL),
      new50List: await requuestSongList(new50URL),
    );
  }

  Future<List<DashboardSong>> requuestSongList(String url) async {
    final list = <DashboardSong>[];
    final res = await dio.get(url);
    final document = parse(res.data);
    final tbody = document.querySelector("tbody");
    if (tbody == null) {
      return [];
    }
    final trList = tbody.getElementsByTagName("tr");
    for (final tr in trList) {
      final rank = tr.getElementsByClassName("rank");
      final imageURL = tr.getElementsByTagName("img");
      final song = tr.getElementsByClassName("rank01");
      final singer = tr.getElementsByClassName("rank02");
      final album = tr.getElementsByClassName("rank03");
      final dashboardSong = DashboardSong(
        rank: int.parse(rank.first.text.trim()),
        song: song.first.text.trim(),
        album: album.first.text.trim(),
        imageURL:
            imageURL.first.attributes["src"]?.split("/melon/").first ?? "",
        singer: singer.first.text.trim(),
      );
      list.add(dashboardSong);
    }
    return list;
  }
}
