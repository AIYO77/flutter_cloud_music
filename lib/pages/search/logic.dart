import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/model/hot_search_model.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:flutter_cloud_music/common/values/constants.dart';
import 'package:flutter_cloud_music/pages/found/model/default_search_model.dart';
import 'package:get/get.dart';

import '../../api/search_api.dart';
import 'state.dart';

class SearchLogic extends GetxController {
  final state = SearchState();

  @override
  void onInit() {
    super.onInit();
    final arguments = Get.arguments;
    if (arguments is DefaultSearchModel) {
      state.defaultSearch = arguments;
    }
    state.editingController = TextEditingController();
    state.editingController.addListener(() {
      state.keywords.value = state.editingController.text;
    });
  }

  @override
  void onReady() {
    super.onReady();
    final context = Get.context;
    if (context != null) {
      _showKeyboard(context);
    }
    state.focusNode.addListener(() {
      //当键盘弹起，展示搜索建议
      if (state.focusNode.hasFocus && state.keywordsValue.isNotEmpty) {
        state.showSuggests.value = true;
        if (GetUtils.isNullOrBlank(state.suggests.value) == true) {
          searchSuggest(state.keywordsValue);
        }
      }
      if (state.focusNode.hasFocus) {
        state.showResult.value = false;
      }
    });
    _requestHotSearch();
  }

  void search(String keyword) {
    _hideKeyboard();
    final trimWord = keyword.trim();
    state.showSuggests.value = false;
    if (trimWord.isNotEmpty) {
      //去搜索结果页
      state.editingController.text = trimWord;
      state.showResult.value = true;
    } else if (state.defaultSearch?.realkeyword != null) {
      state.editingController.text = state.defaultSearch!.realkeyword!;
      state.showResult.value = true;
    }
  }

  ///搜索建议
  Future searchSuggest(String word) async {
    state.showSuggests.value = word.isNotEmpty;
    if (word.isNotEmpty) {
      final result = await SearchApi.suggest(word);
      state.suggests.value = result;
    } else {
      state.suggests.value = null;
    }
  }

  ///热门搜索
  Future _requestHotSearch() async {
    final cache = box
        .read<List<dynamic>>(CACHE_HOT_SEARCH)
        ?.map((e) => HotSearch.fromJson(e))
        .toList();
    state.hotSearch.value = cache;
    SearchApi.getHotSearch().then((list) {
      state.hotSearch.value = list;
      box.write(CACHE_HOT_SEARCH, list.map((e) => e.toJson()).toList());
    });
  }

  void _showKeyboard(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 300)).whenComplete(() {
      FocusScope.of(context).requestFocus(state.focusNode);
    });
  }

  void _hideKeyboard() {
    state.focusNode.unfocus();
  }

  @override
  void onClose() {
    _hideKeyboard();
    super.onClose();
  }
}
