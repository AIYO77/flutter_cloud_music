import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/model/song_model.dart';
import 'package:flutter_cloud_music/common/res/colors.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/res/gaps.dart';
import 'package:flutter_cloud_music/common/utils/adapt.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';
import 'package:flutter_cloud_music/pages/singer_detail/state.dart';
import 'package:flutter_cloud_music/widgets/follow/follow_widget.dart';
import 'package:get/get.dart';

import '../logic.dart';

class SingerHeader extends StatelessWidget {
  final SingerDetailLogic controller;

  const SingerHeader(this.controller);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        //顶部背景
        _buildTopBg(controller.state),
        //card
        Container(
          width: double.infinity,
          margin: EdgeInsets.fromLTRB(
              Dimens.gap_dp16, Adapt.px(238), Dimens.gap_dp16, 0),
          padding: EdgeInsets.only(
              top: controller.state.getAvatarUrl().isEmpty
                  ? Dimens.gap_dp17
                  : Dimens.gap_dp42,
              bottom: Dimens.gap_dp15),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Get.theme.cardColor.withOpacity(0.95),
                    Get.theme.cardColor,
                    Get.theme.cardColor
                  ]),
              boxShadow: [
                BoxShadow(
                    color: Get.theme.shadowColor,
                    offset: const Offset(0, 5),
                    blurRadius: 12.0)
              ],
              borderRadius: BorderRadius.all(Radius.circular(Dimens.gap_dp16))),
          child: _buildCardContent(),
        ),

        //头像
        if (controller.state.getAvatarUrl().isNotEmpty)
          Positioned(
              top: Adapt.px(238 - 71 / 2),
              child: ClipOval(
                child: CachedNetworkImage(
                  imageUrl: ImageUtils.getImageUrlFromSize(
                      controller.state.getAvatarUrl(),
                      Size(Dimens.gap_dp105, Dimens.gap_dp105)),
                  placeholder: (context, url) {
                    return Container(
                      color: Colours.load_image_placeholder(),
                    );
                  },
                  fit: BoxFit.cover,
                  width: Adapt.px(71),
                  height: Adapt.px(71),
                ),
              ))
      ],
    );
  }

  ///顶部背景
  Widget _buildTopBg(SingerDetailState state) {
    return ClipPath(
      clipper: _CoverImgRect(),
      child: CachedNetworkImage(
        imageUrl: state.getBackgroundUrl(),
        width: Adapt.screenW(),
        height: Dimens.gap_dp260,
        fit: BoxFit.cover,
        placeholder: (c, s) {
          return Image.asset(
            ImageUtils.getImagePath('img_singer_pl', format: 'jpg'),
            width: Adapt.screenW(),
            fit: BoxFit.cover,
            height: Dimens.gap_dp260,
          );
        },
        errorWidget: (c, s, e) {
          return Image.asset(
            ImageUtils.getImagePath('img_singer_pl', format: 'jpg'),
            width: Adapt.screenW(),
            fit: BoxFit.cover,
            height: Dimens.gap_dp260,
          );
        },
      ),
    );
  }

  ///卡片里的内容
  Widget _buildCardContent() {
    return Column(
      children: [
        //姓名
        RichText(
          textAlign: TextAlign.center,
          maxLines: 1,
          text: TextSpan(
            children: [
              TextSpan(
                  text: controller.state.getName(),
                  style: headlineStyle().copyWith(
                      fontSize: Dimens.font_sp18, fontWeight: FontWeight.w700)),
              if (controller.state.getIdentify()?.imageUrl != null)
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: Padding(
                    padding: EdgeInsets.only(left: Dimens.gap_dp5),
                    child: CachedNetworkImage(
                      width: Dimens.gap_dp17,
                      height: Dimens.gap_dp17,
                      imageUrl: controller.state.getIdentify()!.imageUrl!,
                    ),
                  ),
                )
            ],
          ),
        ),
        Gaps.vGap10,
        //关注 粉丝 等级
        if (controller.state.getLevel().isNotEmpty)
          Padding(
            padding: EdgeInsets.only(bottom: Dimens.gap_dp10),
            child: Text(
              controller.state.getLevel(),
              style: captionStyle().copyWith(fontSize: Dimens.font_sp13),
            ),
          ),
        //歌手标签
        Text(
          controller.state.getIdentify()?.imageDesc ?? '',
          style: captionStyle().copyWith(fontSize: Dimens.font_sp13),
        ),
        Gaps.vGap15,
        //关注按钮和相关歌手控制按钮
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: Dimens.gap_dp30,
              width: Dimens.gap_dp80,
              child: FollowWidget(
                Key(controller.state.getUserId().toString()),
                id: controller.state.getUserId().toString(),
                isSolidWidget: true,
                isSinger: controller.state.isSinger(),
                isFollowed: controller.state.isFollow(),
                isFollowedCallback: (isFollowed) {
                  if (isFollowed) {
                    controller.state.startAnim();
                  }
                },
              ),
            ),
            if (controller.state.isSinger())
              GestureDetector(
                onTap: () {
                  controller.state.startAnim();
                },
                behavior: HitTestBehavior.translucent,
                child: Container(
                  width: Dimens.gap_dp30,
                  height: Dimens.gap_dp30,
                  margin: EdgeInsets.only(left: Dimens.gap_dp5),
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.all(Radius.circular(Dimens.gap_dp15)),
                    border: Border.all(
                      color: Get.theme.dividerColor.withOpacity(0.6),
                    ),
                  ),
                  padding: EdgeInsets.all(Dimens.gap_dp5),
                  child: Obx(() => Transform.rotate(
                        angle: (pi / 2) *
                            (-1 + 2 * controller.state.animValue.value),
                        child: Image.asset(
                          ImageUtils.getImagePath('icon_more'),
                          color: Get.textTheme.subtitle1?.color ?? Colors.black,
                        ),
                      )),
                ),
              )
          ],
        ),
        //如果是歌手 相识歌手推荐
        if (controller.state.isSinger())
          Obx(
            () => ClipRect(
              child: Align(
                alignment: Alignment.topCenter,
                heightFactor: controller.state.animValue.value,
                child: Container(
                  width: double.infinity,
                  height: Adapt.px(137 + 15),
                  padding: EdgeInsets.only(top: Dimens.gap_dp15),
                  child: Opacity(
                    opacity: controller.state.animValue.value,
                    child: _simiListView(controller.state.simiItems.value),
                  ),
                ),
              ),
            ),
          )
      ],
    );
  }

  ///相似歌手推荐listview
  Widget _simiListView(List<Ar>? items) {
    return ListView.separated(
      padding: EdgeInsets.only(left: Dimens.gap_dp15, right: Dimens.gap_dp15),
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        final item = items!.elementAt(index);
        return GestureDetector(
          onTap: () {
            toUserDetail(artistId: item.id, accountId: item.accountId);
          },
          child: Container(
            height: Adapt.px(137),
            width: Dimens.gap_dp95,
            alignment: Alignment.topCenter,
            decoration: BoxDecoration(
              color:
                  Get.isDarkMode ? const Color(0xff292929) : Colours.color_248,
              borderRadius: BorderRadius.all(
                Radius.circular(Dimens.gap_dp10),
              ),
            ),
            child: Column(
              children: [
                Gaps.vGap10,
                //头像
                ClipOval(
                  child: CachedNetworkImage(
                    width: Dimens.gap_dp45,
                    fit: BoxFit.cover,
                    imageUrl: ImageUtils.getImageUrlFromSize(
                        item.picUrl, Size(Dimens.gap_dp50, Dimens.gap_dp50)),
                    placeholder: (context, url) {
                      return Container(
                        color: Colours.load_image_placeholder(),
                      );
                    },
                  ),
                ),
                Gaps.vGap7,
                //name
                Padding(
                  padding: EdgeInsets.only(
                      left: Dimens.gap_dp10, right: Dimens.gap_dp10),
                  child: Text(
                    item.getNameStr() ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:
                        headline1Style().copyWith(fontSize: Dimens.font_sp12),
                  ),
                ),
                Gaps.vGap3,
                //fansCount
                Text(
                  '${getFansCountStr(item.fansCount)}粉丝',
                  style: captionStyle().copyWith(fontSize: Dimens.font_sp11),
                ),
                Gaps.vGap8,
                //follow btn
                SizedBox(
                  width: Dimens.gap_dp60,
                  height: Dimens.gap_dp26,
                  child: FollowWidget(Key(item.accountId.toString()),
                      id: item.id.toString(),
                      isFollowed: item.followed ?? false),
                )
              ],
            ),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return Gaps.hGap10;
      },
      itemCount: items?.length ?? 0,
    );
  }
}

class _CoverImgRect extends CustomClipper<Path> {
  final roundnessFactor = 10;

  @override
  Path getClip(Size size) {
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
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
