import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/model/mine_playlist.dart';
import 'package:flutter_cloud_music/common/res/colors.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/res/gaps.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';
import 'package:flutter_cloud_music/routes/app_routes.dart';
import 'package:flutter_cloud_music/widgets/custom_tap.dart';
import 'package:flutter_cloud_music/widgets/my_dialog.dart';
import 'package:get/get.dart';

import 'dialog_intelligent.dart';

/// Creator: Xing Wei
/// Email: 654206017@qq.com
/// Date: 2022/3/4 3:04 下午
/// Des:

class MinePlaylistCell extends StatelessWidget {
  final MinePlaylist? playlist;

  const MinePlaylistCell(Key? key, {this.playlist}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Bounce(
      onPressed: () {
        if (playlist != null) {
          Get.toNamed(Routes.PLAYLIST_DETAIL_ID(playlist!.id.toString()));
        }
      },
      child: SizedBox(
        width: double.infinity,
        height: Dimens.gap_dp52,
        child: Row(
          children: [
            CachedNetworkImage(
              imageUrl: ImageUtils.getImageUrlFromSize(playlist?.coverImgUrl,
                  Size(Dimens.gap_dp60, Dimens.gap_dp60)),
              placeholder:
                  playlist != null ? placeholderWidget : _placeholderWidget,
              errorWidget: playlist != null ? errorWidget : _errorWidget,
              width: Dimens.gap_dp52,
              height: Dimens.gap_dp52,
              imageBuilder: (context, image) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: Dimens.gap_dp3,
                      width: Dimens.gap_dp38,
                      decoration: BoxDecoration(
                          color: context.isDarkMode
                              ? Colors.white.withOpacity(0.05)
                              : Colours.color_248,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(Dimens.gap_dp3),
                              topRight: Radius.circular(Dimens.gap_dp3))),
                    ),
                    ClipRRect(
                      borderRadius:
                          BorderRadius.all(Radius.circular(Dimens.gap_dp7)),
                      child: Stack(children: [
                        Image(
                          image: image,
                          height: Dimens.gap_dp49,
                        ),
                        if (playlist?.privacy == 10)
                          Positioned(
                              top: Dimens.gap_dp3,
                              right: Dimens.gap_dp3,
                              child: Container(
                                  width: Dimens.gap_dp14,
                                  height: Dimens.gap_dp14,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Colours.color_248,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(Dimens.gap_dp6))),
                                  child: Icon(
                                    Icons.lock_rounded,
                                    size: Dimens.gap_dp9,
                                    color: Colours.color_109,
                                  ))),
                        if (playlist?.isVideoPl() == true)
                          Positioned(
                              bottom: Dimens.gap_dp1,
                              right: Dimens.gap_dp1,
                              child: Image.asset(
                                ImageUtils.getImagePath('icn_list_tag_mv'),
                                color: Colours.white.withOpacity(0.8),
                                height: Dimens.gap_dp18,
                              ))
                      ]),
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
                Text(
                  (playlist == null || playlist!.isIntelligent())
                      ? '我喜欢的音乐'
                      : playlist!.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: body1Style().copyWith(fontSize: Dimens.font_sp15),
                ),
                Gaps.vGap7,
                Text(
                  playlist?.getCountAndBy() ?? '0首',
                  style: captionStyle(),
                )
              ],
            )),
            if (playlist == null || playlist!.isIntelligent())
              _buildIntelligent(context)
          ],
        ),
      ),
    );
  }

  ///心动模式按钮
  Widget _buildIntelligent(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.dialog(
            MyDialog(
              minWidth: Dimens.gap_dp156,
              child: IntelligentDialog(playlist?.id ?? -1),
            ),
            transitionCurve: Curves.fastLinearToSlowEaseIn,
            barrierColor: Colors.transparent,
            barrierDismissible: false);
      },
      behavior: HitTestBehavior.translucent,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(Dimens.gap_dp13),
            ),
            border: Border.all(color: context.theme.dividerColor)),
        padding: EdgeInsets.fromLTRB(
            Dimens.gap_dp6, Dimens.gap_dp4, Dimens.gap_dp6, Dimens.gap_dp4),
        child: Row(
          children: [
            Image.asset(
              ImageUtils.getImagePath(context.isDarkMode
                  ? 'icn_intelligent_black'
                  : 'icn_intelligent'),
              height: Dimens.gap_dp16,
            ),
            Text(
              '心动模式',
              style: body1Style().copyWith(fontSize: Dimens.font_sp11),
            )
          ],
        ),
      ),
    );
  }

  Widget _placeholderWidget(BuildContext context, String url) => ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(Dimens.gap_dp7)),
        child: Container(
          color: context.isDarkMode ? Colours.label_bg : Colours.color_165,
          alignment: Alignment.center,
          child: Image.asset(
            ImageUtils.getImagePath('cij'),
            color: Colours.white,
            width: Dimens.gap_dp24,
          ),
        ),
      );

  Widget _errorWidget(BuildContext context, String url, dynamic e) => ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(Dimens.gap_dp7)),
        child: Container(
          color: context.isDarkMode ? Colours.label_bg : Colours.color_165,
          alignment: Alignment.center,
          child: Image.asset(
            ImageUtils.getImagePath('cij'),
            color: Colours.white,
            width: Dimens.gap_dp24,
          ),
        ),
      );
}
