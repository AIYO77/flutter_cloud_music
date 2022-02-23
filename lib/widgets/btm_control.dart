import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/res/colors.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/utils/adapt.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';
import 'package:flutter_cloud_music/common/values/server.dart';
import 'package:get/get.dart';

class BtmControlView extends StatelessWidget {
  final VoidCallback? nextPlayPressed;
  final VoidCallback? addCollectPressed;
  final VoidCallback? downloadPressed;
  final VoidCallback? deletePressed;

  final bool canPressed;

  const BtmControlView(
      {required this.canPressed,
      this.nextPlayPressed,
      this.addCollectPressed,
      this.downloadPressed,
      this.deletePressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Dimens.gap_dp56 + Adapt.bottomPadding(),
      width: Adapt.screenW(),
      color: Get.theme.cardColor,
      padding: EdgeInsets.only(bottom: Adapt.bottomPadding()),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildBtmLayLabel(context,
              imagePath: 'btmlay_btn_next',
              name: '下一首播放',
              onPressed: nextPlayPressed),
          _buildBtmLayLabel(context,
              imagePath: 'btn_add',
              name: '收藏到歌单',
              onPressed: addCollectPressed),
          _buildBtmLayLabel(context,
              imagePath: 'btmlay_btn_dld',
              name: '下载',
              onPressed: downloadPressed),
          _buildBtmLayLabel(context,
              imagePath: 'btmlay_btn_dlt',
              name: '删除下载',
              onPressed: deletePressed),
        ],
      ),
    );
  }

  Widget _buildBtmLayLabel(BuildContext context,
      {required String imagePath,
      required String name,
      required VoidCallback? onPressed}) {
    return Expanded(
        child: Material(
      color: Get.theme.cardColor,
      child: InkWell(
        onTap: () {
          if (!canPressed) {
            return;
          }
          if (onPressed == null) {
            notImplemented(context);
            return;
          }
          onPressed.call();
        },
        child: Opacity(
          opacity: !canPressed ? 0.5 : 1.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                ImageUtils.getImagePath(imagePath),
                width: Dimens.gap_dp26,
                color: Get.isDarkMode
                    ? Colours.dark_subtitle_text
                    : Colours.subtitle_text,
              ),
              Text(
                name,
                style: captionStyle(),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
