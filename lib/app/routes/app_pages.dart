import 'package:get/get.dart';

import '../modules/home/binding/celebrity_look_binding.dart';
import '../modules/home/binding/face_reading_binding.dart';
import '../modules/home/binding/home_view_binding.dart';
import '../modules/home/views/celebrity_look.dart';
import '../modules/home/views/face_reading.dart';
import '../modules/home/views/home_view.dart';
import '../modules/temp/bindings/temp_binding.dart';
import '../modules/temp/views/temp_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOMEVIEW;

  static final routes = [
    GetPage(
      name: _Paths.HOMEVIEW,
      page: () => HomeView(),
      binding: HomeViewBinding(),
    ),
    GetPage(
      name: _Paths.CELEBRITYLOOK,
      page: () => CelebrityLook(),
      binding: CelebrityLookBinding(),
    ),
    GetPage(
      name: _Paths.FACEREADING,
      page: () => FaceReading(),
      binding: FaceReadingBinding(),
    ),
    GetPage(
      name: _Paths.TEMP,
      page: () => const TempView(),
      binding: TempBinding(),
    ),
  ];
}
