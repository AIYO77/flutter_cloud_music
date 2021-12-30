import 'package:json_annotation/json_annotation.dart'; 
  
part 'album_cover_info.g.dart';


@JsonSerializable()
  class AlbumCoverInfo extends Object {

  @JsonKey(name: 'albumId')
  int albumId;

  @JsonKey(name: 'albumName')
  String albumName;

  @JsonKey(name: 'artistName')
  String artistName;

  @JsonKey(name: 'coverUrl')
  String coverUrl;

  AlbumCoverInfo(this.albumId,this.albumName,this.artistName,this.coverUrl,);

  factory AlbumCoverInfo.fromJson(Map<String, dynamic> srcJson) => _$AlbumCoverInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$AlbumCoverInfoToJson(this);

}

  
