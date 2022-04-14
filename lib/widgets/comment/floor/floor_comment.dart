import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/widgets/comment/floor/floor_controller.dart';
import 'package:get/get.dart';

/// Creator: Xing Wei
/// Email: 654206017@qq.com
/// Date: 2022/4/14 11:40 上午
/// Des: 楼层评论

class FloorCommentWidget extends StatelessWidget {
  late FloorController controller;
  final String parentCommentId;
  final String resId;
  final int type;
  final VoidCallback? backCall;

  FloorCommentWidget(
      {required this.parentCommentId,
      required this.resId,
      required this.type,
      this.backCall});

  @override
  Widget build(BuildContext context) {
    controller = GetInstance().putOrFind(() => FloorController());
    return Container();
  }
}
