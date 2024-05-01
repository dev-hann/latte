import 'package:hive_flutter/hive_flutter.dart';

class DurationAdapter extends TypeAdapter<Duration> {
  @override
  final int typeId = 3;

  @override
  Duration read(BinaryReader reader) {
    return Duration(milliseconds: reader.read());
  }

  @override
  void write(BinaryWriter writer, Duration obj) {
    writer.write(obj.inMilliseconds);
  }
}
