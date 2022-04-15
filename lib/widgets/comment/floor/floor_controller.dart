import 'package:flutter_cloud_music/api/muisc_api.dart';
import 'package:flutter_cloud_music/common/model/floor_comment_model.dart';
import 'package:get/get.dart';

import '../../../common/model/comment_model.dart';

/// Creator: Xing Wei
/// Email: 654206017@qq.com
/// Date: 2022/4/14 11:43 上午
/// Des:
const String allReplay = '全部回复';
const String bestReplay = '最赞回复';

class FloorController extends GetxController {
  final String commentId;
  final String resId;
  final int type;

  final totalCount = 0.obs;
  final floorModel = Rx<FloorCommentModel?>(null);
  final headerList = Rx<List<HeaderList>>(
      [HeaderList(header: allReplay, comments: List.empty())]);

  FloorController(this.commentId, this.resId, this.type);

  @override
  void onReady() {
    super.onReady();
    _request();
  }

  Future<void> _request() async {
    final model = await MusicApi.getFloorComment(
        parentCommentId: commentId, resId: resId, type: type);
    totalCount.value = model?.totalCount ?? 0;
    floorModel.value = model;

    if (model != null) {
      final list = <HeaderList>[];
      if (GetUtils.isNullOrBlank(model.bestComments)! == false) {
        list.add(HeaderList(header: bestReplay, comments: model.bestComments!));
      }
      list.add(HeaderList(header: allReplay, comments: model.comments));
      headerList.value = list;
    }
  }
}

class HeaderList {
  final String header;

  final List<Comment> comments;

  const HeaderList({required this.header, required this.comments});
}
