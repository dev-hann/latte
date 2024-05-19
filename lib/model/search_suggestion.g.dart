// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_suggestion.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SearchSuggesntionAdapter extends TypeAdapter<SearchSuggesntion> {
  @override
  final int typeId = 5;

  @override
  SearchSuggesntion read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SearchSuggesntion(
      query: fields[0] as String,
      type: SearchSuggestionType.values.toList()[fields[1]],
    );
  }

  @override
  void write(BinaryWriter writer, SearchSuggesntion obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.query)
      ..writeByte(1)
      ..write(obj.type.index);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SearchSuggesntionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
