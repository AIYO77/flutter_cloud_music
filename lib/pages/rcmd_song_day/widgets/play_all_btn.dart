import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_cloud_music/common/res/colors.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/res/gaps.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';
import 'package:flutter_cloud_music/delegate/expaned_sliver_delegate.dart';
import 'package:flutter_cloud_music/widgets/round_checkbox.dart';
import 'package:flutter_cloud_music/widgets/text_button_icon.dart';
import 'package:get/get.dart';

import '../index.dart';

class RecmPlayAll extends GetView<RcmdSongDayController> {
  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: MySliverDelegate(
        maxHeight: Dimens.gap_dp45,
        minHeight: Dimens.gap_dp45,
        child: Obx(
          () => (GetUtils.isNullOrBlank(controller.items()) == true)
              ? Gaps.empty
              : Container(
                  color: Get.theme.cardColor,
                  child: Row(
                    children: [
                      if (controller.showCheck.value)
                        Padding(
                          padding: EdgeInsets.only(left: Dimens.gap_dp10),
                          child: MyTextButtonWithIcon(
                              onPressed: () {
                                if (controller.selectedSong.value?.length !=
                                    controller.items().length) {
                                  //未全选中
                                  controller.selectedSong.value =
                                      List.from(controller.items());
                                } else {
                                  //已全选中
                                  controller.selectedSong.value = null;
                                }
                              },
                              gap: Dimens.gap_dp8,
                              icon: RoundCheckBox(
                                const Key('all'),
                                value: controller.selectedSong.value?.length ==
                                    controller.items().length,
                              ),
                              label: Text(
                                '全选',
                                style: headlineStyle()
                                    .copyWith(fontWeight: FontWeight.normal),
                              )),
                        )
                      else
                        Padding(
                            padding: EdgeInsets.only(left: Dimens.gap_dp8),
                            child: MyTextButtonWithIcon(
                                onPressed: () {
                                  controller.playList(context);
                                },
                                gap: Dimens.gap_dp2,
                                icon: Container(
                                  width: Dimens.gap_dp21,
                                  height: Dimens.gap_dp21,
                                  margin:
                                      EdgeInsets.only(right: Dimens.gap_dp6),
                                  padding:
                                      EdgeInsets.only(left: Dimens.gap_dp2),
                                  decoration: BoxDecoration(
                                    color: Colours.btn_selectd_color,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(Dimens.gap_dp12),
                                    ),
                                  ),
                                  child: Center(
                                    child: Image.asset(
                                      ImageUtils.getImagePath(
                                          'icon_play_small'),
                                      color: Colours.white,
                                      width: Dimens.gap_dp12,
                                      height: Dimens.gap_dp12,
                                    ),
                                  ),
                                ),
                                label: RichText(
                                    text: TextSpan(
                                        text: '播放全部',
                                        style: headlineStyle(),
                                        children: [
                                      WidgetSpan(child: Gaps.hGap5),
                                      TextSpan(
                                          text:
                                              '(共${controller.items().length}首)',
                                          style: TextStyle(
                                              fontSize: Dimens.font_sp12,
                                              color: Colours.color_150
                                                  .withOpacity(0.8)))
                                    ])))),
                      const Expanded(child: Gaps.empty),
                      MyTextButtonWithIcon(
                          onPressed: () {
                            controller.showCheck.value =
                                !controller.showCheck.value;
                          },
                          icon: controller.showCheck.value
                              ? Gaps.empty
                              : Image.asset(
                                  ImageUtils.getImagePath('icn_list_multi'),
                                  color: captionStyle().color,
                                  width: Dimens.gap_dp16,
                                ),
                          label: !controller.showCheck.value
                              ? Text(
                                  '多选',
                                  style: body1Style()
                                      .copyWith(fontSize: Dimens.font_sp15),
                                )
                              : Text(
                                  '完成',
                                  style: TextStyle(
                                      color: Colours.app_main_light,
                                      fontSize: Dimens.font_sp16),
                                )),
                      Gaps.hGap5
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
