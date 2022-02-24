import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/utils/adapt.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../index.dart';

class RecmHeader extends GetView<RcmdSongDayController> {
  @override
  Widget build(BuildContext context) {
    final expandHeight = Adapt.px(237) + Adapt.topPadding();
    return SliverPersistentHeader(
        pinned: true,
        delegate: _MySliverDelegate(
          maxHeight: expandHeight,
          minHeight: Dimens.gap_dp45 + Adapt.topPadding(),
        ));
  }
}

class _MySliverDelegate extends SliverPersistentHeaderDelegate {
  final double maxHeight;
  final double minHeight;

  const _MySliverDelegate({required this.maxHeight, required this.minHeight});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final double mainHeight = maxExtent - shrinkOffset; //动态高度
    final offset = mainHeight / maxExtent;

    return SizedBox.expand(
      child: ClipPath(
        clipper: _MyRect(offset: offset),
        child: Stack(
          children: [
            Positioned.fill(
                child: Image.asset(
              ImageUtils.getImagePath('icn_rcmd_bg', format: 'jpg'),
              height: maxHeight,
              fit: BoxFit.cover,
            )),
            Positioned(
                top: 0,
                child: SizedBox(
                  width: Adapt.screenW(),
                  height: minHeight,
                  child: AppBar(
                    toolbarHeight: minHeight,
                    centerTitle: true,
                    backgroundColor: Colors.transparent,
                    title: Opacity(
                        opacity: 1.0 - offset,
                        child: Text(
                          '每日推荐',
                          style: Get.theme.appBarTheme.titleTextStyle
                              ?.copyWith(color: Colors.white),
                        )),
                  ),
                )),
            Positioned(
                left: Dimens.gap_dp16,
                bottom: Dimens.gap_dp45,
                child: Opacity(
                  opacity: offset == 1.0
                      ? 1.0
                      : offset <= 0.6
                          ? 0
                          : 0.5,
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: DateTime.now().day.toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: Dimens.font_sp35,
                                shadows: const [
                                  BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 10,
                                      spreadRadius: 5,
                                      offset: Offset(0, 4))
                                ],
                                fontWeight: FontWeight.w700)),
                        TextSpan(
                            text:
                                ' / ${DateFormat('MM').format(DateTime.now())}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: Dimens.font_sp15,
                              fontWeight: FontWeight.w500,
                              shadows: const [
                                BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 10,
                                    spreadRadius: 5,
                                    offset: Offset(0, 4))
                              ],
                            ))
                      ],
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }

  @override
  double get maxExtent => max(minHeight, maxHeight);

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(covariant _MySliverDelegate oldDelegate) {
    return false;
  }
}

//底部弧线裁剪
class _MyRect extends CustomClipper<Path> {
  final double offset;

  _MyRect({required this.offset});

  @override
  Path getClip(Size size) {
    final roundnessFactor = offset * 12;
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
