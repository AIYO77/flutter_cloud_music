import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_cloud_music/common/model/song_model.dart';
import 'package:flutter_cloud_music/common/res/colors.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';
import 'package:flutter_cloud_music/services/player_service.dart';
import 'package:flutter_cloud_music/widgets/general_song_cell.dart';
import 'package:get/get.dart';

class NumSongCell extends StatelessWidget {
  final Song song;
  final int index;

  const NumSongCell({Key? key, required this.song, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: Size.fromHeight(Dimens.gap_dp60),
      child: Material(
        color: Get.theme.cardColor,
        child: InkWell(
          onTap: () {
            PlayerService.to.curPlay.value = song;
          },
          child: Row(
            children: [
              //number
              Container(
                width: Dimens.gap_dp40,
                padding: EdgeInsets.only(
                    left: Dimens.gap_dp4, right: Dimens.gap_dp4),
                child: Center(
                  child: Obx(
                    () => PlayerService.to.curPlay.value?.id == song.id
                        ? Image.asset(
                            ImageUtils.getImagePath('t_dragonball_icn_rank'),
                            color: Colours.btn_selectd_color,
                            width: Dimens.gap_dp25,
                            height: Dimens.gap_dp25,
                          )
                        : AutoSizeText(
                            '${index + 1}',
                            maxLines: 1,
                            minFontSize: Dimens.font_sp10,
                            style: TextStyle(
                                fontSize: Dimens.font_sp16,
                                color: Get.isDarkMode
                                    ? Colours.white.withOpacity(0.4)
                                    : Colours.color_156),
                          ),
                  ),
                ),
              ),
              //song
              Expanded(
                  child: GeneralSongCellWidget(
                song: song,
              ))
            ],
          ),
        ),
      ),
    );
  }
}
