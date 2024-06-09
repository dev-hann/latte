import 'package:equatable/equatable.dart';

class Dashboard extends Equatable {
  const Dashboard({
    required this.top100List,
    required this.hot100List,
    required this.new50List,
  });

  final List<DashboardSong> top100List;
  final List<DashboardSong> hot100List;
  final List<DashboardSong> new50List;

  @override
  List<Object?> get props => [
        top100List,
        hot100List,
        new50List,
      ];
}

class DashboardSong extends Equatable {
  const DashboardSong({
    required this.rank,
    required this.song,
    required this.album,
    required this.imageURL,
    required this.singer,
  });

  final int rank;
  final String singer;
  final String song;
  final String album;
  final String imageURL;

  String get query {
    return "$song $singer audio";
  }

  @override
  List<Object?> get props => [
        rank,
        song,
        album,
        imageURL,
        singer,
      ];
}
