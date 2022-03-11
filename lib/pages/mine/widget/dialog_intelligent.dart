import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/res/gaps.dart';
import 'package:get/get.dart';

import '../../../common/res/dimens.dart';
import '../mine_controller.dart';

/// Creator: Xing Wei
/// Email: 654206017@qq.com
/// Date: 2022/3/4 5:53 下午
/// Des:

class IntelligentDialog extends StatefulWidget {
  final dynamic pid;

  const IntelligentDialog(this.pid);

  @override
  _IntelligentDialogState createState() => _IntelligentDialogState();
}

class _IntelligentDialogState extends State<IntelligentDialog>
    with TickerProviderStateMixin {
  final controller = GetInstance().find<MineController>();

  // //帧动画
  Animation<double>? animation;
  late AnimationController animationController;

  @override
  void initState() {
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));
    animation = Tween<double>(begin: 0, end: 49).animate(animationController);
    animation!.addListener(() {
      setState(() {});
    });
    animation!.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animationController.forward(from: 0);
      }
    });
    super.initState();
    animationController.forward(from: 0);
    controller.startIntelligent(widget.pid);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Gaps.vGap7,
        Image.asset(
          'assets/intell/intell_${animationController.isAnimating ? animation!.value.toInt() : 0}.png',
          height: Dimens.gap_dp50,
          gaplessPlayback: true,
        ),
        Gaps.vGap7,
        Text(
          '正在开启心动模式...',
          style: TextStyle(color: Colors.white, fontSize: Dimens.font_sp14),
        ),
        Gaps.vGap15,
      ],
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}
