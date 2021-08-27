import 'package:flutter_cloud_music/common/model/song_model.dart';
import 'package:get/get.dart';

class PlayerService extends GetxService {
  static PlayerService get to => Get.find();

  final curPlay = Rx<Song?>(null);
  Song? get getCurPlayValue => curPlay.value;
}
