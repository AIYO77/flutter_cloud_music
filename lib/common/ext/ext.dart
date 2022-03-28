import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/typedef/function.dart';
import 'package:get/get.dart';

// import 'package:package_info_plus/package_info_plus.dart';
//
// PackageInfo? packageInfo;
//
extension ContextExt on BuildContext {
  void hideKeyboard() {
    FocusScope.of(this).requestFocus(FocusNode());
  }

// String appName() {
//   return packageInfo?.appName ?? '';
// }
}

extension BoolExt on bool {
  bool yes(ParamVoidCallback callback) {
    if (this) {
      callback.call();
    }
    return this;
  }

  bool no(ParamVoidCallback callback) {
    if (!this) {
      callback.call();
    }
    return this;
  }
}

extension IdPlayUrl on int {
  //部分音乐可能获取不到播放地址 可以通过这种方式直接播放
  String playUrl() {
    return 'https://music.163.com/song/media/outer/url?id=$this.mp3';
  }
}

extension VideoTypeExt on String {
  //mv的id只是数字 不包含字母
  bool isMv() {
    return isNumericOnly;
  }

  //视频的id 不是纯数字并且没有小写字母
  bool isVideo() {
    return !isNumericOnly && !RegExp(r'[a-z]').hasMatch(this);
  }

  //MLog的id 不是纯数字并且只少包含一个小写字母
  bool isMLog() {
    return !isNumericOnly && RegExp(r'[a-z]').hasMatch(this);
  }
}
