import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/api/muisc_api.dart';
import 'package:flutter_cloud_music/common/model/calendar_events.dart';
import 'package:flutter_cloud_music/common/player/player_service.dart';
import 'package:flutter_cloud_music/common/res/colors.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/res/gaps.dart';
import 'package:flutter_cloud_music/common/utils/adapt.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';
import 'package:flutter_cloud_music/pages/music_calendar/content/calender_model.dart';
import 'package:flutter_cloud_music/routes/routes_utils.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:music_player/music_player.dart';

class CalenderItem extends StatefulWidget {
  final CalenderModel model;

  const CalenderItem({Key? key, required this.model}) : super(key: key);

  @override
  _CalenderItemState createState() => _CalenderItemState();
}

class _CalenderItemState extends State<CalenderItem> {
  late bool showPicUp;

  @override
  void initState() {
    super.initState();
    showPicUp = widget.model.showPicUp();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimens.gap_dp15),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(Dimens.gap_dp8)),
        child: Container(
          decoration: BoxDecoration(color: Get.theme.cardColor, boxShadow: [
            BoxShadow(
                color: Get.theme.shadowColor,
                blurRadius: Dimens.gap_dp3,
                offset: Offset(0, Dimens.gap_dp3))
          ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: Dimens.gap_dp16,
                width: double.infinity,
              ),
              _buildItemTimeTip(widget.model.time),
              _buildItemListContent(showPicUp
                  ? widget.model.events.sublist(0, 3)
                  : widget.model.events),
              if (showPicUp) _buildPicUp(widget.model.events.length - 3)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildItemListContent(List<CalendarEvents> events) {
    return ListView.separated(
        shrinkWrap: true,
        padding: const EdgeInsets.only(),
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final item = events.elementAt(index);
          return Material(
            color: Get.theme.cardColor,
            child: InkWell(
              onTap: () async {
                if (item.isSong() &&
                    PlayerService.to.curPlayId.value.toString() !=
                        item.resourceId) {
                  EasyLoading.show(status: '加载中...');
                  final song = await MusicApi.getSongsInfo(item.resourceId);
                  final queue = song?.map((e) => e.metadata).toList();
                  if (queue != null) {
                    PlayerService.to.player.playWithQueue(PlayQueue(
                        queueId: item.id,
                        queueTitle: item.title,
                        queue: queue));
                  }
                  EasyLoading.dismiss();
                }
                RouteUtils.routeFromActionStr(item.targetUrl);
              },
              child: Container(
                height: Dimens.gap_dp90,
                padding: EdgeInsets.only(
                    left: Dimens.gap_dp16, right: Dimens.gap_dp8),
                width: Adapt.screenW(),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        item.title,
                        style: body2Style(),
                      ),
                    ),
                    Gaps.hGap24,
                    _buildCoverWithType(item.resourceType, item.imgUrl)
                  ],
                ),
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: Dimens.gap_dp16),
            height: Dimens.gap_dp1,
            color: Get.theme.dividerColor,
            width: double.infinity,
          );
        },
        itemCount: events.length);
  }

  Widget _buildItemTimeTip(DateTime time) {
    String timeStr = DateFormat('MM-dd').format(time);
    final now = DateTime.now();
    final isSameMonth = time.year == now.year && time.month == now.month;
    if (isSameMonth) {
      switch (time.day - now.day) {
        case 0:
          //当天
          timeStr = '今天';
          break;
        case 1:
          //明天
          timeStr = '明天';
          break;
        case 2:
          //后天
          timeStr = '后天';
          break;
        case -1:
          timeStr = '昨天';
          break;
        case -2:
          timeStr = '前天';
          break;
      }
    }

    final style = headlineStyle().copyWith(fontWeight: FontWeight.normal);
    final timeColor = (time.day - now.day >= 0 && isSameMonth)
        ? Colours.app_main_light
        : Get.isDarkMode
            ? Colours.dark_subtitle_text.withOpacity(0.6)
            : Colours.subtitle_text.withOpacity(0.6);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimens.gap_dp16),
      child: Text(
        timeStr,
        style: style.copyWith(color: timeColor),
      ),
    );
  }

  ///剩余多少项
  Widget _buildPicUp(int remain) {
    return Material(
      color: Get.theme.cardColor,
      child: InkWell(
        onTap: () {
          setState(() {
            widget.model.pickUp = !widget.model.pickUp;
            showPicUp = !showPicUp;
          });
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: Dimens.gap_dp16),
              height: Dimens.gap_dp1,
              color: Get.theme.dividerColor,
              width: double.infinity,
            ),
            SizedBox(
              height: Dimens.gap_dp40,
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimens.gap_dp16),
                child: Row(
                  children: [
                    Text(
                      '余下$remain项',
                      style: TextStyle(
                          color: context.theme.highlightColor,
                          fontSize: Dimens.font_sp14),
                    ),
                    const Expanded(child: Gaps.empty),
                    Image.asset(
                      ImageUtils.getImagePath('list_icn_arr_open'),
                      color: captionStyle().color?.withOpacity(0.5),
                      width: Dimens.gap_dp12,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildCoverWithType(String resourceType, String imgUrl) {
    final cover = ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(Dimens.gap_dp4)),
      child: CachedNetworkImage(
        imageUrl: ImageUtils.getImageUrlFromSize(
            imgUrl, Size(Dimens.gap_dp60, Dimens.gap_dp60)),
        width: Dimens.gap_dp60,
        height: Dimens.gap_dp60,
        placeholder: (context, url) {
          return Container(
            color: Colours.load_image_placeholder(),
          );
        },
      ),
    );
    if (resourceType == 'ALBUM') {
      //专辑
      return Stack(
        children: [
          Image.asset(
            ImageUtils.getImagePath(GetPlatform.isAndroid
                ? 'ic_cover_alb_android'
                : 'ic_cover_alb_ios'),
            width: Dimens.gap_dp68,
          ),
          Positioned(top: 0, left: 0, child: cover)
        ],
      );
    } else if (resourceType == 'SONG') {
      //单曲
      return Padding(
        padding: EdgeInsets.only(right: Dimens.gap_dp8),
        child: Stack(
          children: [
            cover,
            Positioned(
                left: Dimens.gap_dp15,
                top: Dimens.gap_dp15,
                child: ClipOval(
                  child: Container(
                    width: Dimens.gap_dp30,
                    height: Dimens.gap_dp30,
                    color: Colours.white,
                    padding: EdgeInsets.only(left: Dimens.gap_dp2),
                    alignment: Alignment.center,
                    child: Image.asset(
                      ImageUtils.getImagePath('play_btn_icon'),
                      color: Colours.app_main_light,
                      width: Dimens.gap_dp12,
                    ),
                  ),
                ))
          ],
        ),
      );
    } else if (resourceType == 'MV') {
      //MV
      return Padding(
        padding: EdgeInsets.only(right: Dimens.gap_dp8),
        child: Stack(
          children: [
            cover,
            Positioned(
              left: Dimens.gap_dp22,
              top: Dimens.gap_dp22,
              child: Image.asset(
                ImageUtils.getImagePath('play_btn_icon'),
                color: Colours.white.withOpacity(0.7),
                width: Dimens.gap_dp16,
              ),
            )
          ],
        ),
      );
    }
    return Padding(
      padding: EdgeInsets.only(right: Dimens.gap_dp8),
      child: cover,
    );
  }
}
