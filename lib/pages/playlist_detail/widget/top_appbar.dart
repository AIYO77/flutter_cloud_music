import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/res/colors.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';
import 'package:get/get.dart';

import '../playlist_detail_controller.dart';

class PlaylistTopAppbar extends StatelessWidget {
  final controller = Get.find<PlaylistDetailController>();

  final double appBarHeight;

  PlaylistTopAppbar({Key? key, required this.appBarHeight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: context.mediaQueryPadding.top),
      height: appBarHeight,
      child: Stack(
        children: [
          IconButton(
            onPressed: () {
              FocusManager.instance.primaryFocus?.unfocus();
              Get.back();
            },
            padding: EdgeInsets.only(left: Dimens.gap_dp2),
            icon: Image.asset(
              ImageUtils.getImagePath('dij'),
              color: Colours.white.withOpacity(0.9),
              width: Dimens.gap_dp25,
              height: Dimens.gap_dp25,
            ),
          ),
          Center(
            child: Text(
              '歌单',
              style: TextStyle(
                  fontSize: Dimens.font_sp17,
                  fontWeight: FontWeight.w600,
                  color: Colours.white),
            ),
          )
        ],
      ),
    );
  }
}
