import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_cloud_music/common/res/colors.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/utils/adapt.dart';
import 'package:flutter_cloud_music/pages/playlist_detail/playlist_detail_controller.dart';
import 'package:flutter_cloud_music/widgets/general_blur_image.dart';
import 'package:flutter_cloud_music/widgets/generral_cover_playcount.dart';
import 'package:get/get.dart';

class PlaylistSliverHeaderDelegate extends SliverPersistentHeaderDelegate {
  final controller = Get.find<PlaylistDetailController>();

  double expendHeight;
  double minHeight;

  PlaylistSliverHeaderDelegate(
      {required this.expendHeight, required this.minHeight});
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final double mainHeight = maxExtent - shrinkOffset; //动态高度
    final offset = mainHeight / maxExtent;
    Get.log('mainHeight = $mainHeight  offset = $offset');
    return ClipPath(
        clipper: _MyCoverRect(offset: offset), child: _buildTopConver(offset));
  }

  @override
  double get maxExtent => expendHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;

  Widget _buildTopConver(double offset) {
    return controller.secondOpenOfficial
        ? _buildOfficialCover(offset)
        : _buildNormalCover(offset);
  }

  //普通歌单头部
  Widget _buildNormalCover(double offset) {
    return Obx(
      () => Stack(
        children: [
          //背景
          SizedBox(
            width: Adapt.screenW(),
            height: expendHeight,
            child: controller.coverImage.value == null
                ? Container(
                    color: Colours.load_image_placeholder,
                  )
                : GeneralBlurImage(
                    image: controller.coverImage.value!,
                    sigma: 70,
                  ),
          ),
          //信息
          Positioned(
            bottom: 56,
            left: Dimens.gap_dp15,
            child: Opacity(
              opacity: offset,
              child: Row(
                children: [
                  Expanded(
                      child: GenrralCoverPlayCount(
                    imageUrl:
                        controller.detail.value?.playlist.coverImgUrl ?? '',
                    playCount: controller.detail.value?.playlist.playCount ?? 0,
                    coverSize: const Size(122, 122),
                    coverRadius: Dimens.gap_dp8,
                    imageCallback: (provider) async {
                      await Future.delayed(const Duration(milliseconds: 100));
                      controller.coverImage.value = provider;
                    },
                  )),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          controller.detail.value?.playlist.name ?? '',
                          style: TextStyle(
                              fontSize: Dimens.font_sp16,
                              color: Get.isDarkMode
                                  ? Colours.color_109
                                  : Colours.white),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  //官方歌单非首次打开头部
  Widget _buildOfficialCover(double offset) {
    return Obx(
      () => Stack(
        children: [
          //背景
          Positioned.fill(
            child: CachedNetworkImage(
              errorWidget: (context, url, e) {
                return Container(
                  color: Colours.load_image_placeholder,
                );
              },
              placeholder: (context, url) {
                return Container(
                  color: Colours.load_image_placeholder,
                );
              },
              imageUrl:
                  controller.detail.value?.playlist.backgroundCoverUrl ?? '',
              imageBuilder: (context, provider) {
                return Stack(
                  children: [
                    Image(
                      width: Adapt.screenW(),
                      height: expendHeight,
                      image: provider,
                      fit: BoxFit.cover,
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _MyCoverRect extends CustomClipper<Path> {
  double offset;

  _MyCoverRect({required this.offset});

  @override
  Path getClip(Size size) {
    final roundnessFactor = offset * 10;
    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(0, size.height - roundnessFactor);
    //二阶贝塞尔弧
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - roundnessFactor);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
