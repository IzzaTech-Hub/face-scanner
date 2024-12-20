import 'package:get/get_rx/src/rx_types/rx_types.dart';

class GEMS_RATE {
  static const FREE_GEMS = 10;
  static const INTER_INCREAES_GEMS_RATE = 6;
  static const REWARD_INCREAES_GEMS_RATE = 10;

  static const FaceBeautyGems = 5;
  static const FaceReadingGems = 4;
  static const CelebrityLookGems = 6;
  static const BeautyScoreGems = 10;
  static const BeautyCoach = 2;
  static RxInt remianingGems = FREE_GEMS.obs;
}
