import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/model/song_model.dart';
import 'package:flutter_cloud_music/common/player/player.dart';
import 'package:flutter_cloud_music/common/res/colors.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/res/gaps.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';
import 'package:flutter_cloud_music/common/utils/list_song_check_controller.dart';
import 'package:flutter_cloud_music/typedef/function.dart';
import 'package:flutter_cloud_music/widgets/general_song_cell.dart';
import 'package:flutter_cloud_music/widgets/round_checkbox.dart';
import 'package:get/get.dart';

class CheckSongCell extends StatelessWidget {
  final Song song;

  final ParamSingleCallback<Song> cellClickCallback;

  final CheckSongController parentController;

  const CheckSongCell(
      {required this.song,
      required this.parentController,
      required this.cellClickCallback});

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: Size.fromHeight(Dimens.gap_dp60),
      child: Material(
        color: Get.theme.cardColor,
        child: InkWell(
          onTap: () {
            cellClickCallback.call(song);
          },
          child: Obx(
            () => Row(
              children: [
                if (parentController.showCheck.value)
                  Gaps.hGap10
                else
                  Gaps.hGap16,
                //checkBox
                Visibility(
                  visible: parentController.showCheck.value,
                  child: RoundCheckBox(
                    Key('${song.id}}'),
                    value: GetUtils.isNullOrBlank(
                                parentController.selectedSong.value) !=
                            true &&
                        parentController.selectedSong.value?.indexWhere(
                                (element) => element.id == song.id) !=
                            -1,
                  ),
                ),
                if (parentController.showCheck.value) Gaps.hGap10,
                //封面
                ClipRRect(
                  borderRadius:
                      BorderRadius.all(Radius.circular(Dimens.gap_dp4)),
                  child: CachedNetworkImage(
                      imageUrl: ImageUtils.getImageUrlFromSize(song.al.picUrl,
                          Size(Dimens.gap_dp40, Dimens.gap_dp40)),
                      width: Dimens.gap_dp40,
                      height: Dimens.gap_dp40,
                      placeholder: (context, url) {
                        return Container(
                          color: Colours.load_image_placeholder(),
                        );
                      }),
                ),
                Gaps.hGap10,
                //播放中
                Obx(() => (context.playerService.curPlayId.value == song.id &&
                        !parentController.showCheck.value)
                    ? Padding(
                        padding: EdgeInsets.only(right: Dimens.gap_dp10),
                        child: Image.asset(
                          ImageUtils.getPlayingMusicTag(),
                          color: Colours.btn_selectd_color,
                          width: Dimens.gap_dp13,
                        ),
                      )
                    : Gaps.empty),
                //song
                Expanded(
                    child: GeneralSongCellWidget(
                  song: song,
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
