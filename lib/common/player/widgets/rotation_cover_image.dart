import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';
import 'package:music_player/music_player.dart';

class RotationCoverImage extends StatefulWidget {
  const RotationCoverImage(
      {Key? key, required this.rotating, required this.music})
      : super(key: key);

  final bool rotating;
  final MusicMetadata music;
  // final bool is

  @override
  _RotationCoverImageState createState() => _RotationCoverImageState();
}

class _RotationCoverImageState extends State<RotationCoverImage> {
  //album cover rotation
  double rotation = 0;

  //album cover rotation animation
  late AnimationController controller;

  @override
  void didUpdateWidget(covariant RotationCoverImage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.rotating) {
      controller.forward(from: controller.value);
    } else {
      controller.stop();
    }
    if (widget.music != oldWidget.music) {
      controller.value = 0;
    }
  }

  @override
  void initState() {
    super.initState();
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
        if (status == AnimationStatus.completed && controller.value == 1) {
          controller.forward(from: 0);
        }
      });
    if (widget.rotating) {
      controller.forward(from: controller.value);
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: rotation,
      child: Material(
        elevation: 3,
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(500),
        clipBehavior: Clip.antiAlias,
        child: AspectRatio(
          aspectRatio: 1,
          child: Container(
            foregroundDecoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(ImageUtils.getImagePath('ed5')))),
            padding: const EdgeInsets.all(30),
            child: ClipOval(
              child: CachedNetworkImage(
                imageUrl: widget.music.iconUri ?? '',
                placeholder: (context, url) =>
                    Image.asset(ImageUtils.getImagePath('ecf')),
                errorWidget: (context, url, e) =>
                    Image.asset(ImageUtils.getImagePath('ecf')),
                imageBuilder: (context, provider) {
                  return Image(
                    image: provider,
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
