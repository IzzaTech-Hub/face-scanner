import 'package:face_scanner/app/modules/setting/controller/settings_view_ctl.dart';
import 'package:face_scanner/app/providers/admob_ads_provider.dart';
import 'package:face_scanner/app/utills/CM.dart';
import 'package:face_scanner/app/utills/appstring.dart';
import 'package:face_scanner/app/utills/colors.dart';
import 'package:face_scanner/app/utills/images.dart';
import 'package:face_scanner/app/utills/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class SettingsView extends GetView<SettingsCTL> {
   SettingsView({super.key});

   
    // // // Banner Ad Implementation start // // //
//? Commented by jamal start
  late BannerAd myBanner;
  RxBool isBannerLoaded = false.obs;

  initBanner() {
    BannerAdListener listener = BannerAdListener(
      // Called when an ad is successfully received.
      onAdLoaded: (Ad ad) {
        print('Ad loaded.');
        isBannerLoaded.value = true;
      },
      // Called when an ad request failed.
      onAdFailedToLoad: (Ad ad, LoadAdError error) {
        // Dispose the ad here to free resources.
        ad.dispose();
        print('Ad failed to load: $error');
      },
      // Called when an ad opens an overlay that covers the screen.
      onAdOpened: (Ad ad) {
        print('Ad opened.');
      },
      // Called when an ad removes an overlay that covers the screen.
      onAdClosed: (Ad ad) {
        print('Ad closed.');
      },
      // Called when an impression occurs on the ad.
      onAdImpression: (Ad ad) {
        print('Ad impression.');
      },
    );

    myBanner = BannerAd(
      adUnitId: AppStrings.ADMOB_BANNER,
      size: AdSize.banner,
      request: AdRequest(),
      listener: listener,
    );
    myBanner.load();
  } //? Commented by jamal end

  /// Banner Ad Implementation End ///

  // // // Native Ad Implementation start // // //

  //? commented by jamal start
  NativeAd? nativeAd;
  RxBool nativeAdIsLoaded = false.obs;

  initNative() {
    nativeAd = NativeAd(
      adUnitId: AppStrings.ADMOB_NATIVE,
      request: AdRequest(),
      // factoryId: ,
      nativeTemplateStyle:
          NativeTemplateStyle(templateType: TemplateType.medium),
      listener: NativeAdListener(
        onAdLoaded: (Ad ad) {
          print('$NativeAd loaded.');

          nativeAdIsLoaded.value = true;
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('$NativeAd failedToLoad: $error');
          ad.dispose();
        },
        onAdOpened: (Ad ad) => print('$NativeAd onAdOpened.'),
        onAdClosed: (Ad ad) => print('$NativeAd onAdClosed.'),
      ),
    )..load();
  }
  //? commented by jamal end

  /// Native Ad Implemntation End ///


  @override
  Widget build(BuildContext context) {
    initBanner();
    initNative();
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Settings",
            style: TextStyle(
                fontSize: SizeConfig.blockSizeHorizontal * 6,
                color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          leading: GestureDetector(
              onTap: () {
                AdMobAdsProvider.instance.showInterstitialAd(() {});
                Get.back();
              },
              child: Icon(Icons.arrow_back_ios_new_rounded)),
        ),
        body: Column(
          children: [
             verticalSpace(SizeConfig.blockSizeVertical * 1),

                          Obx(() => isBannerLoaded.value &&
                    AdMobAdsProvider.instance.isAdEnable.value
                ? Container(
                    height: AdSize.banner.height.toDouble(),
                    child: AdWidget(ad: myBanner))
                : Container(
                 
                )), 
          verticalSpace(SizeConfig.blockSizeVertical * 2),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              AppImages.main_icon,
              width: SizeConfig.blockSizeHorizontal * 40,
              height: SizeConfig.blockSizeHorizontal * 40,
              fit: BoxFit.cover,
            ),
          ),
          GestureDetector(
            onTap: () {
              controller.rateApp();
              // LaunchReview.launch(
              //   androidAppId: "",
              // );
            },
            child: settings_btn(
                "Rate us",
                CupertinoIcons.hand_thumbsup_fill,
                "Help us to grow with your 5 star",
                Icons.arrow_forward_ios_rounded,
                context),
          ),
          GestureDetector(
            onTap: () {
              controller.ShareApp();
            },
            child: settings_btn("Invite your friends", Icons.person_add_alt_1,
                "Spread the World", Icons.arrow_forward_ios_rounded, context),
          ),
verticalSpace(SizeConfig.blockSizeVertical * 2),
              Obx(
                  () =>  AdMobAdsProvider.instance.isAdEnable.value
                          ? Center(
                              child: Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal:
                                          SizeConfig.blockSizeHorizontal * 5),
                                  child: NativeAdMethed(
                                      nativeAd, nativeAdIsLoaded)),
                            )
                          : Container(),
                )
        ]));
  }

  Padding settings_btn(String text1, IconData icon1, String text2,
      IconData icon2, BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: SizeConfig.blockSizeVertical * 4,
          left: SizeConfig.blockSizeHorizontal * 7,
          right: SizeConfig.blockSizeHorizontal * 5),
      child: Row(
        children: [
          Icon(
            icon1,
            color: AppColors.primaryColor,
            size: SizeConfig.blockSizeHorizontal * 7,
          ),
          horizontalSpace(SizeConfig.blockSizeHorizontal * 6),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                text1,
                style: TextStyle(
                    fontSize: SizeConfig.blockSizeHorizontal * 4,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              Text(
                text2,
                style: TextStyle(
                    fontSize: SizeConfig.blockSizeHorizontal * 3,
                    color: AppColors.primaryColor),
              )
            ],
          ),
          Spacer(),
          Icon(
            icon2,
            color: AppColors.primaryColor,
            size: SizeConfig.blockSizeHorizontal * 6,
          )
        ],
      ),
    );
  }
}
