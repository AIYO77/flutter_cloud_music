import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/api/muisc_api.dart';
import 'package:flutter_cloud_music/common/player/player.dart';
import 'package:flutter_cloud_music/common/res/colors.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:get/get.dart';

class PlayingFmController extends GetxController {
  Future<void> trashMusic(BuildContext context) async {
    final isSuc = await MusicApi.trashMusic(context.curPlayRx.value?.id);
    if (isSuc) {
      Get.snackbar('', '',
          messageText: Container(
            height: Dimens.gap_dp44,
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: Dimens.gap_dp53),
            decoration: BoxDecoration(
                color: Colors.white70,
                borderRadius:
                    BorderRadius.all(Radius.circular(Dimens.gap_dp22))),
            child: const Text(
              '我们会努力想你推荐你更喜欢的内容',
              style: TextStyle(color: Colours.icon_color),
            ),
          ));
      context.transportControls.skipToNext();
    } else {
      toast('移除失败');
    }
  }
}
