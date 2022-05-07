import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/res/colors.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/res/gaps.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';
import 'package:get/get.dart';

import '../common/values/constants.dart';
import '../routes/app_routes.dart';

class UnDeveloped extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            ImageUtils.getImagePath('codeimg'),
            width: Dimens.gap_dp164,
          ),
          Gaps.vGap20,
          Text.rich(
              TextSpan(text: '待开发...', style: headline2Style(), children: [
            TextSpan(
                text: '提PR',
                style: headline2Style().copyWith(color: Colours.blue_dark),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Get.toNamed("${Routes.WEB}?url=$github_address");
                  })
          ])),
        ],
      ),
    );
  }
}
