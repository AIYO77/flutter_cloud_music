import 'package:get/get.dart';
import 'music_calendar_controller.dart';

class MusicCalendarBinding extends Bindings {
    @override
    void dependencies() {
    Get.lazyPut<MusicCalendarController>(() => MusicCalendarController());
    }
}
