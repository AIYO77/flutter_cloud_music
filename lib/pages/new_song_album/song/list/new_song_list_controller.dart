import 'package:flutter_cloud_music/api/muisc_api.dart';
import 'package:flutter_cloud_music/common/model/song_model.dart';
import 'package:get/get.dart';

class NewSongListController extends GetxController {
  final int typeId;

  NewSongListController({required this.typeId});

  final items = Rx<List<Song>?>(null);

  @override
  void onReady() {
    super.onReady();
    requestSongs();
  }

  Future<void> requestSongs() async {
    //推荐歌单
    if (typeId == -1) {
      MusicApi.getRecmNewSongs().then((value) => items.value = value);
    } else {
      //新歌速递
      MusicApi.getNewSongFromTag(typeId).then((value) => items.value = value);
    }
  }
}
