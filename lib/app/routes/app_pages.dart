import 'package:face_scanner/app/modules/home/binding/celebrity_look_binding.dart';
import 'package:face_scanner/app/modules/home/binding/face_reading_binding.dart';
import 'package:face_scanner/app/modules/home/binding/home_view_binding.dart';
import 'package:face_scanner/app/modules/home/views/celebrity_look.dart';
import 'package:face_scanner/app/modules/home/views/face_reading.dart';
import 'package:face_scanner/app/modules/home/views/home_view.dart';
import 'package:get/get.dart';

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
  ];
}
