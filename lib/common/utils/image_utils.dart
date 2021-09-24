import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class ImageUtils {
  static String getImagePath(String name, {String format = 'png'}) {
    return 'assets/images/$name.$format';
  }

  static String getImageUrlFromSize(String? url, Size size) {
    if (url == null) {
      return '';
    }
    //向上取整
    final width = (size.width * 2).ceil();
    final height = (size.height * 2).ceil();
    return '$url?param=${width}y$height';
  }

  static String getAnimPath(String name, {String format = 'json'}) {
    return 'assets/anim/$name.$format';
  }

  static Future<ui.Image> loadImageByProvider(
    ImageProvider provider, {
    ImageConfiguration config = ImageConfiguration.empty,
  }) async {
    final Completer<ui.Image> completer = Completer<ui.Image>(); //完成的回调
    ImageStreamListener? listener;
    final ImageStream stream = provider.resolve(config); //获取图片流
    listener = ImageStreamListener((ImageInfo frame, bool sync) {
      //监听
      final ui.Image image = frame.image;
      completer.complete(image); //完成
      stream.removeListener(listener!); //移除监听
    });
    stream.addListener(listener); //添加监听
    return completer.future; //返回
  }
}
