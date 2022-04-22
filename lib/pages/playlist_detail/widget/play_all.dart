import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:get/get.dart';

import '../../../common/res/colors.dart';
import '../../../common/res/gaps.dart';
import '../../../common/utils/common_utils.dart';
import '../../../common/utils/image_utils.dart';
import '../playlist_detail_controller.dart';

/// Creator: Xing Wei
/// Email: 654206017@qq.com
/// Date: 2022/3/9 3:06 下午
/// Des:

class PlDetailPlayAll extends StatelessWidget implements PreferredSizeWidget {
  final PlaylistDetailController controller;

  const PlDetailPlayAll({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.theme.cardColor,
      child: Row(
        children: [Expanded(child: _buildPlayAll(context)), _buildActions()],
      ),
    );
  }

  Widget _buildPlayAll(BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller.playAll(context);
      },
      behavior: HitTestBehavior.translucent,
      child: Container(
        height: preferredSize.height,
        padding: EdgeInsets.only(left: Dimens.gap_dp10),
        child: Row(
          children: [
            Obx(() => Container(
                  width: Dimens.gap_dp21,
                  height: controller.detail.value?.playlist.specialType != 200
                      ? Dimens.gap_dp21
                      : Dimens.gap_dp18,
                  padding: EdgeInsets.only(left: Dimens.gap_dp2),
                  decoration: BoxDecoration(
                    color: Colours.btn_selectd_color,
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                          controller.detail.value?.playlist.specialType != 200
                              ? Dimens.gap_dp12
                              : Dimens.gap_dp7),
                    ),
                  ),
                  child: Center(
                    child: Image.asset(
                      ImageUtils.getImagePath('icon_play_small'),
                      color: Colours.white,
                      width: Dimens.gap_dp12,
                      height: Dimens.gap_dp12,
                    ),
                  ),
                )),
            Gaps.hGap8,
            Obx(
              () => RichText(
                text: TextSpan(
                  text: '播放全部',
                  style: headlineStyle(),
                  children: [
                    WidgetSpan(child: Gaps.hGap5),
                    TextSpan(
                        text: '(${controller.itemSize.value ?? 0})',
                        style: TextStyle(
                            fontSize: Dimens.font_sp12,
                            color: Colours.color_150.withOpacity(0.8)))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActions() {
    return Container();
  }

  @override
  Size get preferredSize => Size.fromHeight(Dimens.gap_dp50);
}
