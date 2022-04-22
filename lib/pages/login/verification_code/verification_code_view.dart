import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/res/gaps.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';
import 'package:flutter_cloud_music/routes/app_routes.dart';
import 'package:flutter_cloud_music/widgets/verification_box/verification_box.dart';
import 'package:flutter_cloud_music/widgets/verification_box/verification_box_item.dart';
import 'package:get/get.dart';

import 'verification_code_controller.dart';

class VerificationCodePage extends GetView<VerificationCodeController> {
  const VerificationCodePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final styleColor = Get.isDarkMode ? Colors.white : Colors.black;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Get.theme.scaffoldBackgroundColor,
        leadingWidth: Dimens.gap_dp42,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Padding(
            padding: EdgeInsets.only(left: Dimens.gap_dp13),
            child: Image.asset(ImageUtils.getImagePath('login_icn_back'),
                color: headlineStyle().color),
          ),
        ),
        elevation: 0,
        title: Text(
          "手机号登陆",
          style: headlineStyle().copyWith(fontSize: Dimens.font_sp18),
        ),
        actions: [if (controller.hasPassword) _buildPwdAction()],
      ),
      body: Padding(
        padding: EdgeInsets.only(left: Dimens.gap_dp17, right: Dimens.gap_dp17),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gaps.vGap36,
            Text(
              '请输入验证码',
              style: headlineStyle(),
            ),
            Gaps.vGap10,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '已发送至+${controller.countrycode}${controller.getPhoneSubStr()}',
                  style: body1Style(),
                ),
                GestureDetector(
                  onTap: () {
                    if (controller.countdownTime.value < 1) {
                      controller.sendVerCode();
                    }
                  },
                  child: Obx(
                    () => Text(
                      controller.countdownTime.value < 1
                          ? '重新获取'
                          : '${controller.countdownTime.value}s',
                      style: TextStyle(
                          color: controller.countdownTime.value < 1
                              ? context.theme.highlightColor
                              : body1Style().color),
                    ),
                  ),
                )
              ],
            ),
            Gaps.vGap16,
            VerificationBox(
              itemWidget: Dimens.gap_dp60,
              count: 4,
              borderColor: styleColor.withOpacity(0.2),
              focusBorderColor: styleColor.withOpacity(0.8),
              textStyle: headlineStyle().copyWith(
                  color: styleColor.withOpacity(0.8),
                  fontSize: Dimens.font_sp18),
              type: VerificationBoxItemType.underline,
              onSubmitted: (code) {
                controller.verCode(code);
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _buildPwdAction() {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.PWD_LOGIN, parameters: {
          'phone': controller.phone,
          'countrycode': controller.countrycode
        });
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(
            0, Dimens.gap_dp14, Dimens.gap_dp15, Dimens.gap_dp14),
        width: Dimens.gap_dp76,
        height: Dimens.gap_dp26,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            border: Border.all(
                color: Get.theme.dividerColor, width: Dimens.gap_dp1),
            borderRadius: BorderRadius.all(Radius.circular(Dimens.gap_dp13))),
        child: Text(
          '密码登陆',
          style: headline2Style().copyWith(fontSize: Dimens.font_sp14),
        ),
      ),
    );
  }
}
