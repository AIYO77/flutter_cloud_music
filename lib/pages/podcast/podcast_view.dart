import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/widgets/undeveloped.dart';

import 'package:get/get.dart';
import 'podcast_controller.dart';

class PodcastPage extends GetView<PodcastController> {
  const PodcastPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: UnDeveloped(),
    );
  }
}
