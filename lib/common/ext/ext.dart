import 'package:flutter/widgets.dart';

extension ContextExt on BuildContext {
  void hideKeyboard() {
    FocusScope.of(this).requestFocus(FocusNode());
  }
}
