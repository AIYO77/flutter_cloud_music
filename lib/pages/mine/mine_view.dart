import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/widgets/undeveloped.dart';

import 'package:get/get.dart';
import 'mine_controller.dart';

class MinePage extends GetView<MineController> {
  const MinePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: UnDeveloped(),
    );
  }
}
