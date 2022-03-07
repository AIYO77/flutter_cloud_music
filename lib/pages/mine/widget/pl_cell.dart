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
  final MinePlaylist playlist;

  const MinePlaylistCell(Key? key, {required this.playlist}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Bounce(
      onPressed: () {
        Get.toNamed(Routes.PLAYLIST_DETAIL_ID(playlist.id.toString()));
      },
      child: SizedBox(
        width: double.infinity,
        height: Dimens.gap_dp52,
        child: Row(
          children: [
            CachedNetworkImage(
              imageUrl: ImageUtils.getImageUrlFromSize(
                  playlist.coverImgUrl, Size(Dimens.gap_dp60, Dimens.gap_dp60)),
              placeholder: placeholderWidget,
              errorWidget: errorWidget,
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
                      child: Image(
                        image: image,
                        height: Dimens.gap_dp49,
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
                Text(
                  playlist.isIntelligent() ? '我喜欢的音乐' : playlist.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: body1Style().copyWith(fontSize: Dimens.font_sp15),
                ),
                Gaps.vGap7,
                Text(
                  playlist.getCountAndBy(),
                  style: captionStyle(),
                )
              ],
            )),
            if (playlist.isIntelligent()) _buildIntelligent(context)
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
              child: IntelligentDialog(playlist.id),
            ),
            transitionCurve: Curves.fastLinearToSlowEaseIn,
            barrierColor: Colors.transparent,
            barrierDismissible: true);
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
}
