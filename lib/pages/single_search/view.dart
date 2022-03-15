import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/pages/single_search/widget/search_result.dart';
import 'package:flutter_cloud_music/pages/single_search/widget/search_suggest.dart';
import 'package:flutter_cloud_music/widgets/search/search_history.dart';
import 'package:get/get.dart';

import '../../common/res/colors.dart';
import '../../common/res/dimens.dart';
import '../../common/utils/common_utils.dart';
import '../../common/values/constants.dart';
import 'logic.dart';

class SingleSearchPage extends GetView<SingleSearchLogic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.cardColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        centerTitle: true,
        title: _buildSearchTitle(context),
        actions: [
          GestureDetector(
            onTap: () {
              Get.back();
            },
            behavior: HitTestBehavior.translucent,
            child: Container(
              height: context.theme.appBarTheme.toolbarHeight ?? 44,
              padding: EdgeInsets.only(right: Dimens.gap_dp15),
              alignment: Alignment.center,
              child: Text(
                '取消',
                style: body2Style(),
              ),
            ),
          )
        ],
      ),
      body: Stack(
        children: [
          SearchHistoryView(
            onSelected: (word) {
              controller.search(word);
            },
            axis: Axis.vertical,
          ),
          SingleSearchSuggest(),
          SingleSearchResult()
        ],
      ),
    );
  }

  //
  Widget _buildSearchTitle(BuildContext context) {
    return Hero(
      tag: SINGLE_SEARCH,
      child: Container(
        height: Dimens.gap_dp38,
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: Dimens.gap_dp15),
        decoration: BoxDecoration(
          color: context.isDarkMode ? Colors.white12 : Colours.color_245,
          borderRadius: BorderRadius.all(
            Radius.circular(Dimens.gap_dp18),
          ),
        ),
        child: TextField(
          controller: controller.editingController,
          focusNode: controller.focusNode,
          style: headlineStyle().copyWith(
              fontWeight: FontWeight.normal, fontSize: Dimens.font_sp16),
          decoration: InputDecoration(
              border: InputBorder.none,
              constraints: BoxConstraints(maxHeight: Dimens.gap_dp38),
              prefixIcon: Icon(
                Icons.search_rounded,
                color: Colours.color_156,
                size: Dimens.gap_dp20,
              ),
              hintStyle: TextStyle(
                  fontSize: Dimens.font_sp14,
                  color: Colours.text_gray,
                  fontWeight: FontWeight.normal),
              hintText: '搜索歌曲'),
          onEditingComplete: () {
            controller.search(controller.keywordsValue);
          },
          textInputAction: TextInputAction.search,
          onChanged: (word) {
            controller.searchSuggest(word);
          },
        ),
      ),
    );
  }
}
