import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/model/song_model.dart';
import 'package:flutter_cloud_music/common/player/player.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:flutter_cloud_music/pages/rcmd_song_day/widgets/header.dart';
import 'package:flutter_cloud_music/pages/rcmd_song_day/widgets/play_all_btn.dart';
import 'package:flutter_cloud_music/widgets/check_song_cell.dart';
import 'package:flutter_cloud_music/widgets/music_loading.dart';
import 'package:get/get.dart';

import '../index.dart';

class RcmdDailyWidget extends GetView<RcmdSongDayController> {
  const RcmdDailyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        _buildSliverHeader(),
        _buildPlayAllBtn(context),
        _buildContent(context),
        //pading bottom
        SliverToBoxAdapter(
            child: Obx(
          () => padingBottomBox(context.playerValueRx.value,
              append: (controller.showCheck.value &&
                      context.playerValueRx.value == null)
                  ? Dimens.gap_dp60
                  : 0),
        ))
      ],
    );
  }

  Widget _buildSliverHeader() {
    return RecmHeader();
  }

  Widget _buildContent(BuildContext context) {
    return Obx(() => controller.state.rcmdModel.value == null
        ? _buildLoading()
        : _buildList(context));
  }

  Widget _buildLoading() {
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.only(top: Dimens.gap_dp105),
        child: MusicLoading(),
      ),
    );
  }

  Widget _buildList(BuildContext context) {
    return SliverFixedExtentList(
        delegate: SliverChildBuilderDelegate((context, index) {
          return _buildItem(context,
              controller.state.rcmdModel.value!.dailySongs.elementAt(index));
        }, childCount: controller.state.rcmdModel.value!.dailySongs.length),
        itemExtent: Dimens.gap_dp60);
  }

  Widget _buildItem(BuildContext context, Song song) {
    return CheckSongCell(
      song: song,
      parentController: controller,
      cellClickCallback: (s) {
        if (controller.showCheck.value) {
          //操作
          List<Song>? oldList = controller.selectedSong.value;
          if (GetUtils.isNullOrBlank(oldList) != true &&
              oldList?.indexWhere((element) => element.id == s.id) != -1) {
            //已选中
            oldList!.removeWhere((element) => element.id == s.id);
            controller.selectedSong.value = List.from(oldList);
          } else {
            //未选中
            if (oldList == null) {
              oldList = [s];
            } else {
              oldList.add(s);
            }
            controller.selectedSong.value = List.from(oldList);
          }
        } else {
          controller.playList(context, song: s);
        }
      },
    );
  }

  Widget _buildPlayAllBtn(BuildContext context) {
    return RecmPlayAll();
  }
}
