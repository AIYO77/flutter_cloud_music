import 'dart:math';

import 'package:flutter_cloud_music/common/model/privilege_model.dart';
import 'package:flutter_cloud_music/common/model/song_model.dart';
import 'package:flutter_cloud_music/common/model/user_info_model.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:get/get.dart';
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

  @override
  String toString() {
    return toJson().toString();
  }
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

  @JsonKey(name: 'englishTitle')
  String? englishTitle;

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

  @JsonKey(name: 'subscribed')
  bool? subscribed;

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
    this.englishTitle,
    this.tags,
    this.backgroundCoverId,
    this.subscribers,
    this.creator,
    this.tracks,
    this.trackIds,
    this.shareCount,
    this.commentCount,
    this.officialPlaylistType,
    this.subscribed,
  );

  factory Playlist.fromJson(Map<String, dynamic> srcJson) =>
      _$PlaylistFromJson(srcJson);

  Map<String, dynamic> toJson() => _$PlaylistToJson(this);

  //最优解是裁掉四周的空白
  double getTitleImgFactor() {
    double factor = 1.0;

    if (englishTitle == null) return factor;
    if (englishTitle!.contains('Radar')) {
      factor = 0.56;
    } else if (englishTitle!.contains('Chinese')) {
      factor = 0.86;
    } else {
      final indexOf = name.indexOf(' ');
      final title = name.substring(0, indexOf);
      if (isChinese(title)) {
        final titleLength = title.length - 2;
        Get.log(titleLength.toString());
        factor = titleLength / 10 + 0.24;
      }
    }
    return min(1.0, factor);
  }

  @override
  String toString() {
    // TODO: implement toString
    return toJson().toString();
  }
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
