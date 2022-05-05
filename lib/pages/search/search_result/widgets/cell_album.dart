import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/res/gaps.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:flutter_cloud_music/routes/app_routes.dart';
import 'package:flutter_cloud_music/widgets/custom_tap.dart';
import 'package:flutter_cloud_music/widgets/rich_text_widget.dart';
import 'package:get/get.dart';

import '../../../../common/model/album_detail.dart';
import '../../../../common/utils/adapt.dart';
import '../../../../common/utils/image_utils.dart';

/// Creator: Xing Wei
/// Email: 654206017@qq.com
/// Date: 2022/4/29 2:30 下午
/// Des:

class SearchAlbumCell extends StatelessWidget {
  final Album album;

  final String keywords;

  const SearchAlbumCell({required this.album, required this.keywords});

  @override
  Widget build(BuildContext context) {
    return Bounce(
      onPressed: () {
        Get.toNamed(Routes.ALBUM_DETAIL_ID(album.id.toString()));
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: Dimens.gap_dp3),
        child: Row(
          children: [
            CachedNetworkImage(
              imageUrl: ImageUtils.getImageUrlFromSize(
                  album.picUrl, Size(Dimens.gap_dp50, Dimens.gap_dp50)),
              placeholder: placeholderWidget,
              errorWidget: errorWidget,
              height: Adapt.px(54.5),
              width: Adapt.px(54.5),
              imageBuilder: (context, provider) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      ImageUtils.getImagePath('cqb'),
                      height: Adapt.px(4.5),
                      fit: BoxFit.fill,
                    ),
                    ClipRRect(
                      borderRadius:
                          BorderRadius.all(Radius.circular(Dimens.gap_dp8)),
                      child: Image(
                        image: provider,
                        height: Dimens.gap_dp50,
                        width: Dimens.gap_dp50,
                      ),
                    )
                  ],
                );
              },
            ),
            Gaps.hGap10,
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichTextWidget(
                  Text(
                    album.name,
                    style: headline2Style(),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  richTexts: [
                    BaseRichText(
                      keywords,
                      style: headline2Style().copyWith(
                        color: context.theme.highlightColor,
                      ),
                    )
                  ],
                ),
                Gaps.vGap7,
                RichTextWidget(
                  Text(
                    (album.artists?.map((e) => e.name).join('/') ??
                            album.artist.name ??
                            '') +
                        album.timeStr(),
                    style: captionStyle(),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  richTexts: [
                    BaseRichText(
                      keywords,
                      style: captionStyle().copyWith(
                        color: context.theme.highlightColor,
                      ),
                    )
                  ],
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
