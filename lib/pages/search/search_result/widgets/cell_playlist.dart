import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/model/simple_play_list_model.dart';
import 'package:flutter_cloud_music/widgets/rich_text_widget.dart';
import 'package:get/get.dart';

import '../../../../common/res/colors.dart';
import '../../../../common/res/dimens.dart';
import '../../../../common/res/gaps.dart';
import '../../../../common/utils/common_utils.dart';
import '../../../../common/utils/image_utils.dart';
import '../../../../routes/app_routes.dart';
import '../../../../widgets/custom_tap.dart';

/// Creator: Xing Wei
/// Email: 654206017@qq.com
/// Date: 2022/4/28 7:46 下午
/// Des:

class SearchPlaylistCell extends StatelessWidget {
  final SimplePlayListModel playlist;

  final String keywords;

  const SearchPlaylistCell({required this.playlist, required this.keywords});

  @override
  Widget build(BuildContext context) {
    return Bounce(
      onPressed: () {
        Get.toNamed(Routes.PLAYLIST_DETAIL_ID(playlist.id.toString()));
      },
      child: Container(
        width: double.infinity,
        // height: Dimens.gap_dp60,
        padding: EdgeInsets.symmetric(vertical: Dimens.gap_dp6),
        child: Row(
          children: [
            CachedNetworkImage(
              imageUrl: ImageUtils.getImageUrlFromSize(
                  playlist.coverImgUrl, Size(Dimens.gap_dp60, Dimens.gap_dp60)),
              placeholder: placeholderWidget,
              errorWidget: errorWidget,
              width: Dimens.gap_dp54,
              height: Dimens.gap_dp54,
              imageBuilder: (context, image) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: Dimens.gap_dp4,
                      width: Dimens.gap_dp54 * 0.77,
                      decoration: BoxDecoration(
                          color: context.isDarkMode
                              ? Colors.white.withOpacity(0.05)
                              : Colours.color_242,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(Dimens.gap_dp4),
                              topRight: Radius.circular(Dimens.gap_dp4))),
                    ),
                    ClipRRect(
                      borderRadius:
                          BorderRadius.all(Radius.circular(Dimens.gap_dp7)),
                      child: Image(
                        image: image,
                        height: Dimens.gap_dp50,
                      ),
                    )
                  ],
                );
              },
            ),
            Gaps.hGap10,
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                RichTextWidget(
                  Text(
                    playlist.name,
                    style: body1Style().copyWith(
                        fontSize: Dimens.font_sp15,
                        fontWeight: FontWeight.w500),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  richTexts: [
                    BaseRichText(
                      keywords,
                      style: TextStyle(
                          color: context.theme.highlightColor,
                          fontSize: Dimens.font_sp15),
                    )
                  ],
                ),
                Gaps.vGap7,
                RichTextWidget(
                  Text(
                    playlist.getCountAndBy(),
                    style: captionStyle(),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  richTexts: [
                    BaseRichText(
                      keywords,
                      style: TextStyle(
                        color: context.theme.highlightColor,
                        fontSize: captionStyle().fontSize,
                      ),
                    )
                  ],
                )
              ],
            )),
          ],
        ),
      ),
    );
  }
}
