import 'package:flutter_cloud_music/common/model/privilege_model.dart';
import 'package:flutter_cloud_music/common/model/song_model.dart';
import 'package:flutter_cloud_music/common/model/user_info_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'playlist_detail_model.g.dart';

@JsonSerializable()
class PlaylistDetailModel extends Object {
  @JsonKey(name: 'code')
  int code;

  @JsonKey(name: 'playlist')
  Playlist playlist;

  @JsonKey(name: 'privileges')
  List<PrivilegeModel> privileges;

  PlaylistDetailModel(
    this.code,
    this.playlist,
    this.privileges,
  );

  factory PlaylistDetailModel.fromJson(Map<String, dynamic> srcJson) =>
      _$PlaylistDetailModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$PlaylistDetailModelToJson(this);
}

@JsonSerializable()
class Playlist extends Object {
  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'coverImgUrl')
  String coverImgUrl;

  @JsonKey(name: 'createTime')
  int createTime;

  @JsonKey(name: 'status')
  int status;

  @JsonKey(name: 'opRecommend')
  bool opRecommend;

  @JsonKey(name: 'highQuality')
  bool highQuality;

  @JsonKey(name: 'newImported')
  bool newImported;

  @JsonKey(name: 'updateTime')
  int updateTime;

  @JsonKey(name: 'trackCount')
  int trackCount;

  @JsonKey(name: 'specialType')
  int specialType;

  @JsonKey(name: 'privacy')
  int privacy;

  @JsonKey(name: 'trackUpdateTime')
  int trackUpdateTime;

  @JsonKey(name: 'playCount')
  int playCount;

  @JsonKey(name: 'trackNumberUpdateTime')
  int trackNumberUpdateTime;

  @JsonKey(name: 'subscribedCount')
  int subscribedCount;

  @JsonKey(name: 'cloudTrackCount')
  int cloudTrackCount;

  @JsonKey(name: 'ordered')
  bool ordered;

  @JsonKey(name: 'description')
  String? description;

  @JsonKey(name: 'updateFrequency')
  String? updateFrequency;

  @JsonKey(name: 'titleImageUrl')
  String? titleImageUrl;

  @JsonKey(name: 'backgroundCoverUrl')
  String? backgroundCoverUrl;

  @JsonKey(name: 'tags')
  List<dynamic> tags;

  @JsonKey(name: 'backgroundCoverId')
  int backgroundCoverId;

  @JsonKey(name: 'subscribers')
  List<UserInfo> subscribers;

  @JsonKey(name: 'creator')
  UserInfo creator;

  @JsonKey(name: 'tracks')
  List<Song> tracks;

  @JsonKey(name: 'trackIds')
  List<TrackIds> trackIds;

  @JsonKey(name: 'shareCount')
  int shareCount;

  @JsonKey(name: 'commentCount')
  int commentCount;

  @JsonKey(name: 'officialPlaylistType')
  String? officialPlaylistType;

  Playlist(
    this.id,
    this.name,
    this.coverImgUrl,
    this.createTime,
    this.status,
    this.opRecommend,
    this.highQuality,
    this.newImported,
    this.updateTime,
    this.trackCount,
    this.specialType,
    this.privacy,
    this.trackUpdateTime,
    this.playCount,
    this.trackNumberUpdateTime,
    this.subscribedCount,
    this.cloudTrackCount,
    this.ordered,
    this.description,
    this.updateFrequency,
    this.backgroundCoverUrl,
    this.titleImageUrl,
    this.tags,
    this.backgroundCoverId,
    this.subscribers,
    this.creator,
    this.tracks,
    this.trackIds,
    this.shareCount,
    this.commentCount,
    this.officialPlaylistType,
  );

  factory Playlist.fromJson(Map<String, dynamic> srcJson) =>
      _$PlaylistFromJson(srcJson);

  Map<String, dynamic> toJson() => _$PlaylistToJson(this);
}

@JsonSerializable()
class TrackIds extends Object {
  @JsonKey(name: 'id')
  int id;

  TrackIds(
    this.id,
  );

  factory TrackIds.fromJson(Map<String, dynamic> srcJson) =>
      _$TrackIdsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$TrackIdsToJson(this);
}
