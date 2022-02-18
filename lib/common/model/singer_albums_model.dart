import 'package:json_annotation/json_annotation.dart';

part 'singer_albums_model.g.dart';

@JsonSerializable()
class SingerAlbumsModel extends Object {
  @JsonKey(name: 'hotAlbums')
  List<HotAlbums> hotAlbums;

  @JsonKey(name: 'more')
  bool more;

  SingerAlbumsModel(
    this.hotAlbums,
    this.more,
  );

  factory SingerAlbumsModel.fromJson(Map<String, dynamic> srcJson) =>
      _$SingerAlbumsModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SingerAlbumsModelToJson(this);
}

@JsonSerializable()
class HotAlbums extends Object {
  @JsonKey(name: 'publishTime')
  int publishTime;

  @JsonKey(name: 'picUrl')
  String picUrl;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'size')
  int size;

  HotAlbums(
    this.publishTime,
    this.picUrl,
    this.name,
    this.id,
    this.size,
  );

  factory HotAlbums.fromJson(Map<String, dynamic> srcJson) =>
      _$HotAlbumsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$HotAlbumsToJson(this);
}
