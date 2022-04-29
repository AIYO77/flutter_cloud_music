import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/model/search_suggest.dart';
import 'package:flutter_cloud_music/common/res/gaps.dart';
import 'package:flutter_cloud_music/typedef/function.dart';
import 'package:flutter_cloud_music/widgets/search/suggest.dart';

/// Creator: Xing Wei
/// Email: 654206017@qq.com
/// Date: 2022/3/14 11:44 上午
/// Des:

class SingleSearchSuggest extends StatelessWidget {
  final bool showSuggests;
  final List<SearchSuggest>? suggests;
  final String keywords;
  final ParamSingleCallback<String> onSuggestTap;

  const SingleSearchSuggest(
      {required this.showSuggests,
      this.suggests,
      required this.keywords,
      required this.onSuggestTap});

  @override
  Widget build(BuildContext context) {
    return showSuggests
        ? SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: SearchSuggestList(suggests, keyWords: keywords,
                itemOnTap: (word) {
              onSuggestTap.call(word);
            }))
        : Gaps.empty;
  }
}
