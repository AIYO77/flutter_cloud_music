import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_cloud_music/common/res/colors.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/res/gaps.dart';
import 'package:flutter_cloud_music/common/utils/adapt.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';
import 'package:flutter_cloud_music/pages/found/model/creative_model.dart';
import 'package:flutter_cloud_music/pages/found/model/found_model.dart';
import 'package:flutter_cloud_music/pages/found/model/found_music_calendar_model.dart';
import 'package:flutter_cloud_music/pages/found/widget/element_title_widget.dart';
import 'package:get/get.dart';

class FoundMusicCalendar extends StatelessWidget {
  final Blocks blocks;

  final double itemHeight;

  const FoundMusicCalendar({required this.blocks, required this.itemHeight});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: itemHeight,
      decoration: BoxDecoration(
        color: Get.theme.cardColor,
        borderRadius: BorderRadius.all(
          Radius.circular(Dimens.gap_dp10),
        ),
      ),
      child: Column(
        children: [
          ElementTitleWidget(elementModel: blocks.uiElement!),
          Gaps.line,
          _createItem(blocks.creatives, 0),
          _createItem(blocks.creatives, 1),
        ],
      ),
    );
  }

  Widget _createItem(List<CreativeModel>? creatives, int index) {
    if (GetUtils.isNullOrBlank(creatives) == true) return Gaps.empty;
    if (index <= creatives!.length - 1) {
      return Container(
        padding: EdgeInsets.only(left: Dimens.gap_dp15, right: Dimens.gap_dp15),
        child: Column(
          children: [
            if (index > 0) Gaps.line,
            _buildItem(creatives.elementAt(index).resources!.elementAt(0))
          ],
        ),
      );
    }
    return Gaps.empty;
  }

  Widget _buildItem(Resources resource) {
    final calendar = FoundMusicCalendarModel.fromJson(resource.resourceExtInfo);
    return SizedBox(
      height: Adapt.px(66),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichText(
                  text: TextSpan(
                      text: DateUtils.isSameDay(
                              DateTime.now(),
                              DateTime.fromMillisecondsSinceEpoch(
                                  calendar.startTime))
                          ? '今天'
                          : '明天',
                      style: TextStyle(
                          fontSize: Dimens.font_sp12,
                          color: const Color.fromARGB(255, 166, 166, 166)),
                      children: _buildTags(calendar.tags)),
                ),
                Gaps.vGap5,
                Text(
                  resource.uiElement.mainTitle?.title ?? "",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: headline1Style(),
                )
              ],
            ),
          ),
          SizedBox(
            width: Adapt.px(54),
            child: Visibility(
              visible: calendar.canSubscribe,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: Dimens.gap_dp25,
                    height: Dimens.gap_dp25,
                    padding: EdgeInsets.all(Adapt.px(1)),
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.all(Radius.circular(Adapt.px(13))),
                        // color: Colours.app_main,
                        border: Border.all(color: Colours.diver_color)),
                    child: Image.asset(
                      ImageUtils.getImagePath('bell'),
                      color: Get.isDarkMode
                          ? Colours.card_color.withOpacity(0.7)
                          : Colours.dark_card_color.withOpacity(0.7),
                    ),
                  ),
                  Gaps.vGap2,
                  Text(
                    calendar.subCount.toString(),
                    style: TextStyle(
                        fontSize: Dimens.font_sp10,
                        color: const Color.fromARGB(255, 166, 166, 166)),
                  )
                ],
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (resource.resourceType == 'ALBUM')
                Image.asset(
                  ImageUtils.getImagePath('cqb'),
                  height: Adapt.px(4.5),
                  fit: BoxFit.fill,
                ),
              CachedNetworkImage(
                imageUrl: ImageUtils.getImageUrlFromSize(
                    resource.uiElement.image?.imageUrl,
                    Size(Adapt.px(49), Adapt.px(49))),
                imageBuilder: (context, provider) {
                  return ClipRRect(
                    borderRadius:
                        BorderRadius.all(Radius.circular(Dimens.gap_dp8)),
                    child: Image(
                      image: provider,
                      height: Dimens.gap_dp49,
                      width: Dimens.gap_dp49,
                    ),
                  );
                },
              )
            ],
          )
        ],
      ),
    );
  }

  List<InlineSpan>? _buildTags(List<String>? tags) {
    if (tags == null) return null;
    final List<InlineSpan> spans = List.empty(growable: true);

    for (final element in tags) {
      spans.add(WidgetSpan(child: Gaps.hGap4));
      spans.add(WidgetSpan(
          child: Container(
              height: Adapt.px(13),
              padding: EdgeInsets.only(left: Adapt.px(4), right: Adapt.px(4)),
              decoration: BoxDecoration(
                  color: Get.isDarkMode
                      ? Colors.white30
                      : const Color.fromARGB(255, 253, 246, 226),
                  borderRadius: BorderRadius.all(Radius.circular(Adapt.px(2)))),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Text(
                    element,
                    style: TextStyle(
                        fontSize: Adapt.px(9),
                        color: Get.isDarkMode
                            ? Colours.white
                            : const Color.fromARGB(255, 236, 192, 100)),
                  ),
                ],
              ))));
    }

    return spans;
  }
}
