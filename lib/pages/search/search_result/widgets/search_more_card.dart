import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/res/gaps.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';
import 'package:get/get.dart';

import '../../../../widgets/rich_text_widget.dart';

/// Creator: Xing Wei
/// Email: 654206017@qq.com
/// Date: 2022/4/28 2:57 下午
/// Des:

class SearchMoreCard extends StatelessWidget {
  final String? moreText;
  final VoidCallback? onMoreTap;
  final String keywords;
  final String title;
  final Widget child;

  const SearchMoreCard({
    required this.keywords,
    required this.title,
    this.moreText,
    this.onMoreTap,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: Dimens.gap_dp16,
        right: Dimens.gap_dp16,
        top: Dimens.gap_dp16,
      ),
      decoration: BoxDecoration(
          color: context.theme.cardColor,
          borderRadius: BorderRadius.circular(Dimens.gap_dp8),
          border: Border.all(
              color: context.theme.dividerColor.withOpacity(0.2), width: 0.5),
          boxShadow: [
            BoxShadow(
                color: context.theme.shadowColor, blurRadius: Dimens.gap_dp6)
          ]),
      padding: EdgeInsets.only(
          top: Dimens.gap_dp18,
          bottom: GetUtils.isNullOrBlank(moreText)! ? Dimens.gap_dp18 : 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: headlineStyle(),
          ).paddingOnly(left: Dimens.gap_dp16, bottom: Dimens.gap_dp10),
          Expanded(child: child.paddingSymmetric(horizontal: Dimens.gap_dp16)),
          if (!GetUtils.isNullOrBlank(moreText)!) Gaps.line,
          if (!GetUtils.isNullOrBlank(moreText)!)
            Material(
              color: context.theme.cardColor,
              child: InkWell(
                onTap: onMoreTap,
                child: Container(
                  height: Dimens.gap_dp40,
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: Text.rich(
                    TextSpan(
                      children: [
                        WidgetSpan(
                            alignment: PlaceholderAlignment.middle,
                            child: RichTextWidget(
                              Text(
                                moreText!,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: captionStyle()
                                    .copyWith(fontSize: Dimens.font_sp13),
                              ),
                              richTexts: [
                                BaseRichText(
                                  keywords,
                                  style: TextStyle(
                                      fontSize: Dimens.font_sp13,
                                      color: context.theme.highlightColor),
                                )
                              ],
                            )),
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: Image.asset(
                            ImageUtils.getImagePath('icon_more'),
                            height: Dimens.gap_dp16,
                            color: captionStyle().color,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}
