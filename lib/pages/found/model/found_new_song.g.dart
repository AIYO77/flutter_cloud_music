// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'found_new_song.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FoundNewSong _$FoundNewSongFromJson(Map<String, dynamic> json) => FoundNewSong(
      SongData.fromJson(json['songData'] as Map<String, dynamic>),
      PrivilegeModel.fromJson(json['songPrivilege'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FoundNewSongToJson(FoundNewSong instance) =>
    <String, dynamic>{
      'songData': instance.songData,
      'songPrivilege': instance.songPrivilege,
    };

SongData _$SongDataFromJson(Map<String, dynamic> json) => SongData(
      json['name'] as String,
      json['id'] as int,
      json['fee'] as int,
      json['copyright'] as int?,
      json['originCoverType'] as int?,
      json['mvid'] as int,
      (json['alias'] as List<dynamic>).map((e) => e as String).toList(),
      (json['artists'] as List<dynamic>)
          .map((e) => Ar.fromJson(e as Map<String, dynamic>))
          .toList(),
      AlbumSimple.fromJson(json['album'] as Map<String, dynamic>),
      json['privilege'] == null
          ? null
          : PrivilegeModel.fromJson(json['privilege'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SongDataToJson(SongData instance) => <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'fee': instance.fee,
      'copyright': instance.copyright,
      'originCoverType': instance.originCoverType,
      'mvid': instance.mvid,
      'alias': instance.alias,
      'artists': instance.artists,
      'album': instance.album,
      'privilege': instance.songPrivilege,
    };
