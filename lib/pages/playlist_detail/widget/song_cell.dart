import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/model/song_model.dart';
import 'package:flutter_cloud_music/common/player/player.dart';
import 'package:flutter_cloud_music/common/res/colors.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';
import 'package:flutter_cloud_music/typedef/function.dart';
import 'package:flutter_cloud_music/widgets/general_song_cell.dart';
import 'package:get/get.dart';

class NumSongCell extends StatelessWidget {
  final Song song;
  final int index;
  final ParamVoidCallback clickCallback;

  const NumSongCell(
      {Key? key,
      required this.song,
      required this.index,
      required this.clickCallback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: Size.fromHeight(Dimens.gap_dp60),
      child: Material(
        color: Get.theme.cardColor,
        child: InkWell(
          onTap: () {
            clickCallback.call();
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
                    () => context.playerService.curPlayId.value == song.id
                        ? Image.asset(
                            ImageUtils.getPlayingMusicTag(),
                            color: Colours.btn_selectd_color,
                            width: Dimens.gap_dp13,
                          )
                        : AutoSizeText(
                            '${index + 1}',
                            maxLines: 1,
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
