import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/api/search_api.dart';
import 'package:flutter_cloud_music/common/model/search_songs.dart';
import 'package:flutter_cloud_music/common/model/search_suggest.dart';
import 'package:flutter_cloud_music/common/model/search_videos.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:flutter_cloud_music/common/values/server.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../common/values/constants.dart';
import '../../routes/app_routes.dart';

class SingleSearchLogic extends GetxController {
  final FocusNode focusNode = FocusNode();

  //搜索类型
  late int _searchType;

  //搜索关键词
  final keywords = ''.obs;

  String get keywordsValue => keywords.value;

  //搜索结果
  final results = Rx<List<dynamic>?>(null);

  //建议搜索列表
  final suggests = Rx<List<SearchSuggest>?>(null);

  //展示搜索建议
  final showSuggests = false.obs;

  //展示搜索结果
  final showResult = false.obs;

  late RefreshController refreshController;

  late TextEditingController editingController;

  @override
  void onInit() {
    super.onInit();
    _searchType = Get.arguments as int? ?? SEARCH_SONGS;
    refreshController = RefreshController();
    editingController = TextEditingController();
    editingController.addListener(() {
      keywords.value = editingController.text;
    });
    logger.d(Get.currentRoute == Routes.HOME);
  }

  @override
  void onReady() {
    super.onReady();
    final context = Get.context;
    if (context != null) {
      _showKeyboard(context);
    }
    focusNode.addListener(() {
      //当键盘弹起，展示搜索建议
      if (focusNode.hasFocus && keywordsValue.isNotEmpty) {
        showSuggests.value = true;
        if (GetUtils.isNullOrBlank(suggests.value) == true) {
          searchSuggest(keywordsValue);
        }
      }
      if (focusNode.hasFocus) {
        showResult.value = false;
        results.value = null;
      }
    });
  }

  //搜索建议
  Future<void> searchSuggest(String word) async {
    showSuggests.value = word.isNotEmpty;
    if (word.isNotEmpty) {
      final result = await SearchApi.suggest(word);
      suggests.value = result;
    } else {
      suggests.value = null;
    }
  }

  Future<void> search(String keyword) async {
    _hideKeyboard();
    final trimWord = keyword.trim();
    editingController.text = trimWord;
    if (trimWord.isNotEmpty) {
      results.value = null;
      showSuggests.value = false;
      showResult.value = true;
      //搜索
      _search(trimWord);
    }
  }

  //搜索分页
  Future<void> loadMoreResult() async {
    _search(keywordsValue, offset: results.value?.length ?? 0);
  }

  //搜索
  Future<void> _search(String keyword, {int offset = 0}) async {
    final data =
        await SearchApi.search(keyword, offset: offset, type: _searchType);

    if (data != null) {
      bool hasMore = false;
      List<dynamic>? dmp;
      if (_searchType == SEARCH_SONGS) {
        // 单曲
        final song = SearchSongs.fromJson(data);
        hasMore = song.hasMore;
        dmp = song.songs;
      }
      if (_searchType == SEARCH_VIDEOS) {
        final video = SearchVideos.fromJson(data);
        hasMore = video.hasMore;
        dmp = video.videos;
      }

      if (offset == 0) {
        //第一页
        results.value = dmp;
      } else {
        //分页
        final oldList = results.value;
        if (oldList != null && dmp != null) {
          oldList.addAll(dmp);
          results.value = List.from(oldList);
        }
      }

      if (hasMore) {
        refreshController.loadComplete();
      } else {
        refreshController.loadNoData();
      }
    } else {
      refreshController.loadFailed();
      toast('搜索异常');
    }
  }

  bool isSongs() {
    return _searchType == SEARCH_SONGS;
  }

  Future<void> _showKeyboard(BuildContext context) async {
    Future.delayed(const Duration(milliseconds: 300)).whenComplete(() {
      FocusScope.of(context).requestFocus(focusNode);
    });
  }

  void _hideKeyboard() {
    focusNode.unfocus();
  }

  @override
  void onClose() {
    _hideKeyboard();
    super.onClose();
  }
}
