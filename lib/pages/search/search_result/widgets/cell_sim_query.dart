import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:flutter_cloud_music/pages/search/search_result/model/search_sim_query.dart';
import 'package:flutter_cloud_music/widgets/rich_text_widget.dart';
import 'package:get/get.dart';

import '../../../../common/res/colors.dart';
import '../../../../common/res/dimens.dart';
import '../../logic.dart';

/// Creator: Xing Wei
/// Email: 654206017@qq.com
/// Date: 2022/4/29 5:28 下午
/// Des:
class SearchSimQueryCell extends StatelessWidget {
  final logic = GetInstance().find<SearchLogic>();

  final KeywordValue keywordValue;

  final String keywords;

  SearchSimQueryCell({required this.keywordValue, required this.keywords});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        logic.search(keywordValue.keyword);
      },
      behavior: HitTestBehavior.translucent,
      child: SizedBox(
        height: Dimens.gap_dp32,
        child: Chip(
          labelPadding: EdgeInsets.symmetric(horizontal: Dimens.gap_dp14),
          backgroundColor:
              context.isDarkMode ? Colors.white12 : Colours.color_248,
          label: RichTextWidget(
            Text(
              keywordValue.keyword,
              style: body1Style(),
            ),
            richTexts: [
              BaseRichText(
                keywords,
                style: body1Style().copyWith(
                  color: context.theme.highlightColor,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
