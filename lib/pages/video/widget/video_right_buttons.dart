import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/res/colors.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:get/get.dart';

import '../../../widgets/tapped.dart';
import '../controller/video_list_controller.dart';
import '../logic.dart';
import '../state.dart';

/// Creator: Xing Wei
/// Email: 654206017@qq.com
/// Date: 2022/3/23 5:42 下午
/// Des: 视频右边按钮列表

class VideoRightButtons extends StatelessWidget {
  final VideoState state = Get.find<VideoLogic>().videoState;

  final VPVideoController? controller;
  final Function? onFavorite;
  final Function? onComment;
  final Function? onShare;

  VideoRightButtons(
      {required this.controller,
      this.onFavorite,
      this.onComment,
      this.onShare});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Dimens.gap_dp30,
      margin: EdgeInsets.only(
        bottom: Dimens.gap_dp25,
        right: Dimens.gap_dp14,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Obx(() => _FavoriteIcon(
                onFavorite: onFavorite,
                favoriteCount: controller?.countInfo.value?.likedCount ?? 0,
                isFavorite: state.favoriteIds.value
                        ?.contains(controller?.videoModel.id) ??
                    false,
              )),
          Obx(() => _IconButton(
                icon: IconToText(Icons.insert_comment_rounded,
                    size: Dimens.gap_dp30 - 4),
                text: getCommentStrFromInt(
                    controller?.countInfo.value?.commentCount ?? 0),
                onTap: onComment,
              )),
          Obx(() => _IconButton(
                icon: IconToText(Icons.share, size: Dimens.gap_dp30),
                text: getCommentStrFromInt(
                    controller?.countInfo.value?.shareCount ?? 0),
                onTap: onShare,
              )),
        ],
      ),
    );
  }
}

class _FavoriteIcon extends StatelessWidget {
  const _FavoriteIcon({
    Key? key,
    required this.onFavorite,
    required this.favoriteCount,
    required this.isFavorite,
  }) : super(key: key);
  final bool isFavorite;
  final Function? onFavorite;
  final int favoriteCount;

  @override
  Widget build(BuildContext context) {
    return _IconButton(
      icon: IconToText(
        Icons.favorite,
        size: Dimens.gap_dp30,
        color: isFavorite ? Colors.red : Colours.color_204.withOpacity(0.9),
      ),
      text: getCommentStrFromInt(favoriteCount),
      onTap: onFavorite,
    );
  }
}

/// 把IconData转换为文字，使其可以使用文字样式
class IconToText extends StatelessWidget {
  final IconData? icon;
  final TextStyle? style;
  final double? size;
  final Color? color;

  const IconToText(
    this.icon, {
    Key? key,
    this.style,
    this.size,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      String.fromCharCode(icon!.codePoint),
      style: style ??
          TextStyle(
            fontFamily: 'MaterialIcons',
            fontSize: size ?? 30,
            color: color ?? Colours.color_204.withOpacity(0.9),
          ),
    );
  }
}

class _IconButton extends StatelessWidget {
  final Widget? icon;
  final String? text;
  final Function? onTap;

  const _IconButton({
    Key? key,
    this.icon,
    this.text,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final shadowStyle = TextStyle(
      shadows: [
        Shadow(
          color: Colors.black.withOpacity(0.15),
          offset: const Offset(0, 1),
          blurRadius: 1,
        ),
      ],
    );
    final body = Column(
      children: <Widget>[
        Tapped(
          onTap: onTap,
          child: icon ?? Container(),
        ),
        Container(height: Dimens.gap_dp2),
        Text(
          text ?? '??',
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: Dimens.font_sp12,
            color: Colours.color_204,
          ),
        ),
      ],
    );
    return Container(
      padding: EdgeInsets.symmetric(vertical: Dimens.gap_dp10),
      child: DefaultTextStyle(
        style: shadowStyle,
        child: body,
      ),
    );
  }
}
