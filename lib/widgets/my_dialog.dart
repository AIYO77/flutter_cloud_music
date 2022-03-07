import 'package:flutter/material.dart';

/// Creator: Xing Wei
/// Email: 654206017@qq.com
/// Date: 2022/3/4 7:24 下午
/// Des:
class MyDialog extends StatelessWidget {
  /// Creates a dialog.
  ///
  /// Typically used in conjunction with [showDialog].
  const MyDialog({
    Key? key,
    this.backgroundColor,
    this.elevation,
    this.insetAnimationDuration = const Duration(milliseconds: 100),
    this.insetAnimationCurve = Curves.decelerate,
    this.clipBehavior = Clip.none,
    this.shape,
    this.alignment,
    this.minWidth = 280.0,
    this.child,
  }) : super(key: key);

  final Color? backgroundColor;

  final double? elevation;

  final Duration insetAnimationDuration;

  final Curve insetAnimationCurve;

  final Clip clipBehavior;

  final ShapeBorder? shape;

  final AlignmentGeometry? alignment;

  final double minWidth;

  final Widget? child;

  static const RoundedRectangleBorder _defaultDialogShape =
      RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4.0)));
  static const double _defaultElevation = 24.0;

  @override
  Widget build(BuildContext context) {
    final DialogTheme dialogTheme = DialogTheme.of(context);
    final EdgeInsets effectivePadding = MediaQuery.of(context).viewInsets;
    return AnimatedPadding(
      padding: effectivePadding,
      duration: insetAnimationDuration,
      curve: insetAnimationCurve,
      child: MediaQuery.removeViewInsets(
        removeLeft: true,
        removeTop: true,
        removeRight: true,
        removeBottom: true,
        context: context,
        child: Align(
          alignment: alignment ?? dialogTheme.alignment ?? Alignment.center,
          child: ConstrainedBox(
            constraints: BoxConstraints(minWidth: minWidth),
            child: Material(
              color: backgroundColor ??
                  dialogTheme.backgroundColor ??
                  Theme.of(context).dialogBackgroundColor,
              elevation:
                  elevation ?? dialogTheme.elevation ?? _defaultElevation,
              shape: shape ?? dialogTheme.shape ?? _defaultDialogShape,
              type: MaterialType.card,
              clipBehavior: clipBehavior,
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
