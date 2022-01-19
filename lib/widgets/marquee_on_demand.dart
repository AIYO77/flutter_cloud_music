import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

/*
 * @Author: XingWei 
 * @Date: 2022-01-17 16:51:12 
 * @Last Modified by: XingWei
 * @Last Modified time: 2022-01-17 16:52:36
 * 
 * 如果文本超过了widget大小就滚动
 * 否则不滚动
 */

typedef MarqueeBuilder = Marquee Function(
    BuildContext context, String text, TextStyle textStyle);
typedef TextBuilder = Text Function(
    BuildContext context, String text, TextStyle textStyle);

class MarqueeOnDemand extends StatelessWidget {
  final MarqueeBuilder marqueeBuilder;
  final TextBuilder textBuilder;
  final String text;
  final TextStyle textStyle;
  final double switchWidth;

  const MarqueeOnDemand(
      {Key? key,
      required this.marqueeBuilder,
      required this.textBuilder,
      required this.text,
      required this.textStyle,
      required this.switchWidth})
      : super(key: key);

  Size _textSize(String text, TextStyle style) {
    final TextPainter textPainter = TextPainter(
        text: TextSpan(text: text, style: style),
        maxLines: 1,
        textDirection: TextDirection.ltr)
      ..layout(minWidth: 0, maxWidth: double.infinity);
    return textPainter.size;
  }

  @override
  Widget build(BuildContext context) {
    final textWidth = _textSize(text, textStyle).width;
    return textWidth < switchWidth
        ? textBuilder(context, text, textStyle)
        : marqueeBuilder(context, text, textStyle);
  }
}
