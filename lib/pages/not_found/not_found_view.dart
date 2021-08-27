import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/widgets/my_app_bar.dart';
import 'package:flutter_cloud_music/widgets/undeveloped.dart';
import 'package:get/get.dart';
import 'not_found_controller.dart';

class NotFoundPage extends GetView<NotFoundController> {
  const NotFoundPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        centerTitle: '未知路由',
      ),
      body: UnDeveloped(),
    );
  }
}
