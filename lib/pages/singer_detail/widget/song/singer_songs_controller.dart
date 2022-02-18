import 'package:flutter_cloud_music/api/muisc_api.dart';
import 'package:flutter_cloud_music/common/model/song_model.dart';
import 'package:get/get.dart';

/// Creator: Xing Wei
/// Date: 2022/2/12 5:47 下午
/// Des:

class SingerSongsController extends GetxController {
  final int id;

  SingerSongsController(this.id);

  final songs = Rx<List<Song>?>(null);

  //排序方式
  final order = 'hot'.obs; // hot ，time

  @override
  void onInit() {
    super.onInit();
    order.listen((p0) {
      //排序方式改变
      _getSongs();
    });
  }

  @override
  void onReady() {
    super.onReady();
    _getSongs();
  }

  ///获取歌手歌曲
  void _getSongs() {
    songs.value = null;
    MusicApi.getArtistSongs(artistId: id, order: order.value).then((value) {
      songs.value = value;
    });
  }
}
