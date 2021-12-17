import 'package:flutter_cloud_music/common/utils/image_utils.dart';
import 'package:flutter_cloud_music/pages/new_song_album/song/new_song_tag_model.dart';
import 'package:get/get.dart';

class NewSongController extends GetxController {
  final tags = <NewSongTagModel>[
    NewSongTagModel(
        name: '全部', id: 0, imgPath: ImageUtils.getImagePath('img_all')),
    NewSongTagModel(
        name: '推荐',
        id: -1,
        imgPath: ImageUtils.getImagePath('img_r_c', format: 'jpg')),
    NewSongTagModel(
        name: '华语',
        id: 7,
        imgPath: ImageUtils.getImagePath('img_z_h', format: 'jpg')),
    NewSongTagModel(
        name: '欧美',
        id: 96,
        imgPath: ImageUtils.getImagePath('img_e_a', format: 'jpg')),
    NewSongTagModel(
        name: '韩国',
        id: 16,
        imgPath: ImageUtils.getImagePath('img_k_r', format: 'jpg')),
    NewSongTagModel(
        name: '日本',
        id: 8,
        imgPath: ImageUtils.getImagePath('img_j_p', format: 'jpg')),
  ];
}
