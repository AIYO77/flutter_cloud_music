import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/res/colors.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/res/gaps.dart';
import 'package:flutter_cloud_music/common/utils/adapt.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';
import 'package:flutter_cloud_music/pages/playlist_detail/playlist_detail_controller.dart';
import 'package:flutter_cloud_music/pages/playlist_detail/widget/follow_widget.dart';
import 'package:flutter_cloud_music/widgets/generral_cover_playcount.dart';
import 'package:get/get.dart';

class TopNormalInfo extends StatelessWidget {
  final controller = Get.find<PlaylistDetailController>();

  TopNormalInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        children: [
          GenrralCoverPlayCount(
            imageUrl: controller.detail.value?.playlist.coverImgUrl ?? '',
            playCount: controller.detail.value?.playlist.playCount ?? 0,
            coverSize: const Size(122, 122),
            coverRadius: Dimens.gap_dp8,
            imageCallback: (provider) async {
              await Future.delayed(const Duration(milliseconds: 100));
              controller.coverImage.value = provider;
            },
          ),
          Gaps.hGap14,
          Expanded(
            child: SizedBox(
              height: 122,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //name
                  if (controller.detail.value?.playlist.name != null)
                    Text(
                      controller.detail.value?.playlist.name ?? '',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 16,
                          color: Get.isDarkMode
                              ? Colours.white.withOpacity(0.9)
                              : Colours.white),
                    ),
                  //creator
                  Expanded(
                      child: Container(
                    alignment: Alignment.topLeft,
                    margin: const EdgeInsets.only(top: 12),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                            onTap: () {
                              toUserDetail(
                                  accountId: controller
                                      .detail.value?.playlist.creator.userId);
                            },
                            child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(children: [
                                  WidgetSpan(
                                      alignment: PlaceholderAlignment.middle,
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            ImageUtils.getImageUrlFromSize(
                                                controller
                                                    .detail
                                                    .value
                                                    ?.playlist
                                                    .creator
                                                    .avatarUrl,
                                                Size(Dimens.gap_dp25,
                                                    Dimens.gap_dp25)),
                                        errorWidget: (context, url, e) {
                                          return Gaps.ovalImgHolder(
                                              const Size(25, 25));
                                        },
                                        placeholder: (context, url) {
                                          return Gaps.ovalImgHolder(
                                              const Size(25, 25));
                                        },
                                        imageBuilder: (context, provider) {
                                          final user = controller
                                              .detail.value?.playlist.creator;
                                          return SizedBox(
                                            width: user?.avatarDetail == null
                                                ? 25
                                                : 30,
                                            height: 25,
                                            child: Stack(
                                              alignment: Alignment.topLeft,
                                              children: [
                                                ClipOval(
                                                  child: Image(
                                                    image: provider,
                                                    width: 25,
                                                    height: 25,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                if (user?.avatarDetail != null)
                                                  Positioned(
                                                    bottom: 0,
                                                    right: 0,
                                                    child: ClipOval(
                                                      child: CachedNetworkImage(
                                                          width: 12,
                                                          height: 12,
                                                          imageUrl: user!
                                                              .avatarDetail!
                                                              .identityIconUrl),
                                                    ),
                                                  )
                                              ],
                                            ),
                                          );
                                        },
                                      )),
                                  WidgetSpan(child: Gaps.hGap2),
                                  TextSpan(
                                      text: controller.detail.value?.playlist
                                          .creator.nickname,
                                      style: TextStyle(
                                          fontSize: 13,
                                          color:
                                              Colours.white.withOpacity(0.7))),
                                ]))),
                        Gaps.hGap1,
                        //focuse creator
                        if (controller.detail.value?.playlist.creator != null)
                          CreatorFollowWidget(
                            followed: controller
                                .detail.value!.playlist.creator.followed,
                          )
                      ],
                    ),
                  )),
                  //description
                  Expanded(
                    flex: 0,
                    child: Row(
                      children: [
                        ConstrainedBox(
                            constraints:
                                BoxConstraints(maxWidth: Adapt.px(160)),
                            child: Text(
                              //所有的空白和换行 换成默认空白
                              controller.detail.value?.playlist.description
                                      ?.replaceAll(
                                          RegExp(r'\s+\b|\b\s|\n'), ' ') ??
                                  '暂无简介',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colours.white.withOpacity(0.7)),
                            )),
                        Image.asset(
                          ImageUtils.getImagePath('icon_more'),
                          height: 13,
                          width: 13,
                          color: Colours.white.withOpacity(0.65),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
