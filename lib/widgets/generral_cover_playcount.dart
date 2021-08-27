import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/res/colors.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/res/gaps.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';

class GenrralCoverPlayCount extends StatelessWidget {
  final String imageUrl;

  final int playCount;

  final Size coverSize;

  const GenrralCoverPlayCount(
      {required this.imageUrl,
      required this.playCount,
      required this.coverSize});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //突出的背景
        Container(
          height: Dimens.gap_dp4,
          margin: EdgeInsets.only(left: Dimens.gap_dp6, right: Dimens.gap_dp6),
          decoration: BoxDecoration(
            color: Colors.grey.shade300.withOpacity(0.4),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimens.gap_dp12),
                topRight: Radius.circular(Dimens.gap_dp12)),
          ),
        ),
        CachedNetworkImage(
          imageUrl: ImageUtils.getImageUrlFromSize(imageUrl, coverSize),
          width: coverSize.width,
          height: coverSize.height,
          placeholder: (context, url) {
            return Container(
              color: Colours.load_image_placeholder,
            );
          },
          imageBuilder: (context, provider) {
            return ClipRRect(
              borderRadius: BorderRadius.all(
                Radius.circular(Dimens.gap_dp6),
              ),
              child: Stack(
                children: [
                  Image(
                    image: provider,
                    fit: BoxFit.cover,
                  ),
                  //播放量
                  Positioned(
                      right: Dimens.gap_dp4,
                      top: Dimens.gap_dp4,
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(
                          Radius.circular(Dimens.gap_dp8),
                        ),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Container(
                            padding: EdgeInsets.only(
                                left: Dimens.gap_dp7, right: Dimens.gap_dp7),
                            height: Dimens.gap_dp16,
                            color: Colors.black.withOpacity(0.2),
                            child: _playcount(playCount),
                          ),
                        ),
                      )),
                ],
              ),
            );
          },
        )
      ],
    );
  }

  Widget _playcount(int count) {
    return Row(
      children: [
        Image.asset(
          ImageUtils.getImagePath('icon_playcount'),
          width: Dimens.gap_dp8,
          height: Dimens.gap_dp8,
        ),
        Gaps.hGap1,
        Text(
          getPlayCountStrFromInt(count),
          style: TextStyle(
              color: Colors.white.withOpacity(0.9), fontSize: Dimens.font_sp10),
        )
      ],
    );
  }
}
