import 'dart:ui' as ui;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';

class BlurBackground extends StatelessWidget {
  const BlurBackground({Key? key, this.musicCoverUrl}) : super(key: key);
  final String? musicCoverUrl;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: ImageFiltered(
          imageFilter: ui.ImageFilter.blur(sigmaX: 55, sigmaY: 55),
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              CachedNetworkImage(
                imageUrl: musicCoverUrl ?? '',
                fit: BoxFit.fitHeight,
                // useOldImageOnUrlChange: true,
                placeholder: (context, url) {
                  return Image.asset(
                      ImageUtils.getImagePath('fm_bg', format: 'jpg'),
                      fit: BoxFit.fitHeight);
                },
                errorWidget: (context, url, e) {
                  return Image.asset(
                      ImageUtils.getImagePath('fm_bg', format: 'jpg'),
                      fit: BoxFit.fitHeight);
                },
              ),
              Positioned.fill(
                  child: Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.black12, Colors.black26])),
              )),
            ],
          )),
    );
  }
}
