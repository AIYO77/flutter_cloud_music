import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/res/colors.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/res/gaps.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';
import 'package:flutter_cloud_music/pages/singer_list/logic.dart';
import 'package:flutter_cloud_music/pages/singer_list/state.dart';
import 'package:flutter_cloud_music/widgets/text_button_icon.dart';
import 'package:get/get.dart';

class FilterHeader extends StatefulWidget {
  @override
  _FilterHeaderState createState() => _FilterHeaderState();
}

class _FilterHeaderState extends State<FilterHeader> {
  double offset = 0.0;
  late Animation<double> animation;

  late SingerListState state;

  @override
  void initState() {
    super.initState();
    state = Get.find<SingerListLogic>().singerListState;
    animation =
        Tween(begin: 0.0, end: 1.0).animate(state.headerAnimationController)
          ..addListener(() {
            setState(() {
              offset = animation.value;
            });
          });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Dimens.gap_dp85 - Dimens.gap_dp45 * offset,
      width: double.infinity,
      color: Get.theme.cardColor,
      padding: EdgeInsets.symmetric(horizontal: Dimens.gap_dp16),
      child: Stack(
        children: [
          Visibility(
              visible: offset != 1,
              child: Opacity(
                opacity: 1.0 - offset,
                child: _buildExpanded(),
              )),
          Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Visibility(
                visible: offset > 0,
                child: Opacity(
                  opacity: offset,
                  child: _buildPackUp(),
                ),
              ))
        ],
      ),
    );
  }

  ///展开的widget
  Widget _buildExpanded() {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        children: [
          Gaps.vGap16,
          SizedBox(
              height: Dimens.gap_dp20,
              child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final type = state.listArea.elementAt(index);
                    return Obx(() => GestureDetector(
                          onTap: () {
                            state.area.value = type;
                          },
                          child: Text(
                            type.name,
                            style: TextStyle(
                                fontSize: Dimens.font_sp14,
                                color: state.area.value.id == type.id
                                    ? Colours.app_main_light
                                    : body1Style().color),
                          ),
                        ));
                  },
                  separatorBuilder: (context, index) {
                    return Gaps.hGap28;
                  },
                  itemCount: state.listArea.length)),
          Gaps.vGap16,
          SizedBox(
              height: Dimens.gap_dp20,
              child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final type = state.listType.elementAt(index);
                    return Obx(() => GestureDetector(
                          onTap: () {
                            state.type.value = type;
                          },
                          child: Text(
                            type.name,
                            style: TextStyle(
                                fontSize: Dimens.font_sp14,
                                color: state.type.value.id == type.id
                                    ? Colours.app_main_light
                                    : body1Style().color),
                          ),
                        ));
                  },
                  separatorBuilder: (context, index) {
                    return Gaps.hGap28;
                  },
                  itemCount: state.listType.length))
        ],
      ),
    );
  }

  ///收起时的widget
  Widget _buildPackUp() {
    return SizedBox(
      height: Dimens.gap_dp40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Obx(() => Text(
                state.type.value.id == -1
                    ? '全部歌手'
                    : '${state.area.value.name}.${state.type.value.name}',
                style: body1Style().copyWith(fontSize: Dimens.font_sp14),
              )),
          MyTextButtonWithIcon(
              onPressed: () {
                state.isExpandFilter.value = !state.isExpandFilter.value;
              },
              icon: Container(
                margin: EdgeInsets.only(left: Dimens.gap_dp18),
                child: Image.asset(
                  ImageUtils.getImagePath(
                    'list_icn_filter',
                  ),
                  width: Dimens.gap_dp12,
                  color: body1Style().color!.withOpacity(0.7),
                ),
              ),
              label: Text(
                '筛选',
                style: body1Style().copyWith(fontSize: Dimens.font_sp14),
              ))
        ],
      ),
    );
  }
}
