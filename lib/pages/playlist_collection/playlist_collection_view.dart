import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_cloud_music/common/res/gaps.dart';
import 'package:flutter_cloud_music/pages/playlist_collection/model/play_list_tag_model.dart';
import 'package:flutter_cloud_music/pages/playlist_collection/widget/playlist_content_view.dart';
import 'package:flutter_cloud_music/pages/playlist_collection/widget/tab_widget.dart';
import 'package:flutter_cloud_music/widgets/my_app_bar.dart';
import 'package:get/get.dart';
import 'playlist_collection_controller.dart';

class PlaylistCollectionPage extends GetView<PlaylistCollectionController> {
  const PlaylistCollectionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        centerTitle: '歌单广场',
      ),
      body: Obx(() => controller.tags.value == null
          ? Gaps.empty
          : TabWidget(
              tabItems: getTab(controller.tags.value!),
              initTabIndex: controller.selectedIndex,
              pageItemBuilder: (context, index) {
                return _buildPage(context, index);
              },
            )),
    );
  }

  List<Tab> getTab(List<PlayListTagModel> tags) {
    return tags.map((data) => Tab(text: data.name)).toList();
  }

  Widget _buildPage(BuildContext context, int index) {
    final tagModel = controller.tags.value!.elementAt(index);
    return PlayListContentView(mkey: Key('list$index'), tagModel: tagModel);
  }
}
