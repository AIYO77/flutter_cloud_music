import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/model/song_model.dart';
import 'package:flutter_cloud_music/common/res/colors.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';
import 'package:flutter_cloud_music/services/player_service.dart';
import 'package:get/get.dart';

class GeneralSongCellWidget extends StatelessWidget {
  final Song song;

  const GeneralSongCellWidget({required this.song});

  @override
  Widget build(BuildContext context) {
    final titleStyle = captionStyle().copyWith(fontSize: Dimens.font_sp18);
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
                    style: PlayerService.to.getCurPlayValue?.id == song.id
                        ? titleStyle.copyWith(color: Colours.btn_selectd_color)
                        : titleStyle,
                    children: [
                      if (song.alia.isNotEmpty)
                        TextSpan(
                            text:
                                '（${song.alia.reduce((value, element) => '$value $element')}）',
                            style: subtitle1Style()
                                .copyWith(fontSize: Dimens.font_sp18)),
                    ]),
              ),
            ),
            //subtitle
            Row(
              children: [
                Row(
                  children: getSongTags(song,
                      needOriginType: false, needNewType: false),
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
        Container(
          width: Dimens.gap_dp20,
          height: Dimens.gap_dp17,
          padding: EdgeInsets.only(left: Dimens.gap_dp2),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(Dimens.gap_dp7),
              ),
              border: Border.all(
                  color: Get.isDarkMode
                      ? Colours.white.withOpacity(0.6)
                      : Colours.color_187.withOpacity(0.85),
                  width: Dimens.gap_dp1)),
          child: Center(
            child: Image.asset(
              ImageUtils.getImagePath('icon_play_small'),
              width: Dimens.gap_dp10,
              color: Get.isDarkMode
                  ? Colours.white.withOpacity(0.6)
                  : Colours.color_187,
            ),
          ),
        )
      ],
    );
  }
}
