import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/ext/ext.dart';
import 'package:flutter_cloud_music/common/res/colors.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/res/gaps.dart';
import 'package:flutter_cloud_music/common/utils/adapt.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';
import 'package:flutter_cloud_music/pages/login/phone_login/widget/country_sheet.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import 'phone_login_controller.dart';

class PhoneLoginPage extends GetView<PhoneLoginController> {
  const PhoneLoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      ),
      body: Padding(
        padding: EdgeInsets.only(left: Dimens.gap_dp17, right: Dimens.gap_dp17),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gaps.vGap36,
            Text(
              '登陆体验更多精彩',
              style: headlineStyle(),
            ),
            Gaps.vGap10,
            Text(
              '未注册手机号登陆后将自动创建账号',
              style: captionStyle(),
            ),
            Gaps.vGap16,
            Container(
              height: Dimens.gap_dp46,
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          color: Get.theme.dividerColor,
                          width: Dimens.gap_dp1))),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.bottomSheet(CountryShaeet(
                        callback: (code) {
                          controller.countrycode.value = code;
                        },
                      ),
                          isScrollControlled: true,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(Dimens.gap_dp16),
                                  topRight: Radius.circular(Dimens.gap_dp16))),
                          backgroundColor: Get.theme.cardColor);
                    },
                    child: Obx(() => Text(
                          '+${controller.countrycode.value}',
                          style: headlineStyle().copyWith(
                              fontSize: Dimens.font_sp18,
                              fontWeight: FontWeight.w500),
                        )),
                  ),
                  Image.asset(
                    ImageUtils.getImagePath('icn_arr_down'),
                    color: headlineStyle().color,
                    width: Dimens.gap_dp20,
                  ),
                  Gaps.hGap3,
                  Expanded(
                      child: TextField(
                    cursorColor: Colours.app_main_light,
                    keyboardType: TextInputType.phone,
                    style: headlineStyle().copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: Dimens.font_sp18),
                    autofocus: true,
                    onChanged: (s) {
                      controller.phone.value = s;
                      controller.nextBtnEnable.value = s.isNotEmpty;
                    },
                    decoration: InputDecoration(
                        hintText: '输入手机号',
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.only(top: 0.1),
                        hintStyle: headlineStyle().copyWith(
                            color: Colours.color_215,
                            fontWeight: FontWeight.normal)),
                  ))
                ],
              ),
            ),
            Gaps.vGap40,
            Obx(
              () => CupertinoButton(
                color: Colours.app_main_light,
                disabledColor: Colours.app_main_light.withOpacity(0.4),
                minSize: Dimens.gap_dp40,
                borderRadius: BorderRadius.circular(Dimens.gap_dp40),
                onPressed: controller.nextBtnEnable.value ? _next : null,
                child: SizedBox(
                  width: Adapt.screenW(),
                  child: Center(
                    child: Text(
                      '下一步',
                      style: headlineStyle().copyWith(color: Colours.white),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _next() {
    Get.context?.hideKeyboard();
    if (GetUtils.isPhoneNumber(controller.phone.value)) {
      controller.next();
    } else {
      EasyLoading.showError('请输入正确的手机号格式');
    }
  }
}
