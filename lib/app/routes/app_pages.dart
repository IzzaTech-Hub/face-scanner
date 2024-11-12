import 'package:face_scanner/app/modules/binding/celebrity_look_binding.dart';
import 'package:face_scanner/app/modules/binding/home_view_binding.dart';
import 'package:face_scanner/app/modules/views/celebrity_look.dart';
import 'package:face_scanner/app/modules/views/home_view.dart';
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
  ];
}
