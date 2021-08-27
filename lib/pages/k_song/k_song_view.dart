import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/widgets/undeveloped.dart';

import 'package:get/get.dart';
import 'k_song_controller.dart';

class KSongPage extends GetView<KSongController> {
  const KSongPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: UnDeveloped(),
    );
  }
}
