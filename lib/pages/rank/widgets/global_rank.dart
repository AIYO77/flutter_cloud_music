import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/model/rank_item_model.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/res/gaps.dart';
import 'package:flutter_cloud_music/common/utils/adapt.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:flutter_cloud_music/pages/rank/widgets/norm_item.dart';

/// Creator: Xing Wei
/// Email: 654206017@qq.com
/// Date: 2022/5/6 8:27 下午
/// Des:

class GlobalRank extends StatelessWidget {
  final Color bgColor;

  final List<RankItemModel> items;

  const GlobalRank({required this.bgColor, required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: Dimens.gap_dp17),
      padding: EdgeInsets.only(
          top: Dimens.gap_dp20, left: Dimens.gap_dp16, right: Dimens.gap_dp8),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(Dimens.gap_dp12),
          topRight: Radius.circular(Dimens.gap_dp12),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '全球榜',
            style: headlineStyle(),
          ),
          Gaps.vGap8,
          GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: Dimens.gap_dp8,
              mainAxisSpacing: Dimens.gap_dp12,
              childAspectRatio: 107 / 149,
            ),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final model = items.elementAt(index);
              return RankNormItemWidget(
                itemModel: model,
                imageSize: Adapt.px(107),
              );
            },
          )
        ],
      ),
    );
  }
}
