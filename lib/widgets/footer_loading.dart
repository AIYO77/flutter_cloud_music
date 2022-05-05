import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/res/gaps.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:flutter_cloud_music/widgets/music_loading.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class FooterLoading extends StatelessWidget {
  final String noMoreTxt;

  const FooterLoading({Key? key, this.noMoreTxt = ""}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomFooter(
      height: Dimens.gap_dp90,
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
    );
  }
}
