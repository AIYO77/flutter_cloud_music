import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/res/colors.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/res/gaps.dart';
import 'package:flutter_cloud_music/common/res/themes.dart';
import 'package:flutter_cloud_music/common/utils/adapt.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';
import 'package:flutter_cloud_music/pages/home/widgets/drawer/controller.dart';
import 'package:get/get.dart';

import '../../../../routes/app_routes.dart';
import '../../../../services/auth_service.dart';

class DrawerWidget extends StatelessWidget {
  DrawerWidget({
    Key? key,
  }) : super(key: key);

  final controller = GetInstance().putOrFind(() => HomeDrawerController());

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          SizedBox(
            height: Adapt.topPadding(),
          ),
          _buildUser(),
          _settingCard(),
          Expanded(child: Container()),
          if (AuthService.to.isLoggedInValue) _logout(context),
        ],
      ),
    );
  }

  Widget _buildUser() {
    return GestureDetector(
      onTap: () {
        afterLogin(
          () {
            Get.back();
            toUserDetail(accountId: AuthService.to.userId);
          },
        );
      },
      child: Container(
        color: Colors.transparent,
        height: Dimens.gap_dp44,
        alignment: Alignment.centerLeft,
        margin: EdgeInsets.only(top: Dimens.gap_dp10),
        padding: EdgeInsets.symmetric(horizontal: Dimens.gap_dp15),
        child: Obx(
          () => RichText(
            textAlign: TextAlign.end,
            text: TextSpan(
              children: [
                WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: buildUserAvatar(
                        AuthService.to.loginData.value?.profile?.avatarUrl ??
                            '',
                        Size(Dimens.gap_dp26, Dimens.gap_dp26))),
                WidgetSpan(child: Gaps.hGap10),
                TextSpan(
                    text: AuthService.to.isLoggedIn.value
                        ? AuthService.to.loginData.value?.profile?.nickname
                        : '立即登陆',
                    style: headline2Style()),
                WidgetSpan(
                  child: Image.asset(
                    ImageUtils.getImagePath('icon_more'),
                    color: headline2Style().color,
                    height: Dimens.gap_dp15,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _settingCard() {
    return Container(
      margin: EdgeInsets.fromLTRB(
          Dimens.gap_dp15, Dimens.gap_dp30, Dimens.gap_dp15, 0),
      padding: EdgeInsets.symmetric(horizontal: Dimens.gap_dp16),
      width: Adapt.screenW(),
      decoration: BoxDecoration(
        color: Get.isDarkMode ? Colors.white.withOpacity(0.07) : Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(Dimens.gap_dp10)),
      ),
      child: Column(
        children: [
          _themeMode(),
          _about(),
        ],
      ),
    );
  }

  Widget _themeMode() {
    return SizedBox(
      height: Dimens.gap_dp50,
      child: Row(
        children: [
          Image.asset(
            ImageUtils.getImagePath('icn_night'),
            width: Dimens.gap_dp20,
            color: body2Style().color,
          ),
          Gaps.hGap12,
          Expanded(
              child: Text(
            '夜间模式',
            style: body1Style(),
          )),
          CupertinoSwitch(
              value: Get.isDarkMode,
              onChanged: (b) {
                Themes.changeTheme();
              })
        ],
      ),
    );
  }

  Widget _about() {
    return _normCell(
        imgName: 'icn_about',
        title: '关于',
        onTap: () {
          Get.back();
          Get.toNamed("${Routes.WEB}?url=https://github.com/masterxing");
        });
  }

  Widget _normCell(
      {required String imgName,
      required String title,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: Dimens.gap_dp50,
        child: Row(
          children: [
            Image.asset(
              ImageUtils.getImagePath(imgName),
              width: Dimens.gap_dp20,
              color: body2Style().color,
            ),
            Gaps.hGap12,
            Expanded(
                child: Text(
              title,
              style: body1Style(),
            )),
            Image.asset(
              ImageUtils.getImagePath('icon_more'),
              width: Dimens.gap_dp20,
              color: body2Style().color?.withOpacity(0.5),
            )
          ],
        ),
      ),
    );
  }

  Widget _logout(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // controller.logout();
        Get.dialog(
            CupertinoAlertDialog(
              title: const Text('FlutterMusic'),
              content: const Text('确定退出当前账号?'),
              actions: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    color: Colors.transparent,
                    height: Dimens.gap_dp50,
                    alignment: Alignment.center,
                    child: Text(
                      '取消',
                      style: body2Style().copyWith(
                          color: context.theme.highlightColor,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.back();
                    controller.logout();
                  },
                  child: Container(
                    color: Colors.transparent,
                    height: Dimens.gap_dp50,
                    alignment: Alignment.center,
                    child: Text(
                      '确定',
                      style: body2Style()
                          .copyWith(color: context.theme.highlightColor),
                    ),
                  ),
                )
              ],
            ),
            barrierColor: Colors.black12);
      },
      child: Container(
        height: Dimens.gap_dp48,
        decoration: BoxDecoration(
            color:
                Get.isDarkMode ? Colors.white.withOpacity(0.07) : Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(Dimens.gap_dp10))),
        margin: EdgeInsets.only(
            left: Dimens.gap_dp16,
            right: Dimens.gap_dp16,
            bottom: Dimens.gap_dp20 + Adapt.bottomPadding()),
        alignment: Alignment.center,
        child: Text(
          '退出登陆',
          style: TextStyle(
              color: Colours.app_main_light, fontSize: Dimens.font_sp15),
        ),
      ),
    );
  }
}
