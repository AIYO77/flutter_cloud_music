import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/pages/singer_list/view.dart';
import 'package:flutter_cloud_music/widgets/my_app_bar.dart';

class SingerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(centerTitle: '歌手分类'),
      body: SingerListPage(),
    );
  }
}
