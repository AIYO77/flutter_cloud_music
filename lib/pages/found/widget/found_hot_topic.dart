import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/res/gaps.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:flutter_cloud_music/pages/found/model/creative_model.dart';
import 'package:flutter_cloud_music/routes/routes_utils.dart';
import 'package:get/get.dart';

import '../../../common/res/dimens.dart';
import '../model/found_model.dart';
import 'element_title_widget.dart';

/// Creator: Xing Wei
/// Email: 654206017@qq.com
/// Date: 2022/4/22 10:47 上午
/// Des:热门话题

class FoundHotTopic extends StatelessWidget {
  final Blocks blocks;

  final double itemHeight;

  const FoundHotTopic({required this.blocks, required this.itemHeight});

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
          Gaps.vGap12,
          Expanded(
            child: Align(
              alignment: Alignment.topLeft,
              child: PageView.builder(
                controller: PageController(viewportFraction: 0.93),
                itemBuilder: (context, index) {
                  return Column(
                    children: _buildPageItems(
                        blocks.creatives!.elementAt(index).resources!),
                  );
                },
                itemCount: blocks.creatives?.length ?? 0,
              ),
            ),
          )
        ],
      ),
    );
  }

  List<Widget> _buildPageItems(List<Resources> list) {
    final widgets = <Widget>[];
    for (final element in list) {
      widgets.add(
        GestureDetector(
          onTap: () {
            RouteUtils.routeFromActionStr(element.action);
          },
          child: Row(
            children: [
              Gaps.hGap2,
              CachedNetworkImage(
                imageUrl: element.uiElement.mainTitle?.titleImgUrl ?? '',
                width: Dimens.gap_dp14,
                fit: BoxFit.cover,
              ),
              Gaps.hGap5,
              Expanded(
                child: Text.rich(
                  TextSpan(children: [
                    TextSpan(
                        text: element.uiElement.mainTitle?.title,
                        style: headline2Style()
                            .copyWith(fontWeight: FontWeight.normal)),
                    if (GetUtils.isNullOrBlank(element.uiElement.labelUrls)! !=
                        true)
                      WidgetSpan(
                          child: Padding(
                        padding: EdgeInsets.only(left: Dimens.gap_dp5),
                        child: CachedNetworkImage(
                          imageUrl: element.uiElement.labelUrls!.elementAt(0),
                          width: Dimens.gap_dp14,
                          height: Dimens.gap_dp14,
                        ),
                      ))
                  ]),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Gaps.hGap20,
              Text(
                element.uiElement.subTitle?.title ?? '',
                style: captionStyle(),
              ),
              Gaps.hGap12,
            ],
          ),
        ),
      );
      widgets.add(Gaps.vGap20);
    }
    return widgets;
  }
}
