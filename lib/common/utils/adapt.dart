import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';

class Adapt {
  Adapt._();
  static double _width = 0;
  static double _height = 0;

  static double? _ratio;

  static void initContext(BuildContext context) {
    /// 类似于 MediaQuery.of(context).size。
    final size = context.mediaQuerySize;
    _width = size.width;
    _height = size.height;
  }

  static void _init(int number) {
    final int uiwidth = number;
    _ratio = _width / uiwidth;
  }

  static double px(double number) {
    if (!(_ratio is double || _ratio is int)) {
      Adapt._init(375);
    }
    return number * _ratio!;
  }

  static double screenW() {
    return _width;
  }

  static double screenH() {
    return _height;
  }
}
