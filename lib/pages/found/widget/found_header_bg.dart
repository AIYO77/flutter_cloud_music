import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/event/index.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/res/gaps.dart';
import 'package:flutter_cloud_music/common/utils/adapt.dart';
import 'package:flutter_cloud_music/pages/found/found_controller.dart';
import 'package:get/get.dart';

class FoundHeaderColors extends StatefulWidget {
  @override
  _FoundHeaderColorsState createState() => _FoundHeaderColorsState();
}

class _FoundHeaderColorsState extends State<FoundHeaderColors>
    with SingleTickerProviderStateMixin {
  final controller = GetInstance().find<FoundController>();

  late StreamSubscription stream;

  late AnimationController _animationController;
  late Animation<Color?> _colors;
  Color curColor = Colors.transparent;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));
    _colors = ColorTween(begin: curColor, end: Colors.transparent)
        .animate(_animationController);
    super.initState();
    stream = eventBus.on<Color>().listen((event) {
      _colors =
          ColorTween(begin: curColor, end: event).animate(_animationController);
      setState(() {
        _animationController.reset();
        _animationController.forward();
      });
      curColor = event;
    });
  }

  @override
  void dispose() {
    stream.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SizedBox(
        width: Adapt.screenW(),
        height: controller.isScrolled.value
            ? Dimens.gap_dp56 + Adapt.topPadding()
            : Dimens.gap_dp56 + Adapt.topPadding() + Dimens.gap_dp140,
        child: controller.isScrolled.value
            ? Container(
                color: Get.theme.cardColor,
                height: Dimens.gap_dp56 + Adapt.topPadding(),
                width: Adapt.screenW(),
              )
            : Stack(
                children: [
                  Positioned.fill(
                    child: AnimatedBuilder(
                      animation: _colors,
                      builder: (context, child) {
                        return Container(
                          color: _colors.value,
                        );
                      },
                    ),
                  ),
                  Positioned.fill(
                    child: Obx(() => controller.isSucLoad.value
                        ? Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Get.theme.cardColor.withOpacity(0.8),
                                  Get.theme.cardColor,
                                  Get.theme.cardColor
                                ],
                              ),
                            ),
                          )
                        : Gaps.empty),
                  )
                ],
              ),
      ),
    );
  }
}
