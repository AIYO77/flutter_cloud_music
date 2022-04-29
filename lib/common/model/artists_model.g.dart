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
      json['followed'] as bool,
      json['id'] as int,
      json['img1v1Url'] as String,
      json['name'] as String,
      json['trans'] as String?,
      json['mvSize'] as int?,
      json['identityIconUrl'] as String?,
    );

Map<String, dynamic> _$ArtistsToJson(Artists instance) => <String, dynamic>{
      'accountId': instance.accountId,
      'albumSize': instance.albumSize,
      'alias': instance.alias,
      'followed': instance.followed,
      'id': instance.id,
      'img1v1Url': instance.img1v1Url,
      'name': instance.name,
      'trans': instance.trans,
      'mvSize': instance.mvSize,
      'identityIconUrl': instance.identityIconUrl,
    };
