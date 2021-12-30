import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyTextButtonWithIcon extends TextButton {
  MyTextButtonWithIcon({
    Key? key,
    required VoidCallback? onPressed,
    VoidCallback? onLongPress,
    FocusNode? focusNode,
    bool? autofocus,
    Clip? clipBehavior,
    double? gap,
    required Widget icon,
    required Widget label,
  }) : super(
          key: key,
          onPressed: onPressed,
          onLongPress: onLongPress,
          style: ButtonStyle(
              padding: MaterialStateProperty.all(EdgeInsets.zero),
              overlayColor: MaterialStateProperty.all(
                  Get.theme.dividerColor.withOpacity(0.5))),
          focusNode: focusNode,
          autofocus: autofocus ?? false,
          clipBehavior: clipBehavior ?? Clip.none,
          child: _TextButtonWithIconChild(
            icon: icon,
            label: label,
            gap: gap ?? 4,
          ),
        );
}

class _TextButtonWithIconChild extends StatelessWidget {
  const _TextButtonWithIconChild({
    Key? key,
    this.gap = 4,
    required this.label,
    required this.icon,
  }) : super(key: key);

  final Widget label;
  final Widget icon;
  final double gap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[icon, SizedBox(width: gap), Flexible(child: label)],
    );
  }
}
