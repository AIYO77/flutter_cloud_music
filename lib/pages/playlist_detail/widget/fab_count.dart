/*
 * @Author: XingWei 
 * @Date: 2021-09-08 11:35:19 
 * @Last Modified by: XingWei
 * @Last Modified time: 2021-09-08 15:13:02
 */
import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/res/colors.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/res/gaps.dart';
import 'package:flutter_cloud_music/common/utils/adapt.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';
import 'package:flutter_cloud_music/pages/comment_detail/view.dart';
import 'package:get/get.dart';

import '../playlist_detail_controller.dart';

class PlaylistFabCount extends StatelessWidget implements PreferredSizeWidget {
  final controller = Get.find<PlaylistDetailController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Dimens.gap_dp44,
      padding: EdgeInsets.only(left: Dimens.gap_dp5, right: Dimens.gap_dp5),
      decoration: BoxDecoration(
          boxShadow: Get.isDarkMode
              ? null
              : [
                  BoxShadow(
                      color: Get.theme.shadowColor,
                      offset: const Offset(0, 5),
                      blurRadius: 8.0)
                ],
          borderRadius: BorderRadius.all(Radius.circular(Dimens.gap_dp22)),
          color: Get.isDarkMode ? Colors.grey.shade900 : null,
          gradient: Get.isDarkMode
              ? null
              : LinearGradient(
                  colors: [Colours.white.withOpacity(0.9), Colours.white],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)),
      child: Obx(() => Row(
            children: [
              Expanded(
                  child: GestureDetector(
                onTap: () {
                  if (controller.detail.value != null) {
                    toast('收藏');
                  }
                },
                child: _buildItem(
                    'btn_add',
                    controller.detail.value == null
                        ? '收藏'
                        : getPlayCountStrFromInt(
                            controller.detail.value!.playlist.subscribedCount),
                    controller.detail.value != null),
              )),
              _line(),
              Expanded(
                  child: GestureDetector(
                onTap: () {
                  CommentDetailPage.startPlayList(
                      controller.detail.value!.playlist);
                },
                child: _buildItem(
                    'detail_icn_cmt',
                    controller.detail.value == null
                        ? '评论'
                        : getPlayCountStrFromInt(
                            controller.detail.value!.playlist.commentCount),
                    true),
              )),
              _line(),
              Expanded(
                  child: GestureDetector(
                onTap: () {
                  toast('分享');
                },
                child: _buildItem(
                    'icn_share',
                    controller.detail.value == null
                        ? '分享'
                        : getPlayCountStrFromInt(
                            controller.detail.value!.playlist.shareCount),
                    controller.detail.value != null),
              )),
            ],
          )),
    );
  }

  Widget _buildItem(String iconName, String name, bool canClicked) {
    final fColor = Get.isDarkMode ? Colours.color_109 : Colours.headline4_color;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          ImageUtils.getImagePath(iconName),
          width: Dimens.gap_dp20,
          height: Dimens.gap_dp20,
          colorBlendMode: BlendMode.srcIn,
          color: canClicked ? fColor : fColor.withOpacity(0.5),
        ),
        Gaps.hGap5,
        Text(
          name,
          style: TextStyle(
              color: canClicked ? fColor : fColor.withOpacity(0.2),
              fontSize: Dimens.font_sp13),
        )
      ],
    );
  }

  Widget _line() {
    return Container(
        width: 1,
        height: Dimens.gap_dp20,
        color: Get.isDarkMode ? Colors.white38 : Colours.label_bg);
  }

  @override
  Size get preferredSize =>
      Size(Adapt.screenW() - Adapt.px(100), Dimens.gap_dp44);
}
