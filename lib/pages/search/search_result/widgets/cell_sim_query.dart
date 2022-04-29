import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:flutter_cloud_music/pages/search/search_result/model/search_sim_query.dart';
import 'package:flutter_cloud_music/widgets/rich_text_widget.dart';
import 'package:get/get.dart';

import '../../../../common/res/colors.dart';
import '../../../../common/res/dimens.dart';

/// Creator: Xing Wei
/// Email: 654206017@qq.com
/// Date: 2022/4/29 5:28 下午
/// Des:
class SearchSimQueryCell extends StatelessWidget {
  final KeywordValue keywordValue;

  final String keywords;

  const SearchSimQueryCell(
      {required this.keywordValue, required this.keywords});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: Dimens.gap_dp32,
        decoration: BoxDecoration(
          color: context.isDarkMode ? Colors.white12 : Colours.color_248,
          borderRadius: BorderRadius.circular(Dimens.gap_dp16),
        ),
        alignment: Alignment.center,
        child: RichTextWidget(
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
    );
  }
}
