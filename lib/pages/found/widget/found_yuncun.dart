import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/res/gaps.dart';
import 'package:flutter_cloud_music/common/utils/adapt.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:flutter_cloud_music/pages/found/model/creative_model.dart';
import 'package:flutter_cloud_music/pages/found/model/found_model.dart';
import 'package:flutter_cloud_music/routes/routes_utils.dart';
import 'package:flutter_cloud_music/widgets/custom_tap.dart';
import 'package:get/get.dart';

import '../../../common/res/dimens.dart';
import 'element_title_widget.dart';

/// Creator: Xing Wei
/// Email: 654206017@qq.com
/// Date: 2022/4/22 7:24 下午
/// Des:

class FoundYunProduced extends StatelessWidget {
  final Blocks blocks;

  final double itemHeight;

  const FoundYunProduced({required this.blocks, required this.itemHeight});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: itemHeight,
      decoration: BoxDecoration(
        color: context.theme.cardColor,
        borderRadius: BorderRadius.all(Radius.circular(Dimens.gap_dp10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ElementTitleWidget(elementModel: blocks.uiElement!),
          Gaps.vGap6,
          Expanded(
            child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: Dimens.gap_dp16),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final creative = blocks.creatives!.elementAt(index);
                  return _item(creative);
                },
                separatorBuilder: (context, index) {
                  return Gaps.hGap10;
                },
                itemCount: blocks.creatives?.length ?? 0),
          )
        ],
      ),
    );
  }

  Widget _item(CreativeModel creative) {
    return Bounce(
      onPressed: () {
        RouteUtils.routeFromActionStr(creative.action);
      },
      child: SizedBox(
          width: Adapt.px(161),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(Dimens.gap_dp10),
                child: CachedNetworkImage(
                  imageUrl: creative.uiElement?.image?.imageUrl ?? '',
                  width: Adapt.px(161),
                  height: Adapt.px(97),
                  fit: BoxFit.cover,
                  placeholder: placeholderWidget,
                  errorWidget: errorWidget,
                ),
              ),
              Gaps.vGap10,
              Text(
                creative.uiElement?.mainTitle?.title ?? '',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: body1Style(),
              )
            ],
          )),
    );
  }
}
