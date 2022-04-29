import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/model/search_suggest.dart';
import 'package:flutter_cloud_music/common/res/colors.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/res/gaps.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';
import 'package:flutter_cloud_music/typedef/function.dart';
import 'package:flutter_cloud_music/widgets/rich_text_widget.dart';
import 'package:get/get.dart';

/// Creator: Xing Wei
/// Email: 654206017@qq.com
/// Date: 2022/3/14 1:49 下午
/// Des:
class SearchSuggestList extends StatelessWidget {
  final List<SearchSuggest>? list;

  final String keyWords;

  final ParamSingleCallback<String> itemOnTap;

  const SearchSuggestList(this.list,
      {required this.keyWords, required this.itemOnTap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.cardColor,
      body: list == null
          ? Gaps.empty
          : list!.isEmpty
              ? GestureDetector(
                  onTap: () {
                    itemOnTap.call(keyWords);
                  },
                  behavior: HitTestBehavior.translucent,
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: Dimens.gap_dp16),
                    margin: EdgeInsets.symmetric(horizontal: Dimens.gap_dp15),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom:
                                BorderSide(color: context.theme.dividerColor))),
                    child: Text(
                      '搜索 “$keyWords”',
                      style: TextStyle(
                          color: context.theme.highlightColor,
                          fontSize: Dimens.font_sp16),
                    ),
                  ))
              : _buildList(context),
    );
  }

  Widget _buildList(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        final item = list!.elementAt(index);
        return GestureDetector(
          onTap: () {
            itemOnTap.call(item.keyword);
          },
          behavior: HitTestBehavior.translucent,
          child: SizedBox(
            height: Dimens.gap_dp42,
            width: double.infinity,
            child: Row(
              children: [
                Gaps.hGap15,
                Image.asset(
                  ImageUtils.getImagePath('list_search'),
                  width: Dimens.gap_dp14,
                  color:
                      context.isDarkMode ? Colors.white30 : Colours.color_187,
                ),
                Gaps.hGap8,
                Expanded(
                    child: Column(
                  children: [
                    Expanded(
                        child: Align(
                      alignment: Alignment.centerLeft,
                      child: RichTextWidget(
                        Text(
                          item.keyword,
                          style:
                              body1Style().copyWith(fontSize: Dimens.font_sp14),
                        ),
                        richTexts: [
                          BaseRichText(
                            keyWords,
                            style: TextStyle(
                                fontSize: Dimens.font_sp14,
                                color: Colours.color_165),
                          )
                        ],
                      ),
                    )),
                    Gaps.line
                  ],
                ))
              ],
            ),
          ),
        );
      },
      itemCount: list!.length,
    );
  }
}
