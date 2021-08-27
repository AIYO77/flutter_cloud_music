import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/res/gaps.dart';
import 'package:flutter_cloud_music/common/utils/adapt.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';
import 'package:flutter_cloud_music/pages/found/model/found_model.dart';
import 'package:flutter_cloud_music/pages/found/model/found_new_song.dart';
import 'package:flutter_cloud_music/widgets/general_song_one.dart';
import 'package:get/get.dart';

class FoundSlideSingleSong extends StatelessWidget {
  final Blocks blocks;

  final double itemHeight;

  const FoundSlideSingleSong(this.blocks, {required this.itemHeight});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: itemHeight,
      decoration: BoxDecoration(
        color: Get.theme.cardColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(Dimens.gap_dp10),
          bottomRight: Radius.circular(Dimens.gap_dp10),
        ),
      ),
      child: Column(
        children: [
          Container(
            margin:
                EdgeInsets.only(left: Dimens.gap_dp15, right: Dimens.gap_dp15),
            child: Gaps.line,
          ),
          Container(
            margin: EdgeInsets.only(left: Dimens.gap_dp15, top: Dimens.gap_dp6),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  blocks.uiElement?.subTitle?.title ?? "",
                  style: headline1Style().copyWith(
                      fontSize: Adapt.px(11), fontWeight: FontWeight.w500),
                ),
                Image.asset(
                  ImageUtils.getImagePath('ege'),
                  width: Dimens.gap_dp8,
                  height: Dimens.gap_dp8,
                )
              ],
            ),
          ),
          Expanded(
            child: PageView.builder(
              controller: PageController(viewportFraction: 0.91),
              itemCount: blocks.creatives?.length ?? 0,
              itemBuilder: (context, index) {
                final creativeModel = blocks.creatives!.elementAt(index);
                final resource = creativeModel.resources!.elementAt(0);
                final song = FoundNewSong.fromJson(resource.resourceExtInfo);
                return GeneralSongOne(
                    songInfo: song.buildSong(resource.action),
                    uiElementModel: resource.uiElement);
              },
            ),
          ),
        ],
      ),
    );
  }
}
