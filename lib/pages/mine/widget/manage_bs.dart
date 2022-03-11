import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/model/mine_playlist.dart';
import '../../../common/res/dimens.dart';
import '../../../common/res/gaps.dart';
import '../../../common/utils/adapt.dart';
import '../../../common/utils/common_utils.dart';
import '../../../common/utils/image_utils.dart';
import '../../../routes/app_routes.dart';
import '../mine_controller.dart';
import 'create_pl_bs.dart';

/// Creator: Xing Wei
/// Email: 654206017@qq.com
/// Date: 2022/3/8 7:38 下午
/// Des:
///

class MinePlBottomSheet extends StatelessWidget {
  final List<MinePlaylist>? list;
  final bool isCreatePl;

  final controller = GetInstance().find<MineController>();

  MinePlBottomSheet({required this.list, required this.isCreatePl});

  static void show(
      BuildContext context, List<MinePlaylist>? list, bool isCreatePl) {
    Get.bottomSheet(
        MinePlBottomSheet(
          list: list,
          isCreatePl: isCreatePl,
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topRight: Radius.circular(Dimens.gap_dp14),
          topLeft: Radius.circular(Dimens.gap_dp14),
        )),
        enableDrag: false,
        backgroundColor: context.theme.cardColor);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: Adapt.bottomPadding()),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.infinity,
            height: Dimens.gap_dp50,
            padding: EdgeInsets.only(left: Dimens.gap_dp15),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                isCreatePl ? '创建歌单' : '收藏歌单',
                style: body1Style(),
              ),
            ),
          ),
          Gaps.line,
          if (isCreatePl)
            GestureDetector(
              onTap: () {
                Get.back();
                afterLogin(() {
                  CreatePlBottomSheet.show(context);
                });
              },
              behavior: HitTestBehavior.translucent,
              child: Container(
                width: double.infinity,
                height: Dimens.gap_dp50,
                padding: EdgeInsets.only(left: Dimens.gap_dp15),
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Image.asset(
                      ImageUtils.getImagePath('icn_newlist'),
                      color: headline2Style().color,
                      width: Dimens.gap_dp26,
                    ),
                    Gaps.hGap10,
                    Text(
                      '新建歌单',
                      style: headline2Style()
                          .copyWith(fontWeight: FontWeight.normal),
                    )
                  ],
                ),
              ),
            ),
          GestureDetector(
            onTap: () async {
              if (GetUtils.isNullOrBlank(list) == true) return;
              Get.back();
              final result =
                  await Get.toNamed(Routes.PL_MANAGE, arguments: list);
              controller.updateOrder(result);
            },
            behavior: HitTestBehavior.translucent,
            child: Opacity(
              opacity: GetUtils.isNullOrBlank(list) == true ? 0.3 : 1.0,
              child: Container(
                width: double.infinity,
                height: Dimens.gap_dp50,
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: Dimens.gap_dp15),
                child: Row(
                  children: [
                    Image.asset(
                      ImageUtils.getImagePath('icn_order_change'),
                      color: headline2Style().color,
                      width: Dimens.gap_dp26,
                    ),
                    Gaps.hGap10,
                    Text(
                      '管理歌单',
                      style: headline2Style()
                          .copyWith(fontWeight: FontWeight.normal),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
