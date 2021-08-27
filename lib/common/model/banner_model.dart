import 'package:flutter_cloud_music/common/model/song_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'banner_model.g.dart';

@JsonSerializable()
class BannerModel extends Object {
  @JsonKey(name: 'banners')
  List<Banner> banner;

  BannerModel(
    this.banner,
  );

  factory BannerModel.fromJson(Map<String, dynamic> srcJson) =>
      _$BannerModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$BannerModelToJson(this);
}

@JsonSerializable()
class Banner extends Object {
  @JsonKey(name: 'bannerId')
  String? bannerId;

  @JsonKey(name: 'pic')
  String? pic;

  @JsonKey(name: 'titleColor')
  String? titleColor;

  @JsonKey(name: 'requestId')
  String? requestId;

  @JsonKey(name: 'exclusive')
  bool exclusive;

  @JsonKey(name: 'scm')
  String? scm;

  @JsonKey(name: 'song')
  Song? song;

  @JsonKey(name: 'targetId')
  int targetId;

  @JsonKey(name: 'showAdTag')
  bool showAdTag;

  @JsonKey(name: 'targetType')
  int targetType;

  @JsonKey(name: 'typeTitle')
  String? typeTitle;

  @JsonKey(name: 'url')
  String? url;

  @JsonKey(name: 'encodeId')
  String? encodeId;

  Banner(
    this.bannerId,
    this.pic,
    this.titleColor,
    this.requestId,
    this.exclusive,
    this.scm,
    this.song,
    this.targetId,
    this.showAdTag,
    this.targetType,
    this.typeTitle,
    this.url,
    this.encodeId,
  );

  factory Banner.fromJson(Map<String, dynamic> srcJson) =>
      _$BannerFromJson(srcJson);

  Map<String, dynamic> toJson() => _$BannerToJson(this);
}
