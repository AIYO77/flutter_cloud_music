import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/res/colors.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/res/gaps.dart';
import 'package:flutter_cloud_music/common/utils/adapt.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:flutter_cloud_music/pages/music_calendar/content/calendar_list_controller.dart';
import 'package:flutter_cloud_music/pages/music_calendar/content/item.dart';
import 'package:flutter_cloud_music/routes/app_routes.dart';
import 'package:flutter_cloud_music/widgets/music_loading.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class CalenderListView extends StatelessWidget {
  final DateTime dateTime;

  CalenderListView(Key key, {required this.dateTime}) : super(key: key);

  late CalendarListController controller;

  @override
  Widget build(BuildContext context) {
    controller = GetInstance().putOrFind(() => CalendarListController(dateTime),
        tag: '${dateTime.millisecondsSinceEpoch}');
    return Obx(() => controller.data.value == null
        ? Container(
            margin: EdgeInsets.only(top: Dimens.gap_dp60),
            child: MusicLoading(),
          )
        : _buildContent());
  }

  Widget _buildContent() {
    if (GetUtils.isNullOrBlank(controller.data.value) == true) {
      return Container(
        child: _showEmpty(''),
      );
    } else {
      return ScrollablePositionedList.builder(
        padding: EdgeInsets.only(top: Dimens.gap_dp15),
        itemCount: controller.data.value?.length ?? 0,
        initialScrollIndex: controller.initialScrollIndex,
        itemBuilder: (context, index) => _item(index),
      );
    }
  }

  Widget _item(int index) {
    final data = controller.data.value!.elementAt(index);
    return Column(
      children: [CalenderItem(model: data), _separator(index)],
    );
  }

  ///分割线
  Widget _separator(int index) {
    final items = controller.data.value!;
    final cur = items.elementAt(index);
    if (index < items.length - 1) {
      //有下一个
      final next = items.elementAt(index + 1);
      final widget = _buildDaysEmpty(curDate: cur.time, nextDate: next.time);
      if (widget != null) {
        return widget;
      }
    } else {
      //最后一个
      return _buildFooter(items.last.time);
    }
    //正常的分割线
    return Gaps.vGap10;
  }

  Widget? _buildDaysEmpty(
      {required DateTime curDate, required DateTime nextDate}) {
    final diffDay = nextDate.day - curDate.day;
    if (diffDay > 1) {
      final bool showFollow = controller.showFollowDay == null ||
          controller.showFollowDay == curDate.day;
      //中间有间隔天
      String headerTip = '';
      if (diffDay == 2) {
        //只间隔一天
        headerTip = DateFormat('MM-dd')
            .format(DateTime(curDate.year, curDate.month, curDate.day + 1));
      } else {
        //间隔大于一天
        final startTip = DateFormat('MM-dd')
            .format(DateTime(curDate.year, curDate.month, curDate.day + 1));
        final endTip = DateFormat('MM-dd')
            .format(DateTime(nextDate.year, nextDate.month, nextDate.day - 1));
        headerTip = '$startTip 至 $endTip';
      }
      if (showFollow) {
        controller.showFollowDay ??= curDate.day;
        return _showEmpty(headerTip);
      } else {
        return SizedBox(
          height: Dimens.gap_dp48,
          width: Adapt.screenW(),
          child: Center(
            child: Text(
              '$headerTip 暂无内容',
              style: captionStyle(),
            ),
          ),
        );
      }
    }
    return null;
  }

  Widget _showEmpty(String headerTip) {
    return SizedBox(
      height: Dimens.gap_dp48,
      width: Adapt.screenW(),
      child: Center(
        child: RichText(
            text: TextSpan(style: captionStyle(), children: [
          TextSpan(text: '$headerTip 暂无内容，'),
          WidgetSpan(
              child: GestureDetector(
            onTap: () {
              Get.toNamed(Routes.SINGER_PAGE);
            },
            child: Text(
              '关注歌手',
              style: captionStyle().copyWith(color: Colours.blue),
            ),
          )),
          const TextSpan(text: '获取更多质询吧')
        ])),
      ),
    );
  }

  Widget _buildFooter(DateTime lastItemTime) {
    //最后一个
    final days = DateUtils.getDaysInMonth(dateTime.year, dateTime.month);
    final widget = _buildDaysEmpty(
        curDate: lastItemTime,
        nextDate: DateTime(dateTime.year, dateTime.month, days));
    return Container(
      width: Adapt.screenW(),
      alignment: Alignment.center,
      padding: EdgeInsets.only(bottom: Dimens.gap_dp58 + Adapt.bottomPadding()),
      child: Column(
        children: [
          if (widget != null) widget,
          Container(
            alignment: Alignment.center,
            padding: widget != null
                ? null
                : EdgeInsets.symmetric(vertical: Dimens.gap_dp10),
            child: Opacity(
              opacity: 0.7,
              child: Center(
                child: Text(
                  '音乐日历预告类信息仅作为提示参考，具体内容以版权方为准',
                  style: captionStyle().copyWith(fontSize: Dimens.font_sp11),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
