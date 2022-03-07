import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/res/colors.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:get/get.dart';

import '../../../common/res/dimens.dart';
import '../../../common/values/server.dart';
import '../mine_controller.dart';

/// Creator: Xing Wei
/// Email: 654206017@qq.com
/// Date: 2022/3/7 1:44 下午
/// Des:
///
class MineTabView extends StatelessWidget {
  final controller = GetInstance().find<MineController>();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      final box =
          controller.tabKey.currentContext?.findRenderObject() as RenderBox?;
      final offset = box?.localToGlobal(Offset.zero);
      logger.i('offset = ${offset?.dy}');
      controller.originOffset ??= offset?.dy;
    });
    return Obx(() {
      return Container(
          color: controller.isTop.value
              ? context.theme.cardColor
              : Colors.transparent,
          child: TabBar(
            key: controller.tabKey,
            labelPadding: EdgeInsets.zero,
            padding: EdgeInsets.only(top: Dimens.gap_dp4),
            labelColor: body2Style().color,
            labelStyle: body2Style().copyWith(
                fontWeight: FontWeight.w500, fontSize: Dimens.font_sp18),
            unselectedLabelColor: Get.isDarkMode
                ? Colors.white.withOpacity(0.8)
                : Colours.color_114,
            unselectedLabelStyle: TextStyle(
              fontSize: Dimens.font_sp16,
              fontWeight: FontWeight.normal,
            ),
            indicatorSize: TabBarIndicatorSize.label,
            indicatorPadding:
                EdgeInsets.only(bottom: Dimens.gap_dp9, top: Dimens.gap_dp26),
            indicator: BoxDecoration(
                color: Colours.indicator_color,
                borderRadius:
                    BorderRadius.all(Radius.circular(Dimens.gap_dp10))),
            controller: controller.tabController,
            onTap: controller.onTabChange,
            tabs: const [Tab(text: '创建歌单'), Tab(text: '收藏歌单')],
          ));
    });
  }
}
