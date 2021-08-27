import 'package:get/get.dart';
import 'k_song_controller.dart';

class KSongBinding extends Bindings {
    @override
    void dependencies() {
    Get.lazyPut<KSongController>(() => KSongController());
    }
}
