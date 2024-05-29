import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:latte/model/player_setting.dart';
import 'package:latte/model/song.dart';
import 'package:latte/service/data_base.dart';

class AudioService {
  final settingBox = DataBase<PlayerSetting>("PlayerSettingBox");
  final settingKey = "PlayerSettingKey";
  AudioPlayer audio = AudioPlayer();
  final _playList = ConcatenatingAudioSource(
    children: [],
  );

  Stream<PlayerState> get playerStateStream {
    return audio.playerStateStream;
  }

  Stream<Duration> get positionStream {
    return audio.positionStream;
  }

  Stream<Duration> get bufferedPostionStream {
    return audio.bufferedPositionStream;
  }

  Stream<int?> get currentIndexStream {
    return audio.currentIndexStream;
  }

  Future init() async {
    await JustAudioBackground.init(
      androidNotificationChannelId: 'com.hann.latte.audio',
      androidNotificationChannelName: 'audio channel',
      androidNotificationOngoing: true,
    );
    await settingBox.openBox();
  }

  Future play({int index = 0}) async {
    await audio.setAudioSource(
      _playList,
      initialIndex: index,
      preload: false,
    );
    return audio.play();
  }

  Future<bool> setAudioList(List<Song> songList) async {
    try {
      await _playList.clear();
      final List<UriAudioSource> list = [];
      for (final song in songList) {
        final url = await song.audioURL;
        if (url != null) {
          final source = AudioSource.uri(
            Uri.parse(url),
            tag: MediaItem(
              id: song.youtubeID,
              title: song.title,
              artUri: Uri.parse(song.thumbnail),
              duration: song.duration,
            ),
          );
          list.add(source);
        }
      }
      _playList.addAll(list);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future stop() {
    return audio.stop();
  }

  Future pause() {
    return audio.pause();
  }

  Future seek(Duration position) {
    return audio.seek(position);
  }

  Stream<PlayerSetting?> get playerSettingStream {
    return settingBox.stream.map((event) {
      return event.value;
    });
  }

  Future updateSetting(PlayerSetting setting) async {
    await audio.setLoopMode(setting.loopMode);
    return settingBox.updateData(settingKey, setting);
  }

  PlayerSetting? loadSetting() {
    return settingBox.loadData(settingKey);
  }
}
