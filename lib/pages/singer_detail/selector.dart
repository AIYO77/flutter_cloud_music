import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/model/song_model.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/res/gaps.dart';
import 'package:flutter_cloud_music/common/utils/adapt.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';
import 'package:flutter_cloud_music/widgets/follow/follow_widget.dart';
import 'package:get/get.dart';

/// Creator: Xing Wei
/// Email: 654206017@qq.com
/// Date: 2022/2/24 4:43 下午
/// Des:

Future<void> launchArtistDetailPage(
    BuildContext context, List<Ar>? artists) async {
  if (artists == null || artists.isEmpty) {
    return;
  }
  if (artists.length == 1) {
    toUserDetail(artistId: artists.first.id);
  } else {
    Get.bottomSheet(ClipRRect(
      borderRadius: BorderRadius.only(
          topRight: Radius.circular(Dimens.gap_dp15),
          topLeft: Radius.circular(Dimens.gap_dp15)),
      child: SizedBox(
        height: Dimens.gap_dp32 + artists.length * Dimens.gap_dp60,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              color: Get.theme.scaffoldBackgroundColor,
              height: Dimens.gap_dp32,
              width: Adapt.screenW(),
              alignment: Alignment.bottomLeft,
              padding: EdgeInsets.only(
                  left: Dimens.gap_dp16, bottom: Dimens.gap_dp4),
              child: Text(
                '该歌曲有多个歌手',
                style: captionStyle().copyWith(fontSize: Dimens.font_sp14),
              ),
            ),
            Expanded(
                child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final ar = artists.elementAt(index);
                return Material(
                  color: Get.theme.cardColor,
                  child: InkWell(
                    onTap: () {
                      Get.back();
                      toUserDetail(artistId: ar.id);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(
                          left: Dimens.gap_dp6, right: Dimens.gap_dp16),
                      height: Dimens.gap_dp60,
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.all(
                                Radius.circular(Dimens.gap_dp5)),
                            child: CachedNetworkImage(
                              imageUrl: ImageUtils.getImageUrlFromSize(
                                  ar.picUrl,
                                  Size(Dimens.gap_dp60, Dimens.gap_dp60)),
                              placeholder: (context, url) {
                                return Image.asset(
                                  ImageUtils.getImagePath('img_singer_pl',
                                      format: 'jpg'),
                                  fit: BoxFit.cover,
                                );
                              },
                              height: Dimens.gap_dp50,
                              width: Dimens.gap_dp50,
                              errorWidget: (context, url, e) {
                                return Image.asset(
                                  ImageUtils.getImagePath('img_singer_pl',
                                      format: 'jpg'),
                                  fit: BoxFit.cover,
                                );
                              },
                            ),
                          ),
                          Gaps.hGap10,
                          Expanded(
                              child: Text(
                            ar.name ?? '',
                            style: body2Style(),
                          )),
                          SizedBox(
                            height: Dimens.gap_dp26,
                            width: Dimens.gap_dp64,
                            child: FollowWidget(
                              Key(ar.id.toString()),
                              id: ar.id.toString(),
                              isFollowed: ar.followed ?? false,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
              itemCount: artists.length,
            ))
          ],
        ),
      ),
    ));
  }
}
