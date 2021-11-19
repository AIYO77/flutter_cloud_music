import 'dart:ui' as ui;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/utils/adapt.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';
import 'package:music_player/music_player.dart';

class BlurBackground extends StatelessWidget {
  const BlurBackground({Key? key, this.music}) : super(key: key);
  final MusicMetadata? music;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: ImageFiltered(
          imageFilter: ui.ImageFilter.blur(sigmaX: 55, sigmaY: 55),
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Image(
                image:
                    CachedNetworkImageProvider(music?.iconUri.toString() ?? ""),
                fit: BoxFit.fitHeight,
                gaplessPlayback: true,
              ),
              Container(
                color: Colors.black38,
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: Adapt.screenH() / 2,
                child: Image.asset(
                  ImageUtils.getImagePath('cover_top_mask'),
                  fit: BoxFit.fill,
                  width: Adapt.screenW(),
                ),
              ),
              Positioned(
                  top: Adapt.screenH() / 2,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Image.asset(
                    ImageUtils.getImagePath('cover_btm_mask'),
                    width: Adapt.screenW(),
                    fit: BoxFit.fill,
                  ))
            ],
          )),
    );
  }
}
