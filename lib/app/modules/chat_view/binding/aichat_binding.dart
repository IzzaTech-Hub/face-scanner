import 'package:get/get.dart';

import '../controllers/aichat_controller.dart';

class AichatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AichatController>(
      () => AichatController(),
    );
  }
}
