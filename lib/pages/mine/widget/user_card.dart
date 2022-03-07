import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/res/dimens.dart';
import '../../../common/res/gaps.dart';
import '../../../common/utils/adapt.dart';
import '../../../common/utils/common_utils.dart';
import '../../../common/utils/image_utils.dart';
import '../../../services/auth_service.dart';
import '../mine_controller.dart';

/// Creator: Xing Wei
/// Email: 654206017@qq.com
/// Date: 2022/3/7 11:50 上午
/// Des:

class MineUserCard extends StatelessWidget {
  final controller = GetInstance().find<MineController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          afterLogin(() {
            toUserDetail(accountId: AuthService.to.userId);
          });
        },
        child: Container(
          height: Dimens.gap_dp135,
          margin: EdgeInsets.only(
              top: Dimens.gap_dp20,
              left: Dimens.gap_dp16,
              right: Dimens.gap_dp16),
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Container(
                width: double.infinity,
                height: Dimens.gap_dp95,
                margin: EdgeInsets.only(top: Adapt.px(39)),
                alignment: Alignment.center,
                decoration: _buildCardBg(context),
                child: Obx(() => AuthService.to.isLoggedIn.value
                    ? _buildUserInfo(context)
                    : _buildNotLogin(context)),
              ),
              Container(
                width: Dimens.gap_dp70,
                height: Dimens.gap_dp70,
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.all(Radius.circular(Dimens.gap_dp70 / 2)),
                    border: Border.all(color: context.theme.dividerColor),
                    boxShadow: [
                      BoxShadow(
                          color: context.theme.shadowColor,
                          blurRadius: Dimens.gap_dp18)
                    ]),
                child: Obx(() => buildUserAvatar(
                    AuthService.to.loginData.value?.profile?.avatarUrl,
                    Size(Dimens.gap_dp70, Dimens.gap_dp70))),
              )
            ],
          ),
        ));
  }

  Widget _buildUserInfo(BuildContext context) {
    final account = AuthService.to.loginData.value!.account;
    final profile = AuthService.to.loginData.value!.profile;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Gaps.vGap26,
        Text(
          profile?.nickname ?? account.userName,
          style: headlineStyle().copyWith(fontSize: Dimens.font_sp18),
        ),
        Gaps.vGap6,
        Obx(() => Text(
              '${profile?.follows} 关注    ${profile?.followeds} 粉丝    Lv.${controller.level.value}',
              style: captionStyle(),
            ))
      ],
    );
  }

  Widget _buildNotLogin(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: Dimens.gap_dp24),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(children: [
          TextSpan(
            text: '立即登录 ',
            style: headlineStyle().copyWith(fontSize: Dimens.font_sp20),
          ),
          WidgetSpan(
              alignment: PlaceholderAlignment.top,
              child: Image.asset(
                ImageUtils.getImagePath('icon_more'),
                height: Dimens.gap_dp15,
                color: context.iconColor,
              ))
        ]),
      ),
    );
  }

  Decoration _buildCardBg(BuildContext context, {double radius = 16}) {
    return BoxDecoration(
        color: context.theme.cardColor,
        gradient: context.isDarkMode
            ? LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                    Colors.white12,
                    Colors.white.withOpacity(0.05),
                  ])
            : null,
        borderRadius: BorderRadius.all(
          Radius.circular(Adapt.px(radius)),
        ),
        boxShadow: [
          BoxShadow(
            color: context.theme.shadowColor,
            blurRadius: Dimens.gap_dp18,
          )
        ]);
  }
}
