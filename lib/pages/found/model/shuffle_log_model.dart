import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../common/res/colors.dart';
import '../../../common/res/dimens.dart';
import '../../../common/utils/common_utils.dart';

part 'shuffle_log_model.g.dart';

@JsonSerializable()
class ShuffleLogModel extends Object {
  @JsonKey(name: 'id')
  String id;

  @JsonKey(name: 'type')
  int type;

  @JsonKey(name: 'mlogBaseDataType')
  int mlogBaseDataType;

  @JsonKey(name: 'sameCity')
  bool sameCity;

  @JsonKey(name: 'resource')
  MLogResource resource;

  ShuffleLogModel(
    this.id,
    this.type,
    this.mlogBaseDataType,
    this.sameCity,
    this.resource,
  );

  factory ShuffleLogModel.fromJson(Map<String, dynamic> srcJson) =>
      _$ShuffleLogModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ShuffleLogModelToJson(this);
}

@JsonSerializable()
class MLogResource extends Object {
  @JsonKey(name: 'mlogBaseData')
  MlogBaseData mlogBaseData;

  @JsonKey(name: 'mlogExtVO')
  MlogExtVO mlogExtVO;

  @JsonKey(name: 'shareUrl')
  String shareUrl;

  @JsonKey(name: 'userProfile')
  VideoUserProfile? userProfile;

  MLogResource(
    this.mlogBaseData,
    this.mlogExtVO,
    this.shareUrl,
    this.userProfile,
  );

  factory MLogResource.fromJson(Map<String, dynamic> srcJson) =>
      _$MLogResourceFromJson(srcJson);

  Map<String, dynamic> toJson() => _$MLogResourceToJson(this);
}

@JsonSerializable()
class MlogBaseData extends Object {
  @JsonKey(name: 'id')
  String id;

  @JsonKey(name: 'type')
  int type;

  @JsonKey(name: 'text')
  String text;

  @JsonKey(name: 'desc')
  String? desc;

  @JsonKey(name: 'coverUrl')
  String coverUrl;

  @JsonKey(name: 'duration')
  int duration;

  @JsonKey(name: 'pubTime')
  int pubTime;

  MlogBaseData(
    this.id,
    this.type,
    this.text,
    this.desc,
    this.coverUrl,
    this.duration,
    this.pubTime,
  );

  factory MlogBaseData.fromJson(Map<String, dynamic> srcJson) =>
      _$MlogBaseDataFromJson(srcJson);

  Map<String, dynamic> toJson() => _$MlogBaseDataToJson(this);
}

@JsonSerializable()
class MlogExtVO extends Object {
  @JsonKey(name: 'likedCount')
  int likedCount;

  @JsonKey(name: 'commentCount')
  int commentCount;

  @JsonKey(name: 'playCount')
  int? playCount;

  @JsonKey(name: 'canCollect')
  bool canCollect;

  @JsonKey(name: 'song')
  VideoSong? song;

  MlogExtVO(
    this.likedCount,
    this.commentCount,
    this.playCount,
    this.canCollect,
    this.song,
  );

  factory MlogExtVO.fromJson(Map<String, dynamic> srcJson) =>
      _$MlogExtVOFromJson(srcJson);

  Map<String, dynamic> toJson() => _$MlogExtVOToJson(this);
}

@JsonSerializable()
class VideoSong extends Object {
  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'artists')
  List<VideoSongArtists> artists;

  @JsonKey(name: 'albumName')
  String albumName;

  VideoSong(
    this.id,
    this.name,
    this.artists,
    this.albumName,
  );

  factory VideoSong.fromJson(Map<String, dynamic> srcJson) =>
      _$VideoSongFromJson(srcJson);

  Map<String, dynamic> toJson() => _$VideoSongToJson(this);

  String getArString() {
    return '$name  - ${artists.map((e) => e.artistName).join('/')}';
  }
}

@JsonSerializable()
class VideoSongArtists extends Object {
  @JsonKey(name: 'artistId')
  int artistId;

  @JsonKey(name: 'artistName')
  String artistName;

  VideoSongArtists(
    this.artistId,
    this.artistName,
  );

  factory VideoSongArtists.fromJson(Map<String, dynamic> srcJson) =>
      _$VideoSongArtistsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$VideoSongArtistsToJson(this);
}

@JsonSerializable()
class VideoUserProfile extends Object {
  @JsonKey(name: 'userId')
  int userId;

  @JsonKey(name: 'nickname')
  String nickname;

  @JsonKey(name: 'avatarUrl')
  String avatarUrl;

  @JsonKey(name: 'followed')
  bool followed;

  VideoUserProfile(
    this.userId,
    this.nickname,
    this.avatarUrl,
    this.followed,
  );

  factory VideoUserProfile.fromJson(Map<String, dynamic> srcJson) =>
      _$VideoUserProfileFromJson(srcJson);

  Map<String, dynamic> toJson() => _$VideoUserProfileToJson(this);
}

extension MlogBaseDataExt on MlogBaseData {
  Widget buildNameView({int maxLine = 2}) {
    return RichText(
      text: TextSpan(children: [
        if (type == 3)
          WidgetSpan(
              alignment: PlaceholderAlignment.middle,
              child: Container(
                width: Dimens.gap_dp20,
                height: Dimens.gap_dp13,
                margin: EdgeInsets.only(right: Dimens.gap_dp3),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Colours.app_main_light.withOpacity(0.4),
                        width: Dimens.gap_dp1),
                    borderRadius:
                        BorderRadius.all(Radius.circular(Dimens.gap_dp2))),
                child: Text(
                  'MV',
                  style: TextStyle(
                      color: Colours.app_main_light,
                      fontSize: Dimens.font_sp9,
                      fontWeight: FontWeight.w500),
                ),
              )),
        TextSpan(
            text: text,
            style: body2Style().copyWith(fontWeight: FontWeight.normal))
      ]),
      maxLines: maxLine,
      overflow: TextOverflow.ellipsis,
    );
  }
}
