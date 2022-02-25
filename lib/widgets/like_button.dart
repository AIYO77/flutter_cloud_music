import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/api/muisc_api.dart';
import 'package:flutter_cloud_music/common/model/song_model.dart';
import 'package:flutter_cloud_music/common/player/player_service.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';
import 'package:flutter_cloud_music/routes/app_routes.dart';
import 'package:flutter_cloud_music/services/auth_service.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';

class FavoriteButton extends StatelessWidget {
  FavoriteButton({Key? key}) : super(key: key);

  final controller = Get.put(FavoriteController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => LikeButton(
          size: Dimens.gap_dp24,
          isLiked: controller.isFavorite.value,
          likeBuilder: (isLiked) {
            return Image.asset(
              ImageUtils.getImagePath(isLiked ? 'cij' : 'cih'),
              width: Dimens.gap_dp24,
            );
          },
          onTap: onLikeButtonTapped,
        ));
  }

  //是否可以操作 防止连续点击 数据错乱
  bool canOperate = true;
  Future<bool> onLikeButtonTapped(bool isLiked) async {
    if (!AuthService.to.isLoggedInValue) {
      Get.toNamed(Routes.LOGIN);
      return isLiked;
    }
    if (canOperate) {
      canOperate = false;
      final success =
          await MusicApi.like(controller.curSong?.id, like: !isLiked);
      canOperate = true;
      if (success == null) return isLiked;
      return success ? !isLiked : isLiked;
    } else {
      return isLiked;
    }
  }
}

class FavoriteController extends GetxController {
  Song? curSong;
  //加载喜欢的音乐列表
  CancelableOperation? _favoritesLoader;

  final isFavorite = false.obs;
  @override
  void onInit() {
    PlayerService.to.player.addListener(() {
      _updateFavoriteState(PlayerService.to.curPlay.value);
    });
    // curSong = PlayerService.to.player.value.current;
    super.onInit();
    _updateFavoriteState(PlayerService.to.curPlay.value);
  }

  void _updateFavoriteState(Song? song) {
    if (!AuthService.to.isLoggedInValue) {
      return;
    }
    if (song == null) return;
    if (curSong == song) {
      return;
    }
    curSong = song;
    _favoritesLoader?.cancel();
    isFavorite.value = false;
    _favoritesLoader = CancelableOperation<List<int>?>.fromFuture(
        MusicApi.likedList())
      ..then((value) => {isFavorite.value = value?.contains(song.id) == true});
  }
}
