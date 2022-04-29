import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/model/song_model.dart';
import 'package:flutter_cloud_music/common/player/player.dart';
import 'package:flutter_cloud_music/common/res/colors.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/utils/adapt.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';
import 'package:get/get.dart';

import '../pages/video/state.dart';
import '../pages/video/view.dart';

class GeneralSongCellWidget extends StatelessWidget {
  final Song song;

  const GeneralSongCellWidget({required this.song});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: !song.canPlay() ? 0.5 : 1.0,
      child: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    final titleStyle = body1Style().copyWith(fontSize: Dimens.font_sp17);
    return Row(
      children: [
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Obx(() => ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: Adapt.px(232)),
                      child: RichText(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(
                            text: song.name,
                            style:
                                context.playerService.curPlayId.value == song.id
                                    ? titleStyle.copyWith(
                                        color: Colours.btn_selectd_color)
                                    : titleStyle,
                            children: [
                              if (song.alia.isNotEmpty)
                                TextSpan(
                                    text:
                                        '（${song.alia.reduce((value, element) => '$value $element')}）',
                                    style: captionStyle()
                                        .copyWith(fontSize: Dimens.font_sp17)),
                            ]),
                      ),
                    )),
                if (GetUtils.isNullOrBlank(song.reason) != true)
                  Expanded(
                      child: Container(
                    height: Dimens.gap_dp15,
                    margin: EdgeInsets.only(left: Dimens.gap_dp4),
                    alignment: Alignment.centerLeft,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: Dimens.gap_dp3),
                      decoration: BoxDecoration(
                        color: Colours.app_main.withOpacity(0.15),
                        borderRadius: BorderRadius.all(
                          Radius.circular(Dimens.gap_dp4),
                        ),
                      ),
                      child: Text(
                        song.reason!,
                        style: TextStyle(
                            color: Colours.app_main,
                            fontSize: Dimens.font_sp10),
                      ),
                    ),
                  )),
              ],
            ),

            //subtitle
            Row(
              children: [
                Row(
                  children: getSongTags(song,
                      needOriginType: false,
                      needNewType: false,
                      needCopyright: false),
                ),
                Expanded(
                    child: Text(
                  song.getSongCellSubTitle(),
                  style: captionStyle(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ))
              ],
            )
          ],
        )),
        if ((song.mv ?? -1) > 0)
          GestureDetector(
            onTap: () {
              VideoPage.startWithSingle(VideoModel(
                  id: song.mv!.toString(), coverUrl: song.al.picUrl));
            },
            child: SizedBox(
              height: Dimens.gap_dp32,
              child: Center(
                child: Image.asset(
                  ImageUtils.getImagePath('video_selected'),
                  color: Get.isDarkMode
                      ? Colours.white.withOpacity(0.75)
                      : Colours.color_187,
                ),
              ),
            ),
          ),
        GestureDetector(
          onTap: () {},
          child: SizedBox(
            width: Dimens.gap_dp36,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Image.asset(
                ImageUtils.getImagePath('cb'),
                height: Dimens.gap_dp24,
                //
                color: Get.isDarkMode
                    ? Colours.white.withOpacity(0.6)
                    : Colours.color_187,
              ),
            ),
          ),
        )
      ],
    );
  }
}
