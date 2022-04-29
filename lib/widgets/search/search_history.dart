import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/res/gaps.dart';
import 'package:flutter_cloud_music/common/utils/adapt.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';
import 'package:flutter_cloud_music/services/stored_service.dart';
import 'package:flutter_cloud_music/typedef/function.dart';
import 'package:get/get.dart';

import '../../common/res/colors.dart';
import '../../common/utils/common_utils.dart';

/// Creator: Xing Wei
/// Email: 654206017@qq.com
/// Date: 2022/3/14 3:19 下午
/// Des:

class SearchHistoryView extends StatelessWidget {
  final Axis axis;

  final ParamSingleCallback<String> onSelected;

  const SearchHistoryView(
      {required this.onSelected, this.axis = Axis.horizontal});

  @override
  Widget build(BuildContext context) {
    return axis == Axis.horizontal
        ? _buildHorView(context)
        : _buildVerView(context);
  }

  Widget _buildHorView(BuildContext context) {
    return Obx(() => GetUtils.isNullOrBlank(
                StoredService.to.historySearch.value) ==
            true
        ? Gaps.empty
        : Row(
            children: [
              Container(
                width: Dimens.gap_dp50,
                height: Dimens.gap_dp32,
                color: context.theme.cardColor,
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: Dimens.gap_dp16),
                child: Text(
                  '历史',
                  style: headline2Style(),
                ),
              ),
              Expanded(
                  child: SizedBox.fromSize(
                size: Size.fromHeight(Dimens.gap_dp32),
                child: ListView.separated(
                    padding: EdgeInsets.symmetric(horizontal: Dimens.gap_dp10),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return _buildItem(
                          context,
                          StoredService.to.historySearch.value!
                              .elementAt(index));
                    },
                    separatorBuilder: (context, index) {
                      return Gaps.hGap10;
                    },
                    itemCount: StoredService.to.historySearch.value!.length),
              )),
              GestureDetector(
                onTap: () {
                  // StoredService.to.clearSearchHistory();
                  toast('clear');
                },
                behavior: HitTestBehavior.translucent,
                child: Container(
                  width: Dimens.gap_dp50,
                  height: Dimens.gap_dp32,
                  color: context.theme.cardColor,
                  padding: EdgeInsets.only(
                      left: Dimens.gap_dp12, right: Dimens.gap_dp12),
                  child: Image.asset(
                    ImageUtils.getImagePath('playlist_icn_delete'),
                    color: captionStyle().color?.withOpacity(0.7),
                  ),
                ),
              ),
            ],
          ));
  }

  Widget _buildVerView(BuildContext context) {
    return Obx(() =>
        GetUtils.isNullOrBlank(StoredService.to.historySearch.value) == true
            ? Gaps.empty
            : Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimens.gap_dp15),
                child: Column(
                  children: [
                    Gaps.vGap2,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '搜索历史',
                          style: headline1Style(),
                        ),
                        GestureDetector(
                          onTap: () {
                            toast('clear');
                          },
                          child: Image.asset(
                            ImageUtils.getImagePath('playlist_icn_delete'),
                            color: captionStyle().color,
                            height: Dimens.gap_dp25,
                          ),
                        )
                      ],
                    ),
                    Gaps.vGap6,
                    ClipRect(
                      clipper: const _Clipper(3), //裁剪最多三行
                      child: SizedBox(
                        width: Adapt.screenW(),
                        child: Wrap(
                          spacing: Dimens.gap_dp10,
                          runSpacing: Dimens.gap_dp10,
                          children: StoredService.to.historySearch.value!
                              .map((e) => _buildItem(context, e))
                              .toList(),
                        ),
                      ),
                    )
                  ],
                ),
              ));
  }

  Widget _buildItem(BuildContext context, String keywords) {
    return GestureDetector(
        onTap: () {
          onSelected.call(keywords);
        },
        child: SizedBox(
          height: Dimens.gap_dp32,
          child: Chip(
              labelPadding: EdgeInsets.symmetric(horizontal: Dimens.gap_dp14),
              backgroundColor:
                  context.isDarkMode ? Colors.white12 : Colours.color_248,
              label: Text(
                keywords,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: headline1Style().copyWith(fontWeight: FontWeight.normal),
              )),
        ));
  }
}

class _Clipper extends CustomClipper<Rect> {
  final int maxLine;

  const _Clipper(this.maxLine);

  @override
  Rect getClip(Size size) {
    return Rect.fromLTRB(0, 0, Adapt.screenW(), Dimens.gap_dp42 * maxLine);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) {
    return false;
  }
}
