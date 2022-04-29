import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/res/colors.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/res/gaps.dart';
import 'package:flutter_cloud_music/common/utils/adapt.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';
import 'package:flutter_cloud_music/common/values/server.dart';
import 'package:flutter_cloud_music/pages/found/found_controller.dart';
import 'package:flutter_cloud_music/routes/app_routes.dart';
import 'package:get/get.dart';

class FoundAppbar extends StatelessWidget implements PreferredSizeWidget {
  final controller = GetInstance().find<FoundController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: Adapt.topPadding()),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                Get.toNamed(Routes.SEARCH,
                    arguments: controller.defuleSearch.value);
              },
              child: Obx(
                () => Container(
                  padding:
                      EdgeInsets.only(left: Adapt.px(18), right: Adapt.px(18)),
                  height: Dimens.gap_dp36,
                  margin:
                      EdgeInsets.only(right: Adapt.px(15), left: Adapt.px(56)),
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.all(Radius.circular(Adapt.px(18))),
                    color: controller.isScrolled.value
                        ? Get.isDarkMode
                            ? Colors.white12
                            : Colors.grey.shade100
                        : Get.isDarkMode
                            ? Colors.white12
                            : Colors.white,
                  ),
                  alignment: Alignment.center,
                  child: Text.rich(
                    TextSpan(children: [
                      WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: Padding(
                            padding: EdgeInsets.only(right: Dimens.gap_dp5),
                            child: Image.asset(
                              ImageUtils.getImagePath('search'),
                              color: const Color.fromARGB(255, 134, 135, 134),
                              width: Dimens.gap_dp15,
                              height: Dimens.gap_dp15,
                            ),
                          )),
                      TextSpan(
                          text: controller.defuleSearch.value?.showKeyword ??
                              "搜索",
                          style: TextStyle(
                              color: Colours.text_gray,
                              fontSize: Dimens.font_sp14))
                    ]),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            child: Icon(
              Icons.keyboard_voice,
              color: Get.isDarkMode
                  ? Colours.dark_body2_txt_color
                  : Colours.body2_txt_color,
              size: Dimens.gap_dp25,
            ),
            onTap: () {
              notImplemented(context);
            },
          ),
          Gaps.hGap14
        ],
      ),
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(Get.theme.appBarTheme.toolbarHeight ?? Dimens.gap_dp44);
}
