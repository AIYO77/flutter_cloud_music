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
import 'package:fluttertoast/fluttertoast.dart';
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
                    Fluttertoast.showToast(msg: '收藏');
                  }
                },
                child: _buildItem(
                    'edr',
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
                  Fluttertoast.showToast(msg: '去评论');
                },
                child: _buildItem(
                    'ed9',
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
                  Fluttertoast.showToast(msg: '分享');
                },
                child: _buildItem(
                    'enm',
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
    final imgSize = iconName == 'enm'
        ? Dimens.gap_dp20
        : iconName == 'ed9'
            ? Dimens.gap_dp32
            : Dimens.gap_dp32;
    final gap = iconName == 'enm'
        ? Gaps.hGap5
        : iconName == 'ed9'
            ? Gaps.hGap1
            : Gaps.hGap3;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          ImageUtils.getImagePath(iconName),
          width: imgSize,
          height: imgSize,
          colorBlendMode: BlendMode.srcIn,
          color: canClicked ? fColor : fColor.withOpacity(0.5),
        ),
        gap,
        Text(
          name,
          style: TextStyle(
              color: canClicked ? fColor : fColor.withOpacity(0.2),
              fontSize: Dimens.font_sp12),
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
