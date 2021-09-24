import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/res/gaps.dart';
import 'package:flutter_cloud_music/common/utils/adapt.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:flutter_cloud_music/pages/found/model/creative_model.dart';
import 'package:flutter_cloud_music/pages/found/model/found_model.dart';
import 'package:flutter_cloud_music/pages/found/widget/element_title_widget.dart';
import 'package:flutter_cloud_music/routes/routes_utils.dart';
import 'package:flutter_cloud_music/widgets/generral_cover_playcount.dart';
import 'package:get/get.dart';

class FoundSlideVoiceList extends StatelessWidget {
  final Blocks blocks;

  final double itemHeight;

  const FoundSlideVoiceList(this.blocks, {required this.itemHeight});

  Widget _buildItem(CreativeModel model) {
    final coverSize = Size(Dimens.gap_dp105, Dimens.gap_dp105);
    return SizedBox(
      width: coverSize.width,
      child: GestureDetector(
        onTap: () {
          RouteUtils.routeFromActionStr(model.action);
        },
        child: Column(
          children: [
            GenrralCoverPlayCount(
                imageUrl: model.uiElement?.image?.imageUrl ?? "",
                playCount: model.creativeExtInfoVO['playCount'] as int,
                coverSize: coverSize),
            Gaps.vGap5,
            RichText(
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              text: TextSpan(
                style: captionStyle(),
                children: [
                  if (GetUtils.isNullOrBlank(model.algReason) != true)
                    WidgetSpan(
                      child: Container(
                        height: Adapt.px(14),
                        margin:
                            EdgeInsets.only(right: Dimens.gap_dp3, bottom: 1),
                        padding: EdgeInsets.only(
                            left: Dimens.gap_dp2, right: Dimens.gap_dp2),
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.all(Radius.circular(Dimens.gap_dp2)),
                          border: Border.all(
                              color: const Color.fromARGB(255, 224, 224, 224)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              model.algReason!,
                              style: TextStyle(
                                  fontSize: Dimens.font_sp10,
                                  color:
                                      const Color.fromARGB(255, 183, 183, 183)),
                            )
                          ],
                        ),
                      ),
                    ),
                  TextSpan(
                    text: model.uiElement?.mainTitle?.title ?? '',
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: itemHeight,
      decoration: BoxDecoration(
        color: Get.theme.cardColor,
        borderRadius: BorderRadius.all(
          Radius.circular(Dimens.gap_dp6),
        ),
      ),
      child: Column(
        children: [
          ElementTitleWidget(elementModel: blocks.uiElement!),
          Expanded(
              child: ListView.separated(
                  padding: EdgeInsets.only(
                      left: Dimens.gap_dp15, right: Dimens.gap_dp15),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return _buildItem(blocks.creatives!.elementAt(index));
                  },
                  separatorBuilder: (context, index) {
                    return Gaps.hGap9;
                  },
                  itemCount: blocks.creatives?.length ?? 0))
        ],
      ),
    );
  }
}
