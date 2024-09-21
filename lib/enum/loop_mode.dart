import 'package:hive_flutter/hive_flutter.dart';

part 'loop_mode.g.dart';

@HiveType(typeId: 91)
enum LatteLoopMode {
  @HiveField(0)
  off,
  @HiveField(1)
  one,
  @HiveField(2)
  all,
}
