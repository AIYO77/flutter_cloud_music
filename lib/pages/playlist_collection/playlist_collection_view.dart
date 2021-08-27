import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/res/gaps.dart';
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
      body: Obx(
        () => controller.tags.value == null
            ? Gaps.empty
            : Column(
                children: [
                  //tab

                  //page
                ],
              ),
      ),
    );
  }
}
