import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/api/muisc_api.dart';
import 'package:flutter_cloud_music/common/model/song_model.dart';
import 'package:flutter_cloud_music/common/player/player.dart';
import 'package:flutter_cloud_music/common/player/player_service.dart';
import 'package:flutter_cloud_music/common/res/colors.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';
import 'package:get/get.dart';

class CommentButton extends StatelessWidget {
  CommentButton({Key? key}) : super(key: key);

  final controller = Get.put(CommentController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.commentCount.value > 0
        ? Stack(
            children: [
              Image.asset(
                ImageUtils.getImagePath('cmt_number'),
                width: Dimens.gap_dp22,
                color: Colours.color_217,
              ),
              Container(
                height: Dimens.gap_dp24,
                padding: EdgeInsets.only(left: Dimens.gap_dp16),
                alignment: Alignment.topRight,
                child: Text(
                  getCommentStrFromInt(controller.commentCount.value),
                  style: TextStyle(
                      color: Colours.color_217, fontSize: Dimens.font_sp9),
                ),
              )
            ],
          )
        : Image.asset(
            ImageUtils.getImagePath('detail_icn_cmt'),
            width: Dimens.gap_dp24,
            color: Colours.color_217,
          ));
  }
}

class CommentController extends GetxController {
  Song? curSong;
  //加载歌曲评论数量
  CancelableOperation? _commentLoader;

  final commentCount = 0.obs;
  @override
  void onInit() {
    PlayerService.to.player.addListener(() {
      _updateCommentState(PlayerService.to.player.value.current);
    });
    // curSong = PlayerService.to.player.value.current;
    super.onInit();
    _updateCommentState(PlayerService.to.player.value.current);
  }

  void _updateCommentState(Song? song) {
    if (curSong == song || song == null) {
      return;
    }
    curSong = song;
    _commentLoader?.cancel();
    commentCount.value = 0;
    _commentLoader = CancelableOperation<int>.fromFuture(
        MusicApi.getMusicCommentCouunt(curSong!.id))
      ..then((value) => {commentCount.value = value});
  }
}
