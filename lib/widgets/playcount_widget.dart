import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/res/gaps.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';

class PlayCountWidget extends StatelessWidget {
  final int playCount;

  const PlayCountWidget({required this.playCount});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: Dimens.gap_dp7, right: Dimens.gap_dp7),
      height: Dimens.gap_dp16,
      color: Colors.black.withOpacity(0.60),
      child: _playcount(),
    );
  }

  Widget _playcount() {
    return Row(
      children: [
        Image.asset(
          ImageUtils.getImagePath('icon_playcount'),
          width: Dimens.gap_dp8,
          height: Dimens.gap_dp8,
        ),
        Gaps.hGap1,
        Text(
          getPlayCountStrFromInt(playCount),
          style: TextStyle(
              color: Colors.white.withOpacity(0.9), fontSize: Dimens.font_sp10),
        )
      ],
    );
  }
}
