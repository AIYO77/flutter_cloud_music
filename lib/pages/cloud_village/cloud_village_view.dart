import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/widgets/undeveloped.dart';
import 'package:get/get.dart';
import 'cloud_village_controller.dart';

class CloudVillagePage extends StatelessWidget {
  CloudVillagePage({Key? key}) : super(key: key);

  final controller = GetInstance().putOrFind(() => CloudVillageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: UnDeveloped(),
    );
  }
}
