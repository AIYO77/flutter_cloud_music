import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/utils/adapt.dart';

class GeneralBlurImage extends StatelessWidget {
  final ImageProvider image;

  final double height;

  final double sigma;

  const GeneralBlurImage(
      {required this.image, required this.sigma, required this.height});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Image(
          width: Adapt.screenW(),
          image: image,
          fit: BoxFit.cover,
        ),
        ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: sigma, sigmaY: sigma),
            child: Container(
              color: Colors.black12,
              width: Adapt.screenW(),
              height: height,
            ),
          ),
        )
      ],
    );
  }
}
