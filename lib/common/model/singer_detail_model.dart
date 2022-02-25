import 'package:flutter_cloud_music/common/model/user_detail_model.dart';
import 'package:flutter_cloud_music/common/model/user_info_model.dart';
import 'package:flutter_cloud_music/pages/singer_detail/state.dart';
import 'package:json_annotation/json_annotation.dart';

part 'singer_detail_model.g.dart';

@JsonSerializable()
class SingerDetailModel extends Object {
  @JsonKey(name: 'videoCount')
  int videoCount;

  @JsonKey(name: 'identify')
  Identify? identify;

  @JsonKey(name: 'artist')
  Artist artist;

  @JsonKey(name: 'eventCount')
  int? eventCount;

  @JsonKey(name: 'user')
  UserInfo? user;

  @JsonKey(name: 'secondaryExpertIdentiy')
  List<SecondaryExpertIdentiy>? secondaryExpertIdentiy;

  UserDetailModel? userDetailModel;

  SingerDetailModel(
    this.videoCount,
    this.identify,
    this.artist,
    this.eventCount,
    this.user,
    this.secondaryExpertIdentiy,
  );

  factory SingerDetailModel.fromJson(Map<String, dynamic> srcJson) =>
      _$SingerDetailModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SingerDetailModelToJson(this);

  String getBgImageUrl() {
    return user?.backgroundUrl ?? artist.cover;
  }

  SingerOrUserDetail? _detail;

  SingerOrUserDetail get detail {
    _detail ??= SingerOrUserDetail(true, this, userDetailModel);
    return _detail!;
  }
}

@JsonSerializable()
class Identify extends Object {
  @JsonKey(name: 'imageUrl')
  String? imageUrl;

  @JsonKey(name: 'imageDesc')
  String? imageDesc;

  @JsonKey(name: 'actionUrl')
  String? actionUrl;

  Identify(
    this.imageUrl,
    this.imageDesc,
    this.actionUrl,
  );

  factory Identify.fromJson(Map<String, dynamic> srcJson) =>
      _$IdentifyFromJson(srcJson);

  Map<String, dynamic> toJson() => _$IdentifyToJson(this);
}

@JsonSerializable()
class Artist extends Object {
  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'cover')
  String cover;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'briefDesc')
  String briefDesc;

  @JsonKey(name: 'albumSize')
  int albumSize;

  @JsonKey(name: 'musicSize')
  int musicSize;

  @JsonKey(name: 'mvSize')
  int mvSize;

  @JsonKey(name: 'followed')
  bool? followed;

  Artist(
    this.id,
    this.cover,
    this.name,
    this.briefDesc,
    this.albumSize,
    this.musicSize,
    this.mvSize,
    this.followed,
  );

  factory Artist.fromJson(Map<String, dynamic> srcJson) =>
      _$ArtistFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ArtistToJson(this);
}

@JsonSerializable()
class SecondaryExpertIdentiy extends Object {
  @JsonKey(name: 'expertIdentiyName')
  String name;

  SecondaryExpertIdentiy(this.name);

  factory SecondaryExpertIdentiy.fromJson(Map<String, dynamic> srcJson) =>
      _$SecondaryExpertIdentiyFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SecondaryExpertIdentiyToJson(this);
}
