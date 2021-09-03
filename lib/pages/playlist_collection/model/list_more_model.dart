import 'package:flutter_cloud_music/common/model/simple_play_list_model.dart';

class PlayListHasMoreModel {
  final int? totalCount;
  final List<SimplePlayListModel> datas;

  PlayListHasMoreModel({required this.datas, this.totalCount});
}
