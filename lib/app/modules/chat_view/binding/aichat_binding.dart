import 'package:face_scanner/app/modules/chat_view/controller/aichat_controller.dart';
import 'package:get/get.dart';

class AichatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AichatController>(
      () => AichatController(),
    );
  }
}
