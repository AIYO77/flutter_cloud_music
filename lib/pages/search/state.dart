import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/model/hot_search_model.dart';
import 'package:flutter_cloud_music/common/model/search_suggest.dart';
import 'package:flutter_cloud_music/pages/found/model/default_search_model.dart';
import 'package:get/get.dart';

class SearchState {
  DefaultSearchModel? defaultSearch;

  //热门搜索
  final hotSearch = Rx<List<HotSearch>?>(null);

  late TextEditingController editingController;
  late FocusNode focusNode;

  //搜索关键词
  final keywords = ''.obs;

  String get keywordsValue => keywords.value;

  //建议搜索列表
  final suggests = Rx<List<SearchSuggest>?>(null);

  //展示搜索建议
  final showSuggests = false.obs;

  //展示搜索结果
  final showResult = false.obs;

  SearchState() {
    focusNode = FocusNode();
  }
}

class SearchType {
  final int type;
  final String name;

  const SearchType({required this.type, required this.name});
}
