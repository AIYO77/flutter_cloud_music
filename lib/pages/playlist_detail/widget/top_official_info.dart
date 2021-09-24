import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/res/colors.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/res/gaps.dart';
import 'package:get/get.dart';

import '../playlist_detail_controller.dart';

class TopOfficialInfoWidget extends StatelessWidget {
  final controller = Get.find<PlaylistDetailController>();
  TopOfficialInfoWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CachedNetworkImage(
          height: Dimens.gap_dp32,
          fit: BoxFit.contain,
          color: Colours.white,
          imageUrl: controller.detail.value!.playlist.titleImageUrl!,
          imageBuilder: (context, provider) {
            return ClipRect(
              child: Align(
                alignment: Alignment.topLeft,
                widthFactor:
                    controller.detail.value!.playlist.getTitleImgFactor(),
                child: Image(image: provider),
              ),
            );
          },
        ),
        Gaps.vGap2,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(right: Dimens.gap_dp3),
              height: 1,
              width: 15,
              color: Colours.white.withOpacity(0.4),
            ),
            Text(
              controller.detail.value!.playlist.updateFrequency ?? '',
              style: TextStyle(
                color: Colours.white,
                fontSize: Dimens.font_sp13,
              ),
            ),
            Container(
              height: 1,
              margin: EdgeInsets.only(left: Dimens.gap_dp3),
              width: 15,
              color: Colours.white.withOpacity(0.4),
            ),
          ],
        ),
        Gaps.vGap12,
        Text(
          controller.detail.value!.playlist.description!
              .replaceAll(RegExp(r'\s+\b|\b\s|\n'), ' '),
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              fontSize: Dimens.font_sp12,
              color: Colours.white.withOpacity(
                0.8,
              )),
        )
      ],
    );
  }
}
