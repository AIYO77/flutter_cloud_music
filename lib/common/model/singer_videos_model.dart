import 'package:json_annotation/json_annotation.dart';

part 'singer_videos_model.g.dart';

@JsonSerializable()
class SingerVideosModel extends Object {
  @JsonKey(name: 'records')
  List<Records> records;

  @JsonKey(name: 'page')
  Page page;

  SingerVideosModel(
    this.records,
    this.page,
  );

  factory SingerVideosModel.fromJson(Map<String, dynamic> srcJson) =>
      _$SingerVideosModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SingerVideosModelToJson(this);
}

@JsonSerializable()
class Records extends Object {
  @JsonKey(name: 'id')
  String id;

  @JsonKey(name: 'type')
  int type;

  @JsonKey(name: 'resource')
  Resource resource;

  @JsonKey(name: 'sameCity')
  bool sameCity;

  Records(
    this.id,
    this.type,
    this.resource,
    this.sameCity,
  );

  factory Records.fromJson(Map<String, dynamic> srcJson) =>
      _$RecordsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$RecordsToJson(this);
}

@JsonSerializable()
class Resource extends Object {
  @JsonKey(name: 'mlogBaseData')
  MlogBaseData mlogBaseData;

  @JsonKey(name: 'mlogExtVO')
  MlogExtVO mlogExtVO;

  @JsonKey(name: 'status')
  int status;

  @JsonKey(name: 'shareUrl')
  String shareUrl;

  Resource(
    this.mlogBaseData,
    this.mlogExtVO,
    this.status,
    this.shareUrl,
  );

  factory Resource.fromJson(Map<String, dynamic> srcJson) =>
      _$ResourceFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ResourceToJson(this);
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
  String desc;

  @JsonKey(name: 'pubTime')
  int pubTime;

  @JsonKey(name: 'coverUrl')
  String coverUrl;

  @JsonKey(name: 'greatCover')
  bool greatCover;

  @JsonKey(name: 'coverHeight')
  int coverHeight;

  @JsonKey(name: 'coverWidth')
  int coverWidth;

  @JsonKey(name: 'coverColor')
  int coverColor;

  @JsonKey(name: 'duration')
  int duration;

  MlogBaseData(
    this.id,
    this.type,
    this.text,
    this.desc,
    this.pubTime,
    this.coverUrl,
    this.greatCover,
    this.coverHeight,
    this.coverWidth,
    this.coverColor,
    this.duration,
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
  int playCount;

  @JsonKey(name: 'shareCount')
  int shareCount;

  @JsonKey(name: 'canCollect')
  bool canCollect;

  @JsonKey(name: 'artistName')
  String artistName;

  @JsonKey(name: 'artists')
  List<VideoArtists> artists;

  MlogExtVO(
    this.likedCount,
    this.commentCount,
    this.playCount,
    this.shareCount,
    this.canCollect,
    this.artistName,
    this.artists,
  );

  factory MlogExtVO.fromJson(Map<String, dynamic> srcJson) =>
      _$MlogExtVOFromJson(srcJson);

  Map<String, dynamic> toJson() => _$MlogExtVOToJson(this);
}

@JsonSerializable()
class VideoArtists extends Object {
  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'img1v1Url')
  String img1v1Url;

  @JsonKey(name: 'followed')
  bool followed;

  VideoArtists(
    this.id,
    this.name,
    this.img1v1Url,
    this.followed,
  );

  factory VideoArtists.fromJson(Map<String, dynamic> srcJson) =>
      _$VideoArtistsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$VideoArtistsToJson(this);
}

@JsonSerializable()
class Page extends Object {
  @JsonKey(name: 'size')
  int size;

  @JsonKey(name: 'cursor')
  String cursor;

  @JsonKey(name: 'more')
  bool more;

  Page(
    this.size,
    this.cursor,
    this.more,
  );

  factory Page.fromJson(Map<String, dynamic> srcJson) =>
      _$PageFromJson(srcJson);

  Map<String, dynamic> toJson() => _$PageToJson(this);
}
