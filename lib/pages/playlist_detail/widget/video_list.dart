/// Creator: Xing Wei
/// Email: 654206017@qq.com
/// Date: 2022/3/9 2:15 下午
/// Des:
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/res/colors.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/res/gaps.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';
import 'package:flutter_cloud_music/pages/playlist_detail/playlist_detail_controller.dart';
import 'package:flutter_cloud_music/services/auth_service.dart';
import 'package:flutter_cloud_music/widgets/music_loading.dart';
import 'package:get/get.dart';

import '../../../common/utils/time.dart';
import '../../../routes/app_routes.dart';
import '../../found/model/shuffle_log_model.dart';

class VideoListContent extends StatelessWidget {
  VideoListContent(this.videos, {required this.controller});

  List<MLogResource>? videos;

  final PlaylistDetailController controller;

  @override
  Widget build(BuildContext context) {
    if (controller.detail.value == null) {
      return SliverToBoxAdapter(
        child: Container(
            margin: EdgeInsets.only(top: Dimens.gap_dp95),
            child: MusicLoading(
              axis: Axis.horizontal,
            )),
      );
    } else {
      final subs = controller.detail.value?.playlist.subscribers;
      return (GetUtils.isNullOrBlank(videos) == true &&
              controller.detail.value!.playlist.creator.userId ==
                  AuthService.to.userId)
          ? _buildAddVideoBtn()
          : SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                if (videos!.length > index) {
                  return _item(index, videos!.elementAt(index));
                } else {
                  return Container(
                    height: Dimens.gap_dp58,
                    color: Get.theme.cardColor,
                    child: Row(
                      children: [
                        Gaps.hGap10,
                        Expanded(
                          child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                final user = subs!.elementAt(index);
                                return buildUserAvatar(user.avatarUrl,
                                    Size(Dimens.gap_dp30, Dimens.gap_dp30));
                              },
                              separatorBuilder: (context, index) {
                                return Gaps.hGap10;
                              },
                              itemCount: subs?.length ?? 0),
                        ),
                        Text(
                          '${getPlayCountStrFromInt(controller.detail.value?.playlist.subscribedCount ?? 0)}人收藏',
                          style: TextStyle(
                              color: Colours.color_177,
                              fontSize: Dimens.font_sp13),
                        ),
                        Image.asset(
                          ImageUtils.getImagePath('icon_more'),
                          height: Dimens.gap_dp20,
                          color: Colours.color_195,
                        ),
                        Gaps.hGap10,
                      ],
                    ),
                  );
                }
              },
                  childCount: videos?.length ??
                      0 + (GetUtils.isNullOrBlank(subs) == true ? 0 : 1)),
            );
    }
  }

  Widget _item(int index, MLogResource video) {
    return GestureDetector(
      onTap: () {},
      child: SizedBox(
        height: Dimens.gap_dp61,
        width: double.infinity,
        child: Row(
          children: [
            SizedBox(
              width: Dimens.gap_dp42,
              child: Center(
                child: AutoSizeText(
                  '${index + 1}',
                  maxLines: 1,
                  style: TextStyle(
                      fontSize: Dimens.font_sp16,
                      color: Get.isDarkMode
                          ? Colours.white.withOpacity(0.4)
                          : Colours.color_156),
                ),
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(Dimens.gap_dp5)),
              child: CachedNetworkImage(
                imageUrl: video.mlogBaseData.coverUrl,
                placeholder: placeholderWidget,
                errorWidget: errorWidget,
                height: Dimens.gap_dp84,
                width: Dimens.gap_dp150,
                imageBuilder: (context, image) {
                  return Container(
                    height: Dimens.gap_dp84,
                    width: Dimens.gap_dp150,
                    color: Colors.black,
                    child: Stack(
                      children: [
                        Image(
                          image: image,
                          height: Dimens.gap_dp84,
                          width: Dimens.gap_dp150,
                          fit: BoxFit.cover,
                        ),
                        Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              height: Dimens.gap_dp30,
                              decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                    Colors.transparent,
                                    Colors.black38
                                  ])),
                              alignment: Alignment.bottomRight,
                              padding: EdgeInsets.only(
                                  right: Dimens.gap_dp8,
                                  bottom: Dimens.gap_dp8),
                              child: Text(
                                getTimeStamp(video.mlogBaseData.duration),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: Dimens.font_sp9),
                              ),
                            ))
                      ],
                    ),
                  );
                },
              ),
            ),
            Gaps.hGap10,
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  video.mlogBaseData.text,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: body1Style().copyWith(fontSize: Dimens.font_sp16),
                ),
                Gaps.vGap2,
                Text(
                  'by ${video.userProfile?.nickname}',
                  style: captionStyle().copyWith(fontSize: Dimens.font_sp12),
                )
              ],
            )),
            GestureDetector(
              onTap: () {},
              child: SizedBox(
                width: Dimens.gap_dp36,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Image.asset(
                    ImageUtils.getImagePath('cb'),
                    height: Dimens.gap_dp24,
                    color: Get.isDarkMode
                        ? Colours.white.withOpacity(0.6)
                        : Colours.color_187,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  //自己创建的歌单
  Widget _buildAddVideoBtn() {
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.only(top: Dimens.gap_dp50),
        child: CupertinoButton(
            child: Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: Dimens.gap_dp70),
              alignment: Alignment.center,
              height: Dimens.gap_dp40,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.all(Radius.circular(Dimens.gap_dp20)),
                  border: Border.all(color: Colours.app_main_light)),
              child: Text(
                '添加视频',
                style: TextStyle(
                    color: Colours.app_main_light,
                    fontWeight: FontWeight.w500,
                    fontSize: Dimens.font_sp16),
              ),
            ),
            onPressed: () {
              Get.toNamed(Routes.ADD_VIDEO, arguments: controller.playlistId);
            }),
      ),
    );
  }
}
