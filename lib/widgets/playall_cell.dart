import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/res/colors.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/res/gaps.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class PlayAllCell extends StatelessWidget implements PreferredSizeWidget {
  int? playCount;
  List<Widget>? actions;
  PlayAllCell({Key? key, this.playCount, this.actions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Get.theme.cardColor,
      child: Row(
        children: [Expanded(child: _buildPlayAll()), _buildActions()],
      ),
    );
  }

  Widget _buildPlayAll() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: preferredSize.height,
        // color: Colours.blue,
        padding: EdgeInsets.only(left: Dimens.gap_dp10),
        child: Row(
          children: [
            Container(
              width: Dimens.gap_dp21,
              height: Dimens.gap_dp21,
              padding: EdgeInsets.only(left: Dimens.gap_dp2),
              decoration: BoxDecoration(
                color: Colours.btn_selectd_color,
                borderRadius: BorderRadius.all(
                  Radius.circular(Dimens.gap_dp12),
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
            ),
            Gaps.hGap8,
            RichText(
                text: TextSpan(text: '播放全部', style: headlineStyle(), children: [
              WidgetSpan(child: Gaps.hGap5),
              TextSpan(
                  text: '($playCount)',
                  style: TextStyle(
                      fontSize: Dimens.font_sp12,
                      color: Colours.color_150.withOpacity(0.8)))
            ])),
          ],
        ),
      ),
    );
  }

  Widget _buildActions() {
    if (GetUtils.isNullOrBlank(actions) == true) return Gaps.empty;
    return Row(
      children: actions!,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(Dimens.gap_dp50);
}
