import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/model/song_model.dart';
import 'package:flutter_cloud_music/common/player/player.dart';
import 'package:flutter_cloud_music/common/res/colors.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

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
    final titleStyle = captionStyle().copyWith(fontSize: Dimens.font_sp17);
    return Row(
      children: [
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(
              () => RichText(
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                text: TextSpan(
                    text: song.name,
                    style: context.playerService.curPlayId.value == song.id
                        ? titleStyle.copyWith(color: Colours.btn_selectd_color)
                        : titleStyle,
                    children: [
                      if (song.alia.isNotEmpty)
                        TextSpan(
                            text:
                                '（${song.alia.reduce((value, element) => '$value $element')}）',
                            style: subtitle1Style()
                                .copyWith(fontSize: Dimens.font_sp17)),
                    ]),
              ),
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
                  style: subtitle1Style(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ))
              ],
            )
          ],
        )),
        if (song.mv > 0)
          GestureDetector(
            onTap: () {
              Fluttertoast.showToast(msg: song.mv.toString());
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
