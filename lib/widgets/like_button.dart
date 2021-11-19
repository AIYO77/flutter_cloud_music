import 'package:async/async.dart';

import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/api/muisc_api.dart';
import 'package:flutter_cloud_music/common/model/song_model.dart';
import 'package:flutter_cloud_music/common/player/player_service.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';
import 'package:flutter_cloud_music/common/player/player.dart';
import 'package:flutter_cloud_music/services/auth_service.dart';
import 'package:get/get.dart';

class LikeButton extends StatelessWidget {
  LikeButton({Key? key, this.song}) : super(key: key);

  final Song? song;

  final controller = Get.put(FavoriteController());

  @override
  Widget build(BuildContext context) {
    return Image.asset(ImageUtils.getImagePath('sati_favorite'));
  }
}

class FavoriteController extends GetxController {
  Song? _song;
  //加载喜欢的音乐列表
  CancelableOperation? _favoritesLoader;

  final isFavorite = false.obs;
  @override
  void onInit() {
    PlayerService.to.player.addListener(() {
      _updateFavoriteState(PlayerService.to.player.value.current);
    });
    _song = PlayerService.to.player.value.current;
    super.onInit();
  }

  @override
  void onReady() {
    _updateFavoriteState(_song);
    super.onReady();
  }

  void _updateFavoriteState(Song? song) {
    if (_song == song) {
      return;
    }
    _song = song;
    _favoritesLoader?.cancel();
    if (song == null) {
      isFavorite.value = false;
      return;
    }
    _favoritesLoader = CancelableOperation<List<int>?>.fromFuture(
        MusicApi.likedList(null))
      ..then((value) => {isFavorite.value = value?.contains(song.id) == true});
  }
}
