import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/res/colors.dart';
import 'package:flutter_cloud_music/common/res/gaps.dart';
import 'package:flutter_cloud_music/pages/found/model/creative_model.dart';
import 'package:flutter_cloud_music/routes/routes_utils.dart';
import 'package:flutter_cloud_music/widgets/custom_tap.dart';
import 'package:get/get.dart';

import '../../../common/res/dimens.dart';
import '../../../common/utils/common_utils.dart';
import '../../../common/utils/image_utils.dart';

/// Creator: Xing Wei
/// Email: 654206017@qq.com
/// Date: 2022/4/22 7:47 下午
/// Des:

class FoundNewSlideDragonBall extends StatelessWidget {
  final CreativeModel creativeModel;

  final double itemHeight;

  final colors = [
    const Color(0xffdfd4d0),
    const Color(0xffd1dce1),
    const Color(0xffe1d1ce),
    const Color(0xffe2dacf),
    const Color(0xffe0d1e1),
    const Color(0xffd1e1d2),
  ];

  FoundNewSlideDragonBall(
      {required this.creativeModel, required this.itemHeight});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: itemHeight,
      padding: EdgeInsets.only(
          left: Dimens.gap_dp16,
          right: Dimens.gap_dp16,
          top: Dimens.gap_dp18,
          bottom: Dimens.gap_dp18),
      decoration: BoxDecoration(
        color: context.theme.cardColor,
        borderRadius: BorderRadius.all(Radius.circular(Dimens.gap_dp10)),
      ),
      child: Container(
        padding: EdgeInsets.only(
            left: Dimens.gap_dp16,
            top: Dimens.gap_dp16,
            bottom: Dimens.gap_dp16),
        decoration: BoxDecoration(
            color: context.isDarkMode ? Colors.white12 : Colours.c_30353e,
            borderRadius: BorderRadius.circular(Dimens.gap_dp10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              creativeModel.uiElement?.mainTitle?.title ?? '',
              style: headlineStyle().copyWith(color: Colors.white),
            ),
            Gaps.vGap18,
            Expanded(
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.only(right: Dimens.gap_dp16),
                    itemBuilder: (context, index) {
                      final creative =
                          creativeModel.resources!.elementAt(index);
                      return _item(creative);
                    },
                    separatorBuilder: (context, index) {
                      return Gaps.hGap10;
                    },
                    itemCount: creativeModel.resources?.length ?? 0))
          ],
        ),
      ),
    );
  }

  Widget _item(Resources resources) {
    return Bounce(
      onPressed: () {
        RouteUtils.routeFromActionStr(resources.action);
      },
      child: Container(
        height: Dimens.gap_dp95,
        width: Dimens.gap_dp95,
        padding: EdgeInsets.only(
            left: Dimens.gap_dp10,
            top: Dimens.gap_dp10,
            right: Dimens.gap_dp7,
            bottom: Dimens.gap_dp7),
        decoration: BoxDecoration(
          color: colors.elementAt(Random().nextInt(colors.length)),
          borderRadius: BorderRadius.circular(Dimens.gap_dp5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              resources.uiElement.mainTitle?.title ?? '',
              style: body1Style(),
            ),
            const Expanded(child: Gaps.empty),
            Row(
              children: [
                Expanded(
                    child: Text(
                  resources.uiElement.labelTexts?.join('/') ?? '',
                  textAlign: TextAlign.start,
                  style: body1Style(),
                )),
                Container(
                    width: Dimens.gap_dp24,
                    height: Dimens.gap_dp24,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      borderRadius:
                          BorderRadius.all(Radius.circular(Dimens.gap_dp16)),
                    ),
                    child: Center(
                      child: Image.asset(
                        ImageUtils.getImagePath('icon_play_small'),
                        width: Dimens.gap_dp12,
                        height: Dimens.gap_dp12,
                        color: Colours.app_main_light,
                      ),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
