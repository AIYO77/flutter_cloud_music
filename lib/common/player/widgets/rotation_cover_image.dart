import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/model/song_model.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';
import 'package:flutter_cloud_music/common/values/server.dart';
import 'package:music_player/music_player.dart';

class RotationCoverImage extends StatefulWidget {
  const RotationCoverImage(
      {Key? key, required this.rotating, this.music, required this.pading})
      : super(key: key);

  final bool rotating;
  final Song? music;
  final double pading;
  // final bool is

  @override
  _RotationCoverImageState createState() => _RotationCoverImageState();
}

class _RotationCoverImageState extends State<RotationCoverImage>
    with SingleTickerProviderStateMixin {
  //album cover rotation
  double rotation = 0;

  //album cover rotation animation
  late AnimationController controller;

  @override
  void didUpdateWidget(covariant RotationCoverImage oldWidget) {
    logger.d('rotating = ${widget.rotating}');
    if (widget.rotating) {
      controller.forward(from: controller.value);
    } else {
      controller.stop();
    }
    if (widget.music != oldWidget.music) {
      controller.value = 0;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )
      ..addListener(() {
        setState(() {
          rotation = controller.value * 2 * pi;
        });
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.dismissed && widget.rotating) {
          controller.forward(from: controller.value);
        }
        if (status == AnimationStatus.completed && controller.value == 1) {
          controller.forward(from: 0);
        }
      });
    if (widget.rotating) {
      controller.forward(from: controller.value);
    }
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
              child: Image.asset(ImageUtils.getImagePath('play_disc'))),
          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.all(widget.pading),
              child: Transform.rotate(
                angle: rotation,
                child: ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: widget.music?.al.picUrl ?? '',
                    placeholder: (context, url) => Image.asset(
                        ImageUtils.getImagePath('default_cover_play')),
                    errorWidget: (context, url, e) => Image.asset(
                        ImageUtils.getImagePath('default_cover_play')),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
