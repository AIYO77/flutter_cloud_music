/*
 * @Author: XingWei 
 * @Date: 2021-08-23 19:14:19 
 * @Last Modified by: XingWei
 * @Last Modified time: 2021-08-23 20:56:10
 * 
 * 歌曲通用item,包括点击事件,播放状态
 */
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/model/song_model.dart';
import 'package:flutter_cloud_music/common/model/ui_element_model.dart';
import 'package:flutter_cloud_music/common/res/colors.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/res/gaps.dart';
import 'package:flutter_cloud_music/common/utils/adapt.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';
import 'package:flutter_cloud_music/routes/routes_utils.dart';
import 'package:flutter_cloud_music/services/player_service.dart';
import 'package:flutter_cloud_music/widgets/frame_animation_image.dart';
import 'package:get/get.dart';

class GeneralSongOne extends StatelessWidget {
  final Song songInfo;
  final UiElementModel uiElementModel;

  const GeneralSongOne({required this.songInfo, required this.uiElementModel});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        RouteUtils.routeFromActionStr(songInfo.actionType);
      },
      child: Row(
        children: [
          CachedNetworkImage(
            height: Dimens.gap_dp49,
            width: Dimens.gap_dp49,
            placeholder: (context, url) {
              return Container(
                color: Colours.load_image_placeholder,
              );
            },
            imageUrl: ImageUtils.getImageUrlFromSize(
                songInfo.al.picUrl, Size(Dimens.gap_dp49, Dimens.gap_dp49)),
            imageBuilder: (context, provider) {
              return ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(Dimens.gap_dp8)),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image(image: provider),
                    Obx(() =>
                        PlayerService.to.getCurPlayValue?.id != songInfo.id
                            ? Image.asset(
                                ImageUtils.getImagePath('icon_play_small'),
                                width: Dimens.gap_dp20,
                                height: Dimens.gap_dp20,
                                color: Colors.white.withOpacity(0.8))
                            : FrameAnimationImage(
                                Key('$songInfo.id'),
                                const ['c2t', 'c2u', 'c2v', 'c2w'],
                                width: Dimens.gap_dp24,
                                height: Dimens.gap_dp24,
                                imgColor: Colors.white.withOpacity(0.8),
                              ))
                  ],
                ),
              );
            },
          ),
          Gaps.hGap9,
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                child: RichText(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                      text: uiElementModel.mainTitle?.title.toString(),
                      style: headline1Style(),
                      children: [
                        WidgetSpan(child: Gaps.hGap4),
                        TextSpan(
                          text: '-',
                          style: TextStyle(
                              fontSize: Dimens.font_sp10,
                              color: const Color.fromARGB(255, 166, 166, 166)),
                        ),
                        WidgetSpan(child: Gaps.hGap4),
                        TextSpan(
                          text: songInfo.ar
                              .map((e) => e.name)
                              .toList()
                              .reduce((value, element) => '$value/$element'),
                          style: TextStyle(
                              fontSize: Dimens.font_sp10,
                              color: const Color.fromARGB(255, 166, 166, 166)),
                        ),
                      ],
                    )),
              ),
              Row(
                children: [
                  Row(
                    children: getSongTags(songInfo),
                  ),
                  Text(uiElementModel.subTitle?.title ?? "",
                      style: TextStyle(
                          fontSize: Adapt.px(11),
                          color: const Color.fromARGB(255, 166, 166, 166)))
                ],
              )
            ],
          ))
        ],
      ),
    );
  }
}
