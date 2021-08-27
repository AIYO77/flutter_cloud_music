import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/res/gaps.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';

class UnDeveloped extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(ImageUtils.getImagePath('baby_xiexie')),
          Gaps.vGap10,
          Text(
            '待开发，欢迎pr',
            style: headline2Style(),
          )
        ],
      ),
    );
  }
}
