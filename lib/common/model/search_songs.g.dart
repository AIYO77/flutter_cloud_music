// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_songs.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchSongs _$SearchSongsFromJson(Map<String, dynamic> json) => SearchSongs(
      (json['songs'] as List<dynamic>)
          .map((e) => SongData.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['hasMore'] as bool,
      json['songCount'] as int,
    );

Map<String, dynamic> _$SearchSongsToJson(SearchSongs instance) =>
    <String, dynamic>{
      'songs': instance.songs,
      'hasMore': instance.hasMore,
      'songCount': instance.songCount,
    };
