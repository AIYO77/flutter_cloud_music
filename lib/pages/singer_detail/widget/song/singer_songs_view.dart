import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/pages/singer_detail/widget/song/singer_songs_controller.dart';
import 'package:get/get.dart';

/// Creator: Xing Wei
/// Email: 654206017@qq.com
/// Date: 2022/2/12 5:50 下午
/// Des:

class SingerSongsView extends StatelessWidget {
  final int id;

  SingerSongsView({required this.id});

  final controller = GetInstance().putOrFind(() => SingerSongsController());
  @override
  Widget build(BuildContext context) {
    controller.id = id;
    return Container();
  }
}
