/// Creator: Xing Wei
/// Email: 654206017@qq.com
/// Date: 2022/3/15 4:24 下午
/// Des:
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';

// RichTextWidget
class RichTextWidget extends StatelessWidget {
  final Text defaultText;
  final List<BaseRichText> richTexts;
  final List<TextSpan> _resultRichTexts = [];
  final int? maxLines;
  final bool caseSensitive; //Whether to ignore case
  final TextOverflow overflow;
  final TextAlign textAlign;

  RichTextWidget(
    this.defaultText, {
    this.richTexts = const [],
    this.caseSensitive = true,
    this.maxLines,
    this.overflow = TextOverflow.clip,
    this.textAlign = TextAlign.start,
  }) {
    separateText();
  }

  //Split string
  void separateText() {
    final List<_RichTextModel> result = [];
    final defaultStr = defaultText.data ?? "";
    //Find the position of the substring
    for (final richText in richTexts) {
      final regex = RegExp(richText.data, caseSensitive: caseSensitive);
      final matchs = regex.allMatches(defaultStr);
      for (final match in matchs) {
        final start = match.start;
        final end = match.end;
        if (end > start) {
          result
              .add(_RichTextModel(start: start, end: end, richText: richText));
        }
      }
    }
    if (result.isEmpty) {
      _resultRichTexts
          .add(TextSpan(text: defaultText.data, style: defaultText.style));
      return;
    }
    //Sort by start
    result.sort((a, b) => a.start - b.start);

    int start = 0;
    int i = 0;
    // Add the corresponding TextSpan
    while (i < result.length) {
      final model = result[i];
      if (model.start > start) {
        final defaultSubStr = defaultStr.substring(start, model.start);
        _resultRichTexts
            .add(TextSpan(text: defaultSubStr, style: defaultText.style));
      }

      final richSubStr = defaultStr.substring(
          model.start >= start ? model.start : start, model.end);
      _resultRichTexts.add(TextSpan(
        text: richSubStr,
        style: model.richText.style,
        recognizer: model.richText.onTap != null
            ? (TapGestureRecognizer()..onTap = model.richText.onTap)
            : null,
      ));
      start = model.end;
      i++;
      if (i == result.length && start < defaultStr.length) {
        final defaultSubStr = defaultStr.substring(start, defaultStr.length);
        _resultRichTexts
            .add(TextSpan(text: defaultSubStr, style: defaultText.style));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign,
      text: TextSpan(children: _resultRichTexts),
    );
  }
}

// BaseRichText
class BaseRichText extends StatelessWidget {
  final String data;
  final TextStyle? style;
  final GestureTapCallback? onTap;

  const BaseRichText(this.data, {this.style, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        data,
        style: style,
      ),
    );
  }
}

// RichTextModel
class _RichTextModel {
  final int start;
  final int end;
  final BaseRichText richText;

  _RichTextModel({
    required this.start,
    required this.end,
    required this.richText,
  });
}
