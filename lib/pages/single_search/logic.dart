import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/api/search_api.dart';
import 'package:flutter_cloud_music/common/model/search_suggest.dart';
import 'package:get/get.dart';

class SingleSearchLogic extends GetxController {
  final FocusNode focusNode = FocusNode();
  String keywords = '';
  //搜索结果
  final results = Rx<List<dynamic>?>(null);
  //建议搜索列表
  final suggests = Rx<List<SearchSuggest>?>(null);
  //是否是输入状态
  final hasFocus = false.obs;

  //搜索建议
  Future<void> searchSuggest(String word) async {
    keywords = word;

    if (keywords.isNotEmpty) {
      final result = await SearchApi.suggest(word);
      suggests.value = result;
    } else {
      suggests.value = null;
    }
  }

  //搜索
  Future<void> search() async {
    focusNode.unfocus();
    if (keywords.isNotEmpty) {
      //搜索
    }
  }

  @override
  void onReady() {
    super.onReady();
    final context = Get.context;
    if (context != null) {
      _showKeyboard(context);
    }
    focusNode.addListener(() {
      hasFocus.value = focusNode.hasFocus;
    });
  }

  Future<void> _showKeyboard(BuildContext context) async {
    Future.delayed(const Duration(milliseconds: 300)).whenComplete(() {
      FocusScope.of(context).requestFocus(focusNode);
    });
  }

  @override
  void onClose() {
    focusNode.unfocus();
    super.onClose();
  }
}
