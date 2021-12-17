import 'package:flutter/widgets.dart';
import 'package:flutter_cloud_music/typedef/function.dart';

extension ContextExt on BuildContext {
  void hideKeyboard() {
    FocusScope.of(this).requestFocus(FocusNode());
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
