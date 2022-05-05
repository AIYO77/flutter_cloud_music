import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/model/song_model.dart';
import 'package:flutter_cloud_music/common/player/player.dart';
import 'package:flutter_cloud_music/common/res/gaps.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';
import 'package:flutter_cloud_music/pages/video/state.dart';
import 'package:flutter_cloud_music/pages/video/view.dart';
import 'package:flutter_cloud_music/widgets/custom_tap.dart';
import 'package:flutter_cloud_music/widgets/rich_text_widget.dart';
import 'package:get/get.dart';

import '../../../../common/res/colors.dart';
import '../../../../common/res/dimens.dart';
import '../../../../common/utils/common_utils.dart';

/// Creator: Xing Wei
/// Email: 654206017@qq.com
/// Date: 2022/4/28 5:07 下午
/// Des:

class SearchSongCell extends StatelessWidget {
  final Song song;

  final String keywords;

  const SearchSongCell({required this.song, required this.keywords});

  @override
  Widget build(BuildContext context) {
    final titleStyle = body1Style()
        .copyWith(fontSize: Dimens.font_sp16, fontWeight: FontWeight.normal);
    return Bounce(
      onPressed: () {
        context.insertAndPlay(song, openPlayingPage: true);
      },
      child: SizedBox.fromSize(
        size: Size.fromHeight(Dimens.gap_dp60),
        child: Column(
          children: [
            Gaps.line,
            Expanded(
              child: Row(
                children: [
                  //playing tag
                  Obx(() => context.playerService.curPlayId.value == song.id
                      ? Padding(
                          padding: EdgeInsets.only(right: Dimens.gap_dp10),
                          child: Image.asset(
                            ImageUtils.getPlayingMusicTag(),
                            color: Colours.btn_selectd_color,
                            width: Dimens.gap_dp13,
                          ),
                        )
                      : Gaps.empty),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (context.playerService.curPlayId.value == song.id)
                        Text(
                          song.name +
                              (song.alia.isNotEmpty
                                  ? '（${song.alia.reduce((value, element) => '$value $element')}）'
                                  : ''),
                          style: titleStyle.copyWith(
                              color: Colours.btn_selectd_color),
                        )
                      else
                        RichTextWidget(
                          Text(
                            song.name +
                                (song.alia.isNotEmpty
                                    ? '（${song.alia.reduce((value, element) => '$value $element')}）'
                                    : ''),
                            style: titleStyle,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          richTexts: [
                            BaseRichText(
                              keywords,
                              style: TextStyle(
                                  fontSize: titleStyle.fontSize,
                                  color: context.theme.highlightColor),
                            )
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
                            child: RichTextWidget(
                              Text(
                                song.getSongCellSubTitle(),
                                style: captionStyle(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              richTexts: [
                                BaseRichText(
                                  keywords,
                                  style: TextStyle(
                                      fontSize: captionStyle().fontSize,
                                      color: context.theme.highlightColor),
                                )
                              ],
                            ),
                          )
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
              ),
            )
          ],
        ),
      ),
    );
  }
}
