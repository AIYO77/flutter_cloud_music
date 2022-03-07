// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'songs_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SongsModel _$SongsModelFromJson(Map<String, dynamic> json) => SongsModel(
      (json['songs'] as List<dynamic>)
          .map((e) => Song.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['privileges'] as List<dynamic>)
          .map((e) => PrivilegeModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SongsModelToJson(SongsModel instance) =>
    <String, dynamic>{
      'songs': instance.songs,
      'privileges': instance.privileges,
    };
