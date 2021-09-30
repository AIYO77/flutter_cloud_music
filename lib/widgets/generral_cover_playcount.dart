import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/res/colors.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/utils/adapt.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';
import 'package:flutter_cloud_music/typedef/function.dart';
import 'package:flutter_cloud_music/widgets/playcount_widget.dart';
import 'package:get/get.dart';

class GenrralCoverPlayCount extends StatelessWidget {
  final String imageUrl;

  final int playCount;

  final Size coverSize;

  final double coverRadius;

  final String? rightTopTagIcon;

  final ParamSingleCallback<ImageProvider>? imageCallback;

  const GenrralCoverPlayCount(
      {required this.imageUrl,
      required this.playCount,
      required this.coverSize,
      this.coverRadius = 6.0,
      this.rightTopTagIcon,
      this.imageCallback});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        //突出的背景
        Container(
          height: Dimens.gap_dp4,
          width: coverSize.width - Dimens.gap_dp14,
          decoration: BoxDecoration(
            color: Get.isDarkMode
                ? Colors.white.withOpacity(0.1)
                : Colors.grey.shade300.withOpacity(0.2),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimens.gap_dp16),
                topRight: Radius.circular(Dimens.gap_dp16)),
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.all(
            Radius.circular(Adapt.px(coverRadius)),
          ),
          child: CachedNetworkImage(
            imageUrl: ImageUtils.getImageUrlFromSize(imageUrl, coverSize),
            width: coverSize.width,
            height: coverSize.height,
            errorWidget: (context, url, e) => Container(
              color: Colours.load_image_placeholder(),
            ),
            placeholder: (context, url) {
              return Container(
                color: Colours.load_image_placeholder(),
              );
            },
            imageBuilder: _buildConver,
          ),
        )
      ],
    );
  }

  Widget _buildConver(BuildContext context, ImageProvider provider) {
    imageCallback?.call(provider);
    return Stack(
      children: [
        Image(
          image: provider,
          fit: BoxFit.cover,
        ),
        if (rightTopTagIcon != null)
          Positioned(
            left: 0,
            top: 0,
            child: Image.asset(
              rightTopTagIcon!,
              width: Dimens.gap_dp20,
              height: Dimens.gap_dp20,
              fit: BoxFit.fill,
            ),
          ),

        //播放量
        Positioned(
          right: Dimens.gap_dp4,
          top: Dimens.gap_dp4,
          child: ClipRRect(
            borderRadius: BorderRadius.all(
              Radius.circular(Dimens.gap_dp8),
            ),
            child: PlayCountWidget(playCount: playCount),
          ),
        ),
      ],
    );
  }
}
