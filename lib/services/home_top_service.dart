import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/res/colors.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/res/gaps.dart';
import 'package:flutter_cloud_music/common/utils/adapt.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';
import 'package:flutter_cloud_music/pages/found/model/default_search_model.dart';
import 'package:get/get.dart';

class HomeTopService extends GetxService {
  static HomeTopService get to => Get.find();
  final appBarBgColors = Rx<Color>(Colours.bg_color);
  final appbarChild = Rx<Widget>(Container());

  final isScrolled = Rx<bool>(false);
  final defuleSearch = Rx<DefaultSearchModel?>(null);

  void homePagechanged(int index) {
    if (index == 0) {
      appbarChild.value = _buildTopSearch();
    } else {
      appBarBgColors.value = Colors.white;
      appbarChild.value = Gaps.empty;
    }
  }

  Widget _buildTopSearch() {
    return Row(
      children: [
        Expanded(
          child: Obx(() => Container(
                padding:
                    EdgeInsets.only(left: Adapt.px(18), right: Adapt.px(18)),
                height: Dimens.gap_dp36,
                margin: EdgeInsets.only(right: Adapt.px(10), left: Adapt.px(5)),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(Adapt.px(18))),
                  color: to.isScrolled.value
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
                    Obx(() => Text(
                          defuleSearch.value?.showKeyword ?? "搜索",
                          style: TextStyle(
                              color: Colours.text_gray,
                              fontSize: Dimens.font_sp14),
                        ))
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
        )
      ],
    );
  }
}
