import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/res/colors.dart';
import 'package:flutter_cloud_music/common/res/dimens.dart';
import 'package:flutter_cloud_music/common/utils/adapt.dart';
import 'package:flutter_cloud_music/common/utils/common_utils.dart';
import 'package:flutter_cloud_music/common/utils/image_utils.dart';
import 'package:flutter_cloud_music/widgets/sliver_fab.dart';
import 'package:get/get.dart';
import 'playlist_detail_controller.dart';

class PlaylistDetailPage extends GetView<PlaylistDetailController> {
  const PlaylistDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double media = (Adapt.screenW() - 100) / 2;

    return Scaffold(
      body: Builder(builder: (context) {
        return SliverFab(
          floatingWidget: Container(
            height: Dimens.gap_dp44,
            width: Adapt.px(277),
            decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                      color: Color.fromRGBO(235, 237, 242, 0.5),
                      offset: Offset(0, 3),
                      blurRadius: 8.0)
                ],
                borderRadius:
                    BorderRadius.all(Radius.circular(Dimens.gap_dp22)),
                gradient: LinearGradient(
                    colors: [Colours.white.withOpacity(0.9), Colours.white],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter)),
          ),
          expandedHeight: Adapt.screenH() * 0.35,
          floatingPosition: FloatingPosition(
              left: Adapt.px(50), right: Adapt.px(50), top: Adapt.px(4)),
          slivers: <Widget>[
            SliverAppBar(
              expandedHeight: Adapt.screenH() * 0.35,
              pinned: true,
              elevation: 0.0,
              title: Text("Example 2"),
              flexibleSpace: Image.asset(
                ImageUtils.getImagePath('ese'),
                fit: BoxFit.cover,
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                List.generate(
                  30,
                  (int index) => ListTile(title: Text("Item $index")),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
