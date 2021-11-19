import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/res/colors.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/res/gaps.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';
import 'package:flutter_cloud_music/common/ext/ext.dart';
import 'package:get/get.dart';
import 'pwd_login_controller.dart';

class PwdLoginPage extends GetView<PwdLoginController> {
  const PwdLoginPage({Key? key}) : super(key: key);

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
            child: Image.asset(ImageUtils.getImagePath('dij'),
                color: headlineStyle().color),
          ),
        ),
        elevation: 0,
        title: Text(
          "账号密码登陆",
          style: headlineStyle().copyWith(fontSize: Dimens.font_sp18),
        ),
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          context.hideKeyboard();
        },
        child: Padding(
          padding: EdgeInsets.fromLTRB(
              Dimens.gap_dp16, Dimens.gap_dp30, Dimens.gap_dp16, 0),
          child: Column(
            children: [
              TextField(
                cursorColor: Colours.app_main_light,
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                style: headlineStyle().copyWith(
                    fontWeight: FontWeight.w500, fontSize: Dimens.font_sp18),
                autofocus: true,
                onChanged: (s) {
                  controller.pwd.value = s;
                },
                decoration: InputDecoration(
                    hintText: '输入密码',
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Get.theme.dividerColor)),
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Get.theme.dividerColor)),
                    contentPadding: const EdgeInsets.only(top: 0.1),
                    hintStyle: headlineStyle().copyWith(
                        color: Colours.color_215,
                        fontWeight: FontWeight.normal)),
              ),
              Gaps.vGap40,
              Obx(() => CupertinoButton(
                  color: Colours.app_main_light,
                  disabledColor: Colours.app_main_light.withOpacity(0.4),
                  minSize: Dimens.gap_dp40,
                  borderRadius: BorderRadius.circular(Dimens.gap_dp40),
                  onPressed:
                      GetUtils.isNullOrBlank(controller.pwd.value) == true
                          ? null
                          : () {
                              controller.pwdLogin();
                            },
                  child: SizedBox(
                    width: double.infinity,
                    child: Center(
                      child: Text('立即登陆',
                          style:
                              headlineStyle().copyWith(color: Colours.white)),
                    ),
                  ))),
            ],
          ),
        ),
      ),
    );
  }
}
