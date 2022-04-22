import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/res/colors.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/utils/adapt.dart';
import 'package:flutter_cloud_music/pages/playlist_detail/playlist_detail_controller.dart';
import 'package:flutter_cloud_music/pages/playlist_detail/widget/top_normal_info.dart';
import 'package:flutter_cloud_music/pages/playlist_detail/widget/top_official_info.dart';
import 'package:flutter_cloud_music/widgets/general_blur_image.dart';
import 'package:get/get.dart';

import '../../../enum/enum.dart';

class PlaylistSliverHeaderDelegate extends SliverPersistentHeaderDelegate {
  final PlaylistDetailController controller;

  double expendHeight;
  double minHeight;

  PlaylistSliverHeaderDelegate(
      {required this.controller,
      required this.expendHeight,
      required this.minHeight});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final double mainHeight = maxExtent - shrinkOffset; //动态高度
    final offset = mainHeight / maxExtent;
    if (controller.detail.value != null) {
      if (offset <= 0.325) {
        controller.titleStatus.value = PlayListTitleStatus.TitleAndBtn;
      } else if (offset >= 0.75) {
        controller.titleStatus.value = PlayListTitleStatus.Normal;
      } else {
        controller.titleStatus.value = PlayListTitleStatus.Title;
      }
    }
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
    return Stack(
      children: [
        //背景
        SizedBox(
          width: Adapt.screenW(),
          height: expendHeight,
          child: Obx(() => (controller.coverImage.value == null)
              ? Container(
                  color:
                      Get.isDarkMode ? Colors.transparent : Colours.color_163,
                )
              : GeneralBlurImage(
                  image: controller.coverImage.value!,
                  sigma: 70,
                  height: expendHeight,
                )),
        ),
        //信息
        Positioned(
          bottom: 50,
          right: Dimens.gap_dp26,
          left: Dimens.gap_dp15,
          child: _buildClipContent(
              TopNormalInfo(
                key: controller.topContentKey,
                controller: controller,
              ),
              offset),
        )
      ],
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
                  color: Colours.load_image_placeholder(),
                );
              },
              placeholder: (context, url) {
                return Container(
                  color: Colours.load_image_placeholder(),
                );
              },
              fit: BoxFit.cover,
              height: expendHeight,
              fadeInDuration: const Duration(milliseconds: 200),
              imageUrl:
                  controller.detail.value?.playlist.backgroundCoverUrl ?? '',
            ),
          ),
          if (controller.detail.value?.playlist.titleImageUrl != null)
            Positioned(
                left: 18,
                right: 18,
                bottom: Dimens.gap_dp40,
                child: _buildClipContent(
                    TopOfficialInfoWidget(
                      key: controller.topContentKey,
                      controller: controller,
                    ),
                    offset)),
        ],
      ),
    );
  }

  Widget _buildClipContent(Widget child, double offset) {
    return ClipRect(
      clipper: _MyContentRect(
          yOffset: controller.clipOffset(), scrollOffset: offset),
      clipBehavior: Clip.antiAlias,
      child: Opacity(
        opacity: offset,
        child: child,
      ),
    );
  }
}

//滑动时 内容超过appbar裁剪
class _MyContentRect extends CustomClipper<Rect> {
  double yOffset;
  double scrollOffset;

  _MyContentRect({required this.yOffset, required this.scrollOffset});

  @override
  Rect getClip(Size size) {
    double topClip = 0.0;
    if (scrollOffset == 0.0) {
      //收起
      topClip = size.height;
    } else if (scrollOffset == 1.0) {
      //展开
      topClip = 0.0;
    } else {
      //中间状态
      topClip = yOffset <= 0 ? 0.0 : yOffset;
    }

    return Rect.fromLTRB(0, topClip, size.width, size.height);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) => true;
}

//底部弧线裁剪
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
