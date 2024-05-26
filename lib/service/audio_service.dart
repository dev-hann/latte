import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:latte/model/player_setting.dart';
import 'package:latte/model/song.dart';
import 'package:latte/service/data_base.dart';

class AudioService {
  final settingBox = DataBase<PlayerSetting>("PlayerSettingBox");
  final settingKey = "PlayerSettingKey";
  final audio = AudioPlayer();

  Stream<PlayerState> get playerStateStream {
    return audio.playerStateStream;
  }

  Stream<Duration> get positionStream {
    return audio.positionStream;
  }

  Stream<Duration> get bufferedPostionStream {
    return audio.bufferedPositionStream;
  }

  Future init() async {
    await JustAudioBackground.init(
      androidNotificationChannelId: 'com.hann.latte.audio',
      androidNotificationChannelName: 'audio channel',
      androidNotificationOngoing: true,
    );
    await settingBox.openBox();
  }

  Future play() {
    return audio.play();
  }

  Future<bool> setAudio(Song song) async {
    final audioURL = await song.audioURL;
    if (audioURL != null) {
      final source = AudioSource.uri(
        Uri.parse(audioURL),
        tag: MediaItem(
          id: song.youtubeID,
          title: song.title,
          artUri: Uri.parse(song.thumbnail),
        ),
      );
      await audio.setAudioSource(source);
      return true;
    }
    return false;
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
