import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/res/gaps.dart';
import 'package:get/get.dart';

import 'logic.dart';

class LoadingPage extends StatelessWidget {
  final LoadingLogic logic = Get.put(LoadingLogic());

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.transparent,
      body: Gaps.empty,
    );
  }
}
