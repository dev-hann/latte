import 'package:hive_flutter/hive_flutter.dart';

part 'search_suggestion_type.g.dart';

@HiveType(typeId: 90)
enum SearchSuggestionType {
  @HiveField(0)
  history,
  @HiveField(1)
  suggestion,
}
