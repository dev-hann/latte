// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_suggestion_type.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SearchSuggestionTypeAdapter extends TypeAdapter<SearchSuggestionType> {
  @override
  final int typeId = 90;

  @override
  SearchSuggestionType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return SearchSuggestionType.history;
      case 1:
        return SearchSuggestionType.suggestion;
      default:
        return SearchSuggestionType.history;
    }
  }

  @override
  void write(BinaryWriter writer, SearchSuggestionType obj) {
    switch (obj) {
      case SearchSuggestionType.history:
        writer.writeByte(0);
        break;
      case SearchSuggestionType.suggestion:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SearchSuggestionTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
