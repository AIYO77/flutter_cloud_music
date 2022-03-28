import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/pages/found/model/found_new_song.dart';
import 'package:flutter_cloud_music/pages/single_search/widget/result_songs.dart';
import 'package:flutter_cloud_music/pages/single_search/widget/result_videos.dart';
import 'package:get/get.dart';

import '../../../common/model/search_videos.dart';
import '../../../common/res/gaps.dart';
import '../../../widgets/music_loading.dart';
import '../logic.dart';

/// Creator: Xing Wei
/// Email: 654206017@qq.com
/// Date: 2022/3/14 11:20 上午
/// Des:

class SingleSearchResult extends StatelessWidget {
  final controller = GetInstance().find<SingleSearchLogic>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => (controller.showResult.value &&
            !controller.showSuggests.value)
        ? Positioned.fill(
            top: Dimens.gap_dp6,
            child: Container(
              color: context.theme.cardColor,
              child: GetUtils.isNullOrBlank(controller.results.value) == true
                  ? Padding(
                      padding: EdgeInsets.only(top: Dimens.gap_dp40),
                      child: MusicLoading(
                        axis: Axis.horizontal,
                      ),
                    )
                  : controller.isSongs()
                      ? ResultSongs(controller.results.value!
                          .cast<SongData>()
                          .map((e) => e.buildSong())
                          .toList())
                      : ResultVideos(controller.results.value!.cast<Videos>()),
            ),
          )
        : Gaps.empty);
  }
}
