import 'package:flutter/widgets.dart';
import 'package:flutter_cloud_music/typedef/function.dart';
import 'package:package_info_plus/package_info_plus.dart';

PackageInfo? packageInfo;

extension ContextExt on BuildContext {
  void hideKeyboard() {
    FocusScope.of(this).requestFocus(FocusNode());
  }

  String appName() {
    return packageInfo?.appName ?? '';
  }
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
