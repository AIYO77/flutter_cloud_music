import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/res/gaps.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:flutter_cloud_music/services/auth_service.dart';
import 'package:get/get.dart';

import '../../../common/res/dimens.dart';
import '../../../common/utils/adapt.dart';
import '../../../common/utils/image_utils.dart';
import '../../../delegate/general_sliver_delegate.dart';
import '../../../routes/app_routes.dart';
import '../mine_controller.dart';

/// Creator: Xing Wei
/// Email: 654206017@qq.com
/// Date: 2022/3/7 11:06 上午
/// Des:

class MineViewBar extends StatelessWidget {
  final controller = GetInstance().find<MineController>();

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: GeneralSliverDelegate(
        child: PreferredSize(
          preferredSize: Size.fromHeight(controller.barHeight),
          child: Obx(
            () => Container(
              padding: EdgeInsets.only(
                  right: Dimens.gap_dp16,
                  top: Adapt.topPadding() + Dimens.gap_dp4),
              color: context.theme.cardColor
                  .withOpacity(controller.barBgOpacity.value),
              child: SizedBox(
                height: Dimens.gap_dp44,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                        child: Container(
                      margin: EdgeInsets.only(left: Dimens.gap_dp40),
                      alignment: Alignment.center,
                      child: controller.barBgOpacity.value >= 1.0
                          ? GestureDetector(
                              onTap: () {
                                afterLogin(() {
                                  toUserDetail(
                                      accountId: AuthService.to.userId);
                                });
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  buildUserAvatar(
                                      AuthService.to.loginData.value?.profile
                                          ?.avatarUrl,
                                      Size(Dimens.gap_dp24, Dimens.gap_dp24)),
                                  Gaps.hGap5,
                                  Text(
                                    AuthService.to.loginData.value?.profile
                                            ?.nickname ??
                                        '',
                                    style: headline1Style(),
                                  )
                                ],
                              ),
                            )
                          : null,
                    )),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.SEARCH);
                      },
                      child: Image.asset(
                        ImageUtils.getImagePath('search'),
                        color: context.iconColor,
                        height: Dimens.gap_dp24,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
