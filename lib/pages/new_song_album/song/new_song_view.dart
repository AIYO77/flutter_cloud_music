import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/pages/new_song_album/song/list/new_song_list_view.dart';
import 'package:flutter_cloud_music/pages/new_song_album/song/new_song_controller.dart';
import 'package:flutter_cloud_music/pages/new_song_album/song/new_song_tag_model.dart';
import 'package:flutter_cloud_music/pages/playlist_collection/widget/tab_widget.dart';
import 'package:get/get.dart';

class NewSongPage extends StatelessWidget {
  final controller = GetInstance().putOrFind(() => NewSongController());

  @override
  Widget build(BuildContext context) {
    return TabWidget(
      tabItems: getTab(controller.tags),
      pageItemBuilder: (context, index) {
        final tag = controller.tags.elementAt(index);
        return NewSongListView(
          Key('Key$index'),
          tagModel: tag,
        );
      },
    );
  }

  List<Tab> getTab(List<NewSongTagModel> tags) {
    return tags.map((data) => Tab(text: data.name)).toList();
  }
}
