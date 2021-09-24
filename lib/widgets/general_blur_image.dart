import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/utils/adapt.dart';

class GeneralBlurImage extends StatelessWidget {
  final ImageProvider image;

  final double sigma;

  const GeneralBlurImage({required this.image, required this.sigma});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image(
          width: Adapt.screenW(),
          image: image,
          fit: BoxFit.cover,
        ),
        ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: sigma, sigmaY: sigma),
            child: Container(),
          ),
        )
      ],
    );
  }
}
