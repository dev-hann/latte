import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:latte/model/media_item.dart';
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

  Stream<SequenceState?> get sequenceStateStream {
    return audio.sequenceStateStream;
  }

  Future init() async {
    await JustAudioBackground.init(
      androidNotificationChannelId: 'com.hann.latte.audio',
      androidNotificationChannelName: 'audio channel',
      androidNotificationOngoing: true,
    );
    await audio.setAudioSource(_playList);
    await settingBox.openBox();
  }

  Future play() async {
    return audio.play();
  }

  Future setLoopMode(LoopMode mode) {
    return audio.setLoopMode(mode);
  }

  Future<bool> setAudioList(List<Song> songList) async {
    try {
      await _playList.clear();
      for (int index = 0; index < songList.length; index++) {
        final song = songList[index];
        if (index == 0) {
          await setAudio(song);
        } else {
          setAudio(song);
        }
      }

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<int> setAudio(Song song) async {
    final url = await song.audioURL;
    if (url != null) {
      final source = AudioSource.uri(
        Uri.parse(url),
        tag: LatteMediaItem(
          id: song.youtubeID,
          title: song.title,
          artUri: Uri.parse(song.thumbnail),
          author: song.author,
          uploadDateTime: song.uploadDateTime,
          duration: song.duration,
        ),
      );
      await _playList.add(source);
      return _playList.length - 1;
    }
    return -1;
  }

  Future stop() {
    return audio.stop();
  }

  Future pause() {
    return audio.pause();
  }

  Future seek(Duration position, {int? index}) {
    return audio.seek(
      position,
      index: index,
    );
  }

  Stream<PlayerSetting?> get playerSettingStream {
    return settingBox.stream.map((event) {
      return event.value;
    });
  }

  Future updateSetting(PlayerSetting setting) async {
    await audio.setLoopMode(LoopMode.values[setting.loopMode.index]);
    return settingBox.updateData(settingKey, setting);
  }

  PlayerSetting? loadSetting() {
    return settingBox.loadData(settingKey);
  }
}
