import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/res/colors.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/res/gaps.dart';

import 'frame_animation_image.dart';

class MusicLoading extends StatelessWidget {
  final Axis axis;

  MusicLoading({this.axis = Axis.vertical});

  final List<String> list = [
    'ca_',
    'caa',
    'cab',
    'cac',
  ];
  @override
  Widget build(BuildContext context) {
    final bool ver = axis == Axis.vertical;
    if (ver) {
      return Center(
        child: Column(
          children: _loadingContent(ver),
        ),
      );
    } else {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _loadingContent(ver),
      );
    }
  }

  List<Widget> _loadingContent(bool ver) {
    return [
      if (!ver) const Expanded(child: Gaps.empty),
      FrameAnimationImage(
        const Key('MusicLoading'),
        list,
        width: Dimens.gap_dp18,
        height: Dimens.gap_dp18,
        interval: 80,
      ),
      if (axis == Axis.vertical) Gaps.vGap15 else Gaps.hGap10,
      Text(
        '正在加载中...',
        style: TextStyle(color: Colours.text_gray, fontSize: Dimens.font_sp13),
      ),
      if (!ver) const Expanded(child: Gaps.empty),
    ];
  }
}
