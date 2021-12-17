import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/res/colors.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/res/gaps.dart';
import 'package:flutter_cloud_music/common/utils/adapt.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';
import 'package:flutter_cloud_music/pages/found/found_controller.dart';
import 'package:get/get.dart';

class FoundAppbar extends StatelessWidget implements PreferredSizeWidget {
  final controller = GetInstance().find<FoundController>();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: context.mediaQueryPadding.top,
        ),
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: Obx(() => Container(
                      padding: EdgeInsets.only(
                          left: Adapt.px(18), right: Adapt.px(18)),
                      height: Dimens.gap_dp36,
                      margin: EdgeInsets.only(
                          right: Adapt.px(15), left: Adapt.px(56)),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.all(Radius.circular(Adapt.px(18))),
                        color: controller.isScrolled.value
                            ? Get.isDarkMode
                                ? Colors.white.withOpacity(0.2)
                                : Colors.grey.shade100
                            : Get.isDarkMode
                                ? Colors.white.withOpacity(0.2)
                                : Colors.white,
                      ),
                      child: Row(
                        mainAxisAlignment: GetPlatform.isIOS
                            ? MainAxisAlignment.center
                            : MainAxisAlignment.start,
                        children: [
                          Image.asset(
                            ImageUtils.getImagePath('search'),
                            color: const Color.fromARGB(255, 134, 135, 134),
                            width: Dimens.gap_dp15,
                            height: Dimens.gap_dp15,
                          ),
                          Gaps.hGap5,
                          Expanded(
                            child: Obx(
                              () => Text(
                                controller.defuleSearch.value?.showKeyword ??
                                    "搜索",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Colours.text_gray,
                                    fontSize: Dimens.font_sp14),
                              ),
                            ),
                          )
                        ],
                      ),
                    )),
              ),
              GestureDetector(
                child: Icon(
                  Icons.keyboard_voice,
                  color: Get.isDarkMode ? Colors.white : Colors.black,
                  size: Dimens.gap_dp25,
                ),
                onTap: () {
                  // Get.changeThemeMode(ThemeMode.dark);
                },
              ),
              Gaps.hGap14
            ],
          ),
        )
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(Dimens.gap_dp56);
}
