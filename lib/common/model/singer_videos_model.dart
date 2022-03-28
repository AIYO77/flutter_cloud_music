import 'package:json_annotation/json_annotation.dart';

import '../../pages/found/model/shuffle_log_model.dart';

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
  MLogResource resource;

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
