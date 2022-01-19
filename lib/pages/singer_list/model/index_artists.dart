import 'package:flutter_cloud_music/common/model/artists_model.dart';

class IndexArtists {
  final String index;
  final List<Artists> artists;

  const IndexArtists({required this.index, required this.artists});

  String getIndexName() {
    if (index == '-1') {
      return '热门歌手';
    } else if (index == '0') {
      return '#';
    } else {
      return index.toUpperCase();
    }
  }
}
