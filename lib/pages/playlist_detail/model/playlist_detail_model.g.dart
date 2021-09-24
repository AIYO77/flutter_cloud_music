// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playlist_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaylistDetailModel _$PlaylistDetailModelFromJson(Map<String, dynamic> json) =>
    PlaylistDetailModel(
      json['code'] as int,
      Playlist.fromJson(json['playlist'] as Map<String, dynamic>),
      (json['privileges'] as List<dynamic>)
          .map((e) => PrivilegeModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PlaylistDetailModelToJson(
        PlaylistDetailModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'playlist': instance.playlist,
      'privileges': instance.privileges,
    };

Playlist _$PlaylistFromJson(Map<String, dynamic> json) => Playlist(
      json['id'] as int,
      json['name'] as String,
      json['coverImgUrl'] as String,
      json['createTime'] as int,
      json['status'] as int,
      json['opRecommend'] as bool,
      json['highQuality'] as bool,
      json['newImported'] as bool,
      json['updateTime'] as int,
      json['trackCount'] as int,
      json['specialType'] as int,
      json['privacy'] as int,
      json['trackUpdateTime'] as int,
      json['playCount'] as int,
      json['trackNumberUpdateTime'] as int,
      json['subscribedCount'] as int,
      json['cloudTrackCount'] as int,
      json['ordered'] as bool,
      json['description'] as String?,
      json['updateFrequency'] as String?,
      json['backgroundCoverUrl'] as String?,
      json['titleImageUrl'] as String?,
      json['englishTitle'] as String?,
      json['tags'] as List<dynamic>,
      json['backgroundCoverId'] as int,
      (json['subscribers'] as List<dynamic>)
          .map((e) => UserInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
      UserInfo.fromJson(json['creator'] as Map<String, dynamic>),
      (json['tracks'] as List<dynamic>)
          .map((e) => Song.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['trackIds'] as List<dynamic>)
          .map((e) => TrackIds.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['shareCount'] as int,
      json['commentCount'] as int,
      json['officialPlaylistType'] as String?,
    );

Map<String, dynamic> _$PlaylistToJson(Playlist instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'coverImgUrl': instance.coverImgUrl,
      'createTime': instance.createTime,
      'status': instance.status,
      'opRecommend': instance.opRecommend,
      'highQuality': instance.highQuality,
      'newImported': instance.newImported,
      'updateTime': instance.updateTime,
      'trackCount': instance.trackCount,
      'specialType': instance.specialType,
      'privacy': instance.privacy,
      'trackUpdateTime': instance.trackUpdateTime,
      'playCount': instance.playCount,
      'trackNumberUpdateTime': instance.trackNumberUpdateTime,
      'subscribedCount': instance.subscribedCount,
      'cloudTrackCount': instance.cloudTrackCount,
      'ordered': instance.ordered,
      'description': instance.description,
      'updateFrequency': instance.updateFrequency,
      'titleImageUrl': instance.titleImageUrl,
      'englishTitle': instance.englishTitle,
      'backgroundCoverUrl': instance.backgroundCoverUrl,
      'tags': instance.tags,
      'backgroundCoverId': instance.backgroundCoverId,
      'subscribers': instance.subscribers,
      'creator': instance.creator,
      'tracks': instance.tracks,
      'trackIds': instance.trackIds,
      'shareCount': instance.shareCount,
      'commentCount': instance.commentCount,
      'officialPlaylistType': instance.officialPlaylistType,
    };

TrackIds _$TrackIdsFromJson(Map<String, dynamic> json) => TrackIds(
      json['id'] as int,
    );

Map<String, dynamic> _$TrackIdsToJson(TrackIds instance) => <String, dynamic>{
      'id': instance.id,
    };
