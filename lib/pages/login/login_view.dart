import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/res/colors.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/res/gaps.dart';
import 'package:flutter_cloud_music/common/utils/adapt.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';
import 'package:flutter_cloud_music/routes/app_routes.dart';
import 'package:get/get.dart';
import 'login_controller.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leadingWidth: Dimens.gap_dp46,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Container(
            margin: EdgeInsets.only(left: Dimens.gap_dp16),
            child: Image.asset(
              ImageUtils.getImagePath('login_icn_back'),
              color: Colors.white,
            ),
          ),
        ),
      ),
      backgroundColor: Colours.app_main,
      body: ListView(
        children: [
          Gaps.vGap80,
          Center(
            child: Image.asset(
              ImageUtils.getImagePath('e18'),
              fit: BoxFit.cover,
              height: Adapt.px(76),
              width: Adapt.px(76),
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.offAndToNamed(Routes.PHONE_LOGIN);
            },
            child: Container(
              height: Dimens.gap_dp46,
              margin: EdgeInsets.only(
                  top: Adapt.px(150),
                  left: Dimens.gap_dp48,
                  right: Dimens.gap_dp48),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.all(Radius.circular(Dimens.gap_dp28))),
              child: Center(
                child: Text(
                  "手机号登陆",
                  style: TextStyle(
                      color: Colours.app_main_light,
                      fontSize: Dimens.font_sp16,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ),
          Gaps.vGap36,
          Center(
            child: Text(
              "本项目仅供学习，请尊重版权",
              style: captionStyle()
                  .copyWith(color: Colors.white54, fontSize: Dimens.font_sp13),
            ),
          ),
          Gaps.vGap100,
          Center(
            child: GestureDetector(
              onTap: () {},
              child: ClipOval(
                child: Container(
                  padding: EdgeInsets.all(Dimens.gap_dp4),
                  color: Colors.white,
                  width: Dimens.gap_dp38,
                  height: Dimens.gap_dp38,
                  child: Center(
                    child: Image.asset(ImageUtils.getImagePath('login_163')),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
