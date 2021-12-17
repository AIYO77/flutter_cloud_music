import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/res/colors.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/res/gaps.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:flutter_cloud_music/widgets/my_app_bar.dart';
import 'package:get/get.dart';
import 'email_login_controller.dart';

class EmailLoginPage extends GetView<EmailLoginController> {
  const EmailLoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        centerTitle: '网易邮箱账号登陆',
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(
            Dimens.gap_dp15, Dimens.gap_dp28, Dimens.gap_dp15, 0),
        child: Column(
          children: [
            TextField(
              cursorColor: Colours.app_main_light,
              keyboardType: TextInputType.emailAddress,
              style: headlineStyle().copyWith(
                  fontWeight: FontWeight.w500, fontSize: Dimens.font_sp18),
              autofocus: true,
              onChanged: (s) {
                controller.setEmail(s);
              },
              decoration: InputDecoration(
                  hintText: '登陆邮箱',
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Get.theme.dividerColor)),
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Get.theme.dividerColor)),
                  hintStyle: headlineStyle().copyWith(
                      color: Colours.color_215, fontWeight: FontWeight.normal)),
            ),
            TextField(
              cursorColor: Colours.app_main_light,
              keyboardType: TextInputType.streetAddress,
              obscureText: true,
              style: headlineStyle().copyWith(
                  fontWeight: FontWeight.w500, fontSize: Dimens.font_sp18),
              onChanged: (s) {
                controller.setPwd(s);
              },
              decoration: InputDecoration(
                  hintText: '密码',
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Get.theme.dividerColor)),
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Get.theme.dividerColor)),
                  hintStyle: headlineStyle().copyWith(
                      color: Colours.color_215, fontWeight: FontWeight.normal)),
            ),
            Gaps.vGap40,
            Obx(() => CupertinoButton(
                color: Colours.app_main_light,
                disabledColor: Colours.app_main_light.withOpacity(0.4),
                minSize: Dimens.gap_dp40,
                borderRadius: BorderRadius.circular(Dimens.gap_dp40),
                onPressed: !controller.btnEnable.value
                    ? null
                    : () {
                        controller.emailLogin();
                      },
                child: SizedBox(
                  width: double.infinity,
                  child: Center(
                    child: Text('立即登陆',
                        style: headlineStyle().copyWith(color: Colours.white)),
                  ),
                ))),
          ],
        ),
      ),
    );
  }
}
