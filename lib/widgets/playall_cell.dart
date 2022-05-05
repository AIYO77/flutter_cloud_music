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
  String title;
  bool needBgColor;
  VoidCallback? playAllTap;

  PlayAllCell(
      {Key? key,
      this.playCount,
      this.actions,
      this.title = '播放全部',
      this.playAllTap,
      this.needBgColor = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: needBgColor ? Get.theme.cardColor : null,
      child: Row(
        children: [Expanded(child: _buildPlayAll()), _buildActions()],
      ),
    );
  }

  Widget _buildPlayAll() {
    return Material(
      color: Get.theme.cardColor,
      child: InkWell(
        onTap: () {
          playAllTap?.call();
        },
        child: Container(
          height: preferredSize.height,
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
                  text:
                      TextSpan(text: title, style: headlineStyle(), children: [
                WidgetSpan(child: Gaps.hGap5),
                if (playCount != null)
                  TextSpan(
                      text: '($playCount)',
                      style: TextStyle(
                          fontSize: Dimens.font_sp12,
                          color: Colours.color_150.withOpacity(0.8)))
              ])),
            ],
          ),
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
