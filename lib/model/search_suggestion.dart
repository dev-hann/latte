import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:latte/enum/search_suggestion_type.dart';

part 'search_suggestion.g.dart';

@HiveType(typeId: 5)
class SearchSuggesntion extends Equatable {
  const SearchSuggesntion({
    required this.query,
    required this.type,
  });

  @HiveField(0)
  final String query;

  @HiveField(1)
  final SearchSuggestionType type;

  @override
  List<Object?> get props => [
        query,
        type,
      ];
}
