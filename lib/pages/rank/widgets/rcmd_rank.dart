import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/utils/adapt.dart';
import 'package:flutter_cloud_music/pages/rank/logic.dart';
import 'package:flutter_cloud_music/pages/rank/widgets/norm_item.dart';
import 'package:get/get.dart';

import '../../../common/res/dimens.dart';
import '../../../common/res/gaps.dart';
import '../../../common/utils/common_utils.dart';

/// Creator: Xing Wei
/// Email: 654206017@qq.com
/// Date: 2022/5/6 5:18 下午
/// Des:

class RecmRankWidget extends StatelessWidget {
  final controller = GetInstance().find<RankLogic>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: Dimens.gap_dp12),
      margin: EdgeInsets.all(Dimens.gap_dp16),
      decoration: BoxDecoration(
        color: context.theme.cardColor,
        boxShadow: [
          BoxShadow(
              color: context.theme.shadowColor, blurRadius: Dimens.gap_dp10)
        ],
        borderRadius: BorderRadius.circular(Dimens.gap_dp10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '榜单推荐',
            style: headlineStyle(),
          ).paddingOnly(left: Dimens.gap_dp16),
          Gaps.vGap10,
          GridView.builder(
            padding: EdgeInsets.only(
                left: Dimens.gap_dp16,
                right: Dimens.gap_dp6,
                bottom: Dimens.gap_dp14),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: Adapt.px(8),
              childAspectRatio: 97 / 123,
            ),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.rcmdItem().length,
            itemBuilder: (context, index) {
              final model = controller.rcmdItem().elementAt(index);
              return RankNormItemWidget(
                itemModel: model,
                imageSize: Adapt.px(97),
                maxLines: 1,
              );
            },
          )
        ],
      ),
    );
  }
}
