import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/utils/adapt.dart';
import 'package:get/get.dart';

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
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: sigma, sigmaY: sigma),
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: [
                Colors.transparent,
                Colors.black.withOpacity(Get.isDarkMode ? 0.3 : 0.2)
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )),
          ),
        )
      ],
    );
  }
}
