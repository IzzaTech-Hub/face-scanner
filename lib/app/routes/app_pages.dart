import 'package:face_scanner/app/modules/beauty_score/binding/beauty_score_binding.dart';
import 'package:face_scanner/app/modules/celebrity_look/binding/celebrity_look_binding.dart';
import 'package:face_scanner/app/modules/face_reading/binding/face_reading_binding.dart';
import 'package:face_scanner/app/modules/home/binding/home_view_binding.dart';
import 'package:face_scanner/app/modules/beauty_score/view/beauty_score.dart';
import 'package:face_scanner/app/modules/beauty_score/view/beauty_score_result.dart';
import 'package:face_scanner/app/modules/celebrity_look/view/celebrity_look.dart';
import 'package:face_scanner/app/modules/face_beauty_analysis/views/face_beauty_analysis.dart';
import 'package:face_scanner/app/modules/face_reading/view/face_reading.dart';
import 'package:face_scanner/app/modules/home/views/home_view.dart';
import 'package:get/get.dart';

import '../modules/celebrity_look/binding/celebrity_look_binding.dart';
import '../modules/face_reading/binding/face_reading_binding.dart';
import '../modules/home/binding/home_view_binding.dart';
import '../modules/celebrity_look/view/celebrity_look.dart';
import '../modules/face_reading/view/face_reading.dart';
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
    GetPage(
      name: _Paths.BEAUTYSCORE,
      page: () => BeautyScore(),
      binding: BeautyScoreBinding(),
    ),
    GetPage(
      name: _Paths.BEAUTYSCORERESULT,
      page: () => BeautyScoreResult(),
      // binding:
    ),
    GetPage(
        name: _Paths.FACEBEAUTYANALYSIS,
        page: () => FaceBeautyAnalysis(),
        binding: FaceReadingBinding()),
  ];
}
