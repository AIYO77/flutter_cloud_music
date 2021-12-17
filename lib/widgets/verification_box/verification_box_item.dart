import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/widgets/verification_box/verification_box_cursor.dart';

///
/// 输入框样式
///
enum VerificationBoxItemType {
  ///
  ///下划线
  ///
  underline,

  ///
  /// 盒子
  ///
  box,
}

///
/// 单个输入框
///
class VerificationBoxItem extends StatelessWidget {
  const VerificationBoxItem(
      {this.data = '',
      this.textStyle,
      this.type = VerificationBoxItemType.box,
      this.decoration,
      this.borderRadius = 5.0,
      this.borderWidth = 2.0,
      this.borderColor,
      this.showCursor = false,
      this.cursorColor,
      this.cursorWidth = 2,
      this.cursorIndent = 5,
      this.cursorEndIndent = 5});

  final String data;
  final VerificationBoxItemType type;
  final double borderWidth;
  final Color? borderColor;
  final double borderRadius;
  final TextStyle? textStyle;
  final Decoration? decoration;

  ///
  /// 是否显示光标
  ///
  final bool showCursor;

  ///
  /// 光标颜色
  ///
  final Color? cursorColor;

  ///
  /// 光标宽度
  ///
  final double cursorWidth;

  ///
  /// 光标距离顶部距离
  ///
  final double cursorIndent;

  ///
  /// 光标距离底部距离
  ///
  final double cursorEndIndent;

  @override
  Widget build(BuildContext context) {
    final borderColor = this.borderColor ?? Theme.of(context).dividerColor;
    final text = _buildText();
    Widget widget;
    if (type == VerificationBoxItemType.box) {
      widget = _buildBoxDecoration(text, borderColor);
    } else {
      widget = _buildUnderlineDecoration(text, borderColor);
    }

    return Stack(
      children: <Widget>[
        widget,
        if (showCursor)
          Positioned.fill(
              child: VerificationBoxCursor(
            color: cursorColor ?? Theme.of(context).cursorColor,
            width: cursorWidth,
            indent: cursorIndent,
            endIndent: cursorEndIndent,
          ))
        else
          Container()
      ],
    );
  }

  ///
  /// 绘制盒子类型
  ///
  Widget _buildBoxDecoration(Widget child, Color borderColor) {
    return Container(
      alignment: Alignment.center,
      decoration: decoration ??
          BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              border: Border.all(color: borderColor, width: borderWidth)),
      child: child,
    );
  }

  ///
  /// 绘制下划线类型
  ///
  Widget _buildUnderlineDecoration(Widget child, Color borderColor) {
    return Container(
      alignment: Alignment.center,
      decoration: UnderlineTabIndicator(
          borderSide: BorderSide(width: borderWidth, color: borderColor)),
      child: child,
    );
  }

  ///
  /// 文本
  ///
  Text _buildText() {
    return Text(
      '$data',
      style: textStyle,
    );
  }
}
