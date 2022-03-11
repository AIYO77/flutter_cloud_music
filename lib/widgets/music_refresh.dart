import 'dart:math';

import 'package:flutter/material.dart'
    hide RefreshIndicator, RefreshIndicatorState;
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/utils/adapt.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// Creator: Xing Wei
/// Email: 654206017@qq.com
/// Date: 2022/3/10 3:42 下午
/// Des:
///
class MusicRefresh extends RefreshIndicator {
  MusicRefresh()
      : super(height: Dimens.gap_dp80, refreshStyle: RefreshStyle.Follow);

  @override
  State<StatefulWidget> createState() => _MusicRefreshState();
}

class _MusicRefreshState extends RefreshIndicatorState<MusicRefresh> {
  int index = 0;

  final height = Dimens.gap_dp80;

  @override
  Widget buildContent(BuildContext context, RefreshStatus mode) {
    return Image.asset(
      _getWhite(
          (mode == RefreshStatus.refreshing || mode == RefreshStatus.completed)
              ? 41
              : index),
      color: context.isDarkMode ? Colors.white : null,
      gaplessPlayback: true,
      height: height,
      width: height,
    );
  }

  @override
  void onOffsetChange(double offset) {
    super.onOffsetChange(offset);
    setState(() {
      index = (((offset - Adapt.topPadding()) / Adapt.px(75)) * 42).ceil() - 1;
    });
  }

  String _getWhite(int index) {
    return 'assets/anim/loading/loading_${min(max(index, 0), 41)}.png';
  }
}
