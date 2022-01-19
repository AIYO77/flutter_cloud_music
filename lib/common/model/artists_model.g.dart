// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artists_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArtistsModel _$ArtistsModelFromJson(Map<String, dynamic> json) => ArtistsModel(
      (json['artists'] as List<dynamic>)
          .map((e) => Artists.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['more'] as bool,
    );

Map<String, dynamic> _$ArtistsModelToJson(ArtistsModel instance) =>
    <String, dynamic>{
      'artists': instance.artists,
      'more': instance.more,
    };

Artists _$ArtistsFromJson(Map<String, dynamic> json) => Artists(
      json['accountId'] as int?,
      json['albumSize'] as int,
      (json['alias'] as List<dynamic>).map((e) => e as String).toList(),
      json['briefDesc'] as String,
      json['followed'] as bool,
      json['id'] as int,
      json['img1v1Url'] as String,
      json['musicSize'] as int,
      json['name'] as String,
      json['topicPerson'] as int,
      json['trans'] as String,
    );

Map<String, dynamic> _$ArtistsToJson(Artists instance) => <String, dynamic>{
      'accountId': instance.accountId,
      'albumSize': instance.albumSize,
      'alias': instance.alias,
      'briefDesc': instance.briefDesc,
      'followed': instance.followed,
      'id': instance.id,
      'img1v1Url': instance.img1v1Url,
      'musicSize': instance.musicSize,
      'name': instance.name,
      'topicPerson': instance.topicPerson,
      'trans': instance.trans,
    };
