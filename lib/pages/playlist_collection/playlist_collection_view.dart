import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/player/widgets/bottom_player_widget.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/res/gaps.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';
import 'package:flutter_cloud_music/pages/playlist_collection/model/play_list_tag_model.dart';
import 'package:flutter_cloud_music/pages/playlist_collection/widget/playlist_content_view.dart';
import 'package:flutter_cloud_music/pages/playlist_collection/widget/tab_widget.dart';
import 'package:flutter_cloud_music/routes/app_routes.dart';
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
      body: BottomPlayerController(
        Obx(
          () => controller.tags.value == null
              ? Gaps.empty
              : Stack(
                  children: [
                    Positioned.fill(
                      child: TabWidget(
                        key: Key(controller.tags.value!.hashCode.toString()),
                        tabItems: getTab(controller.tags.value!),
                        initTabIndex: controller.selectedIndex,
                        rightPadding: Dimens.gap_dp50,
                        pageItemBuilder: (context, index) {
                          return _buildPage(context, index);
                        },
                      ),
                    ),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: GestureDetector(
                        onTap: () {
                          Get.toNamed(Routes.PLAYLIST_TAGS,
                              arguments: controller.tags.value);
                        },
                        child: Container(
                          height: Dimens.gap_dp40,
                          width: Dimens.gap_dp50,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: context.theme.cardColor,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  offset:
                                      Offset(-Dimens.gap_dp5, -Dimens.gap_dp5),
                                  blurRadius: Dimens.gap_dp5,
                                )
                              ]),
                          child: Image.asset(
                            ImageUtils.getImagePath(
                                'playlist_hall_moretag_icon'),
                            color: context.theme.iconTheme.color,
                            width: Dimens.gap_dp25,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
        ),
      ),
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
