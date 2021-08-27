import 'package:flutter/material.dart';

class ImageUtils {
  static String getImagePath(String name, {String format = 'png'}) {
    return 'assets/images/$name.$format';
  }

  static String getImageUrlFromSize(String? url, Size size) {
    //向上取整
    final width = (size.width * 1.7).ceil();
    final height = (size.height * 1.7).ceil();
    return '$url?param=${width}y$height';
  }
}
