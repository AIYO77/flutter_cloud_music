import 'package:json_annotation/json_annotation.dart';

part 'artists_model.g.dart';

@JsonSerializable()
class ArtistsModel extends Object {
  @JsonKey(name: 'artists')
  List<Artists> artists;

  @JsonKey(name: 'more')
  bool more;

  ArtistsModel(
    this.artists,
    this.more,
  );

  factory ArtistsModel.fromJson(Map<String, dynamic> srcJson) =>
      _$ArtistsModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ArtistsModelToJson(this);
}

@JsonSerializable()
class Artists extends Object {
  @JsonKey(name: 'accountId')
  int? accountId;

  @JsonKey(name: 'albumSize')
  int albumSize;

  @JsonKey(name: 'alias')
  List<String> alias;

  @JsonKey(name: 'briefDesc')
  String briefDesc;

  @JsonKey(name: 'followed')
  bool followed;

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'img1v1Url')
  String img1v1Url;

  @JsonKey(name: 'musicSize')
  int musicSize;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'topicPerson')
  int topicPerson;

  @JsonKey(name: 'trans')
  String trans;

  Artists(
    this.accountId,
    this.albumSize,
    this.alias,
    this.briefDesc,
    this.followed,
    this.id,
    this.img1v1Url,
    this.musicSize,
    this.name,
    this.topicPerson,
    this.trans,
  );

  factory Artists.fromJson(Map<String, dynamic> srcJson) =>
      _$ArtistsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ArtistsToJson(this);

  String getArName() {
    if (trans.isNotEmpty) {
      return '$name（$trans）';
    } else if (alias.isNotEmpty) {
      return '$name（${alias.join('/')}）';
    } else {
      return name;
    }
  }

  String? getExtraStr() {
    if (trans.isNotEmpty) {
      return '（$trans）';
    } else if (alias.isNotEmpty) {
      return '（${alias.join('/')}）';
    }
    return null;
  }
}
