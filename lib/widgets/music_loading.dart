import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/res/colors.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/res/gaps.dart';

import 'frame_animation_image.dart';

class MusicLoading extends StatelessWidget {
  final List<String> list = [
    'ca_',
    'caa',
    'cab',
    'cac',
  ];
  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Center(
        child: Column(
          children: [
            FrameAnimationImage(
              const Key('MusicLoading'),
              list,
              width: Dimens.gap_dp20,
              height: Dimens.gap_dp20,
              interval: 80,
            ),
            Gaps.vGap15,
            Text(
              '正在加载中...',
              style: TextStyle(
                  color: Colours.text_gray, fontSize: Dimens.font_sp14),
            )
          ],
        ),
      ),
    );
  }
}
