import 'package:get/get.dart';
import 'playing_fm_controller.dart';

class PlayingFmBinding extends Bindings {
    @override
    void dependencies() {
    Get.lazyPut<PlayingFmController>(() => PlayingFmController());
    }
}
