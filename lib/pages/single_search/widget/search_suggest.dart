import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/widgets/search/suggest.dart';
import 'package:get/get.dart';

import '../../../common/res/gaps.dart';
import '../logic.dart';

/// Creator: Xing Wei
/// Email: 654206017@qq.com
/// Date: 2022/3/14 11:44 上午
/// Des:

class SingleSearchSuggest extends StatelessWidget {
  final controller = GetInstance().find<SingleSearchLogic>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.showSuggests.value
        ? Positioned.fill(
            child: SearchSuggestList(controller.suggests.value,
                keyWords: controller.keywords.value, itemOnTap: (word) {
            controller.search(word);
          }))
        : Gaps.empty);
  }
}
