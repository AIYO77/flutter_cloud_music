import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/res/gaps.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';
import 'package:flutter_cloud_music/pages/singer_detail/logic.dart';
import 'package:flutter_cloud_music/widgets/follow/follow_widget.dart';
import 'package:get/get.dart';

class SingerAppbar extends StatelessWidget implements PreferredSizeWidget {
  final SingerDetailLogic controller;

  const SingerAppbar(this.controller);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        children: [
          //back
          IconButton(
            onPressed: () async {
              FocusManager.instance.primaryFocus?.unfocus();
              Get.back();
            },
            padding: EdgeInsets.only(left: Dimens.gap_dp6),
            icon: Image.asset(
              ImageUtils.getImagePath('dij'),
              color: controller.state.isPinned.value
                  ? Get.theme.appBarTheme.titleTextStyle?.color
                  : Colors.white,
              width: Dimens.gap_dp25,
              height: Dimens.gap_dp25,
            ),
          ),
          //title
          if (controller.state.isPinned.value)
            Text(
              controller.state.getName(),
              style: Get.theme.appBarTheme.titleTextStyle,
            ),
          const Expanded(child: Gaps.empty),
          //follow
          if (controller.state.isPinned.value)
            SizedBox(
              height: Dimens.gap_dp26,
              width: Dimens.gap_dp60,
              child: FollowWidget(Key(controller.state.getUserId().toString()),
                  id: controller.state.getUserId().toString(),
                  isSolidWidget: true,
                  isSinger: controller.state.isSinger(),
                  isFollowed: controller.state.isFollow()),
            ),
          Gaps.hGap16
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(Dimens.gap_dp44);
}
