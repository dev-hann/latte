import 'package:equatable/equatable.dart';
import 'package:melon/melon.dart';

class Dashboard extends Equatable {
  const Dashboard({
    required this.top100List,
    required this.hot100List,
    required this.new50List,
    required this.djList,
  });

  final List<MelonSong> top100List;
  final List<MelonSong> hot100List;
  final List<MelonSong> new50List;
  final List<MelonDj> djList;

  @override
  List<Object?> get props => [
        top100List,
        hot100List,
        new50List,
        djList,
      ];
}
