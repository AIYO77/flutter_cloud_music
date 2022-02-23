import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/player/player.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/res/gaps.dart';
import 'package:flutter_cloud_music/common/utils/adapt.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:flutter_cloud_music/widgets/music_loading.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class FooterLoading extends StatelessWidget {
  final String noMoreTxt;

  FooterLoading({Key? key, this.noMoreTxt = "暂无更多"}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => CustomFooter(
        height: (context.playerValueRx.value?.current == null)
            ? Dimens.gap_dp50 + Adapt.bottomPadding()
            : Dimens.gap_dp140 + Adapt.bottomPadding(),
        builder: (context, mode) {
          Widget body;
          if (mode == LoadStatus.idle || mode == LoadStatus.loading) {
            //加载状态
            body = MusicLoading(
              axis: Axis.horizontal,
            );
          } else if (mode == LoadStatus.failed) {
            //加载数据失败
            body = Text(
              "加载失败，稍后重试",
              style: body1Style().copyWith(fontSize: Dimens.font_sp14),
            );
          } else {
            //没有数据
            if (noMoreTxt.isNotEmpty) {
              body = Text(
                noMoreTxt,
                style: body1Style().copyWith(fontSize: Dimens.font_sp14),
              );
            } else {
              body = Gaps.empty;
            }
          }
          return SizedBox(
            height: Dimens.gap_dp50,
            child: Center(child: body),
          );
        },
      ),
    );
  }
}
