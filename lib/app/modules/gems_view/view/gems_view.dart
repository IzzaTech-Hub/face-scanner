import 'package:face_scanner/app/modules/gems_view/controller/gems_view_ctl.dart';
import 'package:face_scanner/app/providers/admob_ads_provider.dart';
import 'package:face_scanner/app/providers/applovin_ads.provider.dart';
import 'package:face_scanner/app/utills/CM.dart';
import 'package:face_scanner/app/utills/appstring.dart';
import 'package:face_scanner/app/utills/colors.dart';
import 'package:face_scanner/app/utills/gems_rate.dart';
import 'package:face_scanner/app/utills/images.dart';
import 'package:face_scanner/app/utills/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class GemsView extends GetView<GemsViewController> {
  GemsView({Key? key}) : super(key: key);

    
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
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade100,
        centerTitle: true,
        title: Text(
          'Get GEMS',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        leading: GestureDetector(
            onTap: () {
              AdMobAdsProvider.instance.showInterstitialAd(() {});
              Get.back();
            },
            child: Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
            )),
        // centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
              verticalSpace(SizeConfig.blockSizeVertical * 1),

                          Obx(() => isBannerLoaded.value &&
                    AdMobAdsProvider.instance.isAdEnable.value
                ? Container(
                    height: AdSize.banner.height.toDouble(),
                    child: AdWidget(ad: myBanner))
                : Container(
                 
                )), 
            SizedBox(
              height: SizeConfig.screenHeight * 0.01,
            ),
            Text(
              'Available GEMS',
              style: TextStyle(
                  fontSize: SizeConfig.blockSizeHorizontal * 6,
                  color: Colors.black),
            ),
            SizedBox(
              height: SizeConfig.screenHeight * 0.03,
            ),
            GestureDetector(
              onTap: () {
                controller.hackMethod();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    AppImages.gems,
                    scale: 10,
                  ),
                  // Obx(
                  //   () =>
                  // Text(" ${controller.shoppingCTL.gems.value}", //! Commented by jamal! //
                  Obx(() => Text("${GEMS_RATE.remianingGems.value}",
                      style: TextStyle(
                          fontSize: SizeConfig.blockSizeHorizontal * 7,
                          color: Colors.black))),
                  // )
                  // SizedBox(width: SizeConfig.screenWidth *0.03,)
                ],
              ),
            ),
            SizedBox(
              height: SizeConfig.screenHeight * 0.03,
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'Watch Ads To Get GEMS:',
                        style: TextStyle(
                            fontSize: SizeConfig.blockSizeHorizontal * 4,
                            color: Colors.black),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.01,
                  ),
                  Ad_GEM_widget(),
                ],
              ),
            ),

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
          ],
        ),
      ),
    );
  }

  Widget Ad_GEM_widget() {
    return Column(
      children: [
        SizedBox(
          height: SizeConfig.screenHeight * 0.03,
        ),
        // ElevatedButton(onPressed: (){}, child: Text("Watch Interstitial AD (${GEMS_RATE.INTER_INCREAES_GEMS_RATE} GEMS)")),
        GestureDetector(
          onTap: () {
            AdMobAdsProvider.instance.showInterstitialAd(controller.increase_inter_gems);
            // AppLovinProvider.instance
            //     .showInterstitial(controller.increase_inter_gems);
            // AdMobAdsProvider.instance
            //     .showInterstitialAd(controller.increase_inter_gems);
          },
          child: Container(
            width: SizeConfig.screenWidth * 0.8,
            height: SizeConfig.screenHeight * 0.06,
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.primaryColor, // Set the border color here
                width: 2.0, // Set the border width here
              ),
              borderRadius: BorderRadius.circular(40.0),
            ),
            child: Center(
                child: Text(
              "Watch Short Video AD (${GEMS_RATE.INTER_INCREAES_GEMS_RATE} GEMS)", //! Commented by jamal! //
              // "Watch Interstitial AD (GEMS)",
              style: TextStyle(fontSize: SizeConfig.blockSizeHorizontal * 4),
            )),
          ),
        ),
        SizedBox(
          height: SizeConfig.screenHeight * 0.02,
        ),
        GestureDetector(
          onTap: () {
            AdMobAdsProvider.instance.showInterstitialAd(controller.increase_reward_gems);
            // AppLovinProvider.instance
            //     .showRewardedAd(controller.increase_reward_gems);
            // AdMobAdsProvider.instance
            //     .ShowRewardedAd(controller.increase_reward_gems);
          },
          child: Container(
            width: SizeConfig.screenWidth * 0.8,
            height: SizeConfig.screenHeight * 0.06,
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.primaryColor, // Set the border color here
                width: 2.0, // Set the border width here
              ),
              borderRadius: BorderRadius.circular(40.0),
            ),
            child: Center(
                child: Text(
              // "Watch Video AD (${GEMS_RATE.REWARD_INCREAES_GEMS_RATE} GEMS)", //! Commented by jamal! //
              "Watch Long Video AD (${GEMS_RATE.REWARD_INCREAES_GEMS_RATE} GEMS )",
              style: TextStyle(fontSize: SizeConfig.blockSizeHorizontal * 4),
            )),
          ),
        ),
        // ElevatedButton(onPressed: (){}, child: Text("Watch Video AD (${GEMS_RATE.REWARD_INCREAES_GEMS_RATE} GEMS)")),
        SizedBox(
          height: SizeConfig.screenHeight * 0.03,
        ),

        // Padding(
        //   padding:  EdgeInsets.all(10),
        //   child: Row(
        //     children: [
        //       Text(
        //                           'Buy GEMS',
        //                           style: StyleSheet.sub_heading12,
        //                         ),
        //     ],
        //   ),
        // ),
      ],
    );
  }

  Widget BUY_GEM_widget(context) {
    return Column(
      children: [
        SizedBox(
          height: SizeConfig.screenHeight * 0.02,
        ),
        // ElevatedButton(onPressed: (){}, child: Text("Watch Interstitial AD (${GEMS_RATE.INTER_INCREAES_GEMS_RATE} GEMS)")),
        GestureDetector(
          onTap: () {
            //[j.] NavCTL navCTL = Get.find();
            // navCTL.subscriptionCall();
            // Get.toNamed(Routes.SUBSCRIPTION);
            _settingModalBottomSheet(context);
          },
          child: Container(
            width: SizeConfig.screenWidth * 0.8,
            height: SizeConfig.screenHeight * 0.06,
            decoration: BoxDecoration(
              border: Border.all(
                color:
                    AppColors.primaryColorShade100, // Set the border color here
                width: 2.0, // Set the border width here
              ),
              borderRadius: BorderRadius.circular(40.0),
            ),
            // child: Center(child: Text("Become Subscriber",style: StyleSheet.Intro_Sub_heading2,)),),
            child: Center(
                child: Text(
              "Buy GEMS",
              // style:
              //  StyleSheet.Intro_Sub_heading2,
            )),
          ),
        ),
        //   SizedBox(height: SizeConfig.screenHeight *0.02,),
        // Container(
        //   width: SizeConfig.screenWidth *0.8,
        //   height: SizeConfig.screenHeight *0.06,
        //               decoration: BoxDecoration(
        //                 border: Border.all(
        //                   color: AppColors.icon_color, // Set the border color here
        //                   width: 2.0, // Set the border width here
        //                 ),
        //                 borderRadius: BorderRadius.circular(40.0),
        //               ),
        //   child: Center(child: Text("Watch Video AD (${GEMS_RATE.REWARD_INCREAES_GEMS_RATE} GEMS)",style: StyleSheet.Intro_Sub_heading2,)),),
        // // ElevatedButton(onPressed: (){}, child: Text("Watch Video AD (${GEMS_RATE.REWARD_INCREAES_GEMS_RATE} GEMS)")),
        // SizedBox(height: SizeConfig.screenHeight *0.03,),
        // Padding(
        //   padding:  EdgeInsets.all(10),
        //   child: Row(
        //     children: [
        //       Text(
        //                           'Buy GEMS',
        //                           style: StyleSheet.sub_heading12,
        //                         ),
        //     ],
        //   ),
        // ),
      ],
    );
  }

  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: new Wrap(
              children: <Widget>[
                Row(
                  children: [],
                ),
                new ListTile(
                    leading: new Icon(Icons.music_note),
                    title: new Text('Music'),
                    onTap: () => {}),
                new ListTile(
                  leading: new Icon(Icons.videocam),
                  title: new Text('Video'),
                  onTap: () => {},
                ),
              ],
            ),
          );
        });
  }
}
