import '../../../../common/model/simple_play_list_model.dart';
import 'base_model.dart';

/// Creator: Xing Wei
/// Email: 654206017@qq.com
/// Date: 2022/4/28 11:38 上午
/// Des:

class SearchPlayLists extends BaseSearchModel {
  final List<SimplePlayListModel> playLists;

  SearchPlayLists.fromJson(Map<String, dynamic> json)
      : playLists = (json['playLists'] as List)
            .map((e) => SimplePlayListModel.fromJson(e))
            .toList(),
        super.fromJson(json);
}
