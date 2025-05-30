import 'package:face_scanner/app/data/myenums.dart';
import 'package:face_scanner/app/modules/home/views/helping_widgets/gems_widget.dart';
import 'package:face_scanner/app/providers/applovin_ads.provider.dart';
import 'package:face_scanner/app/routes/app_pages.dart';
import 'package:face_scanner/app/utills/colors.dart';
import 'package:face_scanner/app/utills/images.dart';
import 'package:face_scanner/app/utills/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:in_app_review/in_app_review.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      // backgroundColor: Color(0xFFFAF9F6),
      // floatingActionButton: FloatingActionButton(
      //     onPressed: () {
      //       Get.toNamed(Routes.AICHATVIEW);
      //     },
      //     backgroundColor: AppColors.primaryColor,
      //     shape: CircleBorder(),
      //     child: Image.asset(
      //       AppImages.chat_support,
      //       color: Colors.white,
      //       height: SizeConfig.blockSizeVertical * 4,
      //     )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.dialog(
            Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Choose Your Coach',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  SizeConfig.blockSizeHorizontal * 4),
                              child: GestureDetector(
                                onTap: () {
                                  Get.back();
                                  Get.toNamed(Routes.AICHATVIEW,
                                      arguments: CoachType.male);
                                },
                                child: Image.asset(
                                  AppImages.male_coach,
                                  height: 80,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Male Coach",
                              style: TextStyle(
                                fontSize: SizeConfig.blockSizeHorizontal * 3.5,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  SizeConfig.blockSizeHorizontal * 4),
                              child: GestureDetector(
                                onTap: () {
                                  Get.back();
                                  Get.toNamed(Routes.AICHATVIEW,
                                      arguments: CoachType.female);
                                },
                                child: Image.asset(
                                  AppImages.female_coach,
                                  height: 80,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Female Coach",
                              style: TextStyle(
                                fontSize: SizeConfig.blockSizeHorizontal * 3.5,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        backgroundColor: AppColors.primaryColor,
        shape: CircleBorder(),
        child: Image.asset(
          AppImages.chat_support,
          color: Colors.white,
          height: SizeConfig.blockSizeVertical * 4,
        ),
      ),

      // appBar: AppBar(
      //   centerTitle: true,
      //   title: Text(
      //     "Face Scanner",
      //     style: TextStyle(
      //         fontSize: SizeConfig.blockSizeHorizontal * 5,
      //         fontWeight: FontWeight.bold),
      //   ),
      //   // leading: Icon(Icons.chat),

      //   actions: [
      //     gems_widget(),
      //     Padding(
      //       padding: EdgeInsets.symmetric(
      //           horizontal: SizeConfig.blockSizeHorizontal * 2),
      //       child: GestureDetector(
      //           onTap: () {
      //             Get.toNamed(Routes.SETTINGSVIEW);
      //           },
      //           child: Icon(Icons.settings_sharp)),
      //     )
      //   ],
      // ),

      body: Container(
        height: SizeConfig.screenHeight,
        width: SizeConfig.screenWidth,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Color(0xFFF5E8F7),
          Color(0xFFE8F4FE),

          Color(0xFFFFF4E6),
          // //Soft Breeze
          // Color(0xFFE0F7FA),
          // Color(0xFFE8F5E9),
          // //Blush Mist
          // Color(0xFFFFF0F6),
          // Color(0xFFFCE4EC),
          // // Light Lavender
          // Color(0xFFF3E5F5),
          // Color(0xFFF3E5F5),
          // // Sky Whisper
          // Color(0xFFF0F4FF),
          // Color(0xFFF3F9FF),
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Left Section (Optional Leading Icon)
                  const SizedBox(
                      width: 85), // Placeholder for symmetry if no leading icon

                  // Center Title
                  Expanded(
                    child: Center(
                      child: Text(
                        "Face Scanner",
                        style: TextStyle(
                          fontSize: SizeConfig.blockSizeHorizontal * 6,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  // Right Section
                  Row(
                    children: [
                      gems_widget(),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(Routes.SETTINGSVIEW);
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: SizeConfig.blockSizeHorizontal * 2,
                          ),
                          child: Icon(Icons.settings_sharp),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            verticalSpace(SizeConfig.blockSizeVertical * 3),
            Center(
              child: GestureDetector(
                onTap: () {
                  AppLovinProvider.instance.showInterstitial(() {});
                  Get.toNamed(Routes.FACEBEAUTYANALYSIS);
                },
                child: Container(
                  margin:
                      EdgeInsets.only(top: SizeConfig.blockSizeVertical * 2),
                  width: SizeConfig.blockSizeHorizontal * 92,
                  height: SizeConfig.blockSizeVertical * 15,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFFF4AEBF), // Shadow color
                          spreadRadius: 1, // Spread radius
                          blurRadius: 5, // Blur radius
                          offset: Offset(0, 5), // Offset in x and y direction
                        ),
                      ],
                      gradient: LinearGradient(
                          colors: [Color(0xFFFF378B), Color(0xFFF4AEBF)],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter),
                      borderRadius: BorderRadius.circular(
                          SizeConfig.blockSizeHorizontal * 4)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        alignment: Alignment.bottomCenter,
                        decoration: BoxDecoration(),
                        child: Image.asset(
                          AppImages.face_beauty,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: SizeConfig.blockSizeVertical * 10,
                            width: SizeConfig.blockSizeHorizontal * 20,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  SizeConfig.blockSizeHorizontal * 7),
                            ),
                            child: Image.asset(
                              AppImages.analysis,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Face Beauty Analysis",
                            style: TextStyle(
                                fontSize: SizeConfig.blockSizeHorizontal * 4,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                AppLovinProvider.instance.showInterstitial(() {});
                Get.toNamed(Routes.FACEREADING);
              },
              child: Container(
                margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 2),
                width: SizeConfig.blockSizeHorizontal * 92,
                height: SizeConfig.blockSizeVertical * 15,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFF8CDFF1), // Shadow color
                        spreadRadius: 1, // Spread radius
                        blurRadius: 5, // Blur radius
                        offset: Offset(0, 5), // Offset in x and y direction
                      ),
                    ],
                    gradient: LinearGradient(colors: [
                      Color(0xFF00C9FC),
                      Color(0xFF8CDFF1),
                    ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
                    borderRadius: BorderRadius.circular(
                        SizeConfig.blockSizeHorizontal * 4)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      alignment: Alignment.bottomCenter,
                      decoration: BoxDecoration(),
                      child: Image.asset(
                        AppImages.face_reading,
                        height: SizeConfig.blockSizeVertical * 13,
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: SizeConfig.blockSizeVertical * 10,
                          width: SizeConfig.blockSizeHorizontal * 20,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                SizeConfig.blockSizeHorizontal * 7),
                          ),
                          child: Image.asset(
                            AppImages.analysis,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          "Face Reading",
                          style: TextStyle(
                              fontSize: SizeConfig.blockSizeHorizontal * 4,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            GridView.count(
              crossAxisCount: 2,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 2),
              children: [
                GestureDetector(
                  onTap: () {
                    AppLovinProvider.instance.showInterstitial(() {});
                    Get.toNamed(Routes.CELEBRITYLOOK);
                  },
                  child: scanner_modes(
                      Color(0xFFD06810),
                      Color(0xFFCA986F),
                      AppImages.celebrity_look,
                      "Looks like a",
                      "Celebrity",
                      Color(0xFFCA986F)),
                ),
                // scanner_modes(
                //     Color.fromARGB(255, 71, 216, 76),
                //     Color.fromARGB(255, 113, 209, 111),
                //     AppImages.facial_symmetry,
                //     "Facial Symmetery",
                //     ""),
                GestureDetector(
                  onTap: () {
                    AppLovinProvider.instance.showInterstitial(() {});
                    Get.toNamed(Routes.BEAUTYSCORE);
                  },
                  child: scanner_modes(
                    Color(0xFFBF04C3),
                    Color(0xFFE286E4),
                    AppImages.beauty_score,
                    "Beauty Score",
                    "Showdown",
                    Color(0xFFE286E4),
                  ),
                ),
                // scanner_modes(
                // Color.fromARGB(255, 0, 201, 252),
                // Color.fromARGB(255, 140, 223, 241),
                //     AppImages.face_resemblance,
                //     "Facial",
                //     "Resemblance"),
                // GestureDetector(
                //   onTap: () {
                //     Get.toNamed(Routes.FACEREADING);
                //   },
                //   child: scanner_modes(
                //       Color(0xFF7E51FF),
                //       Color.fromARGB(255, 161, 134, 238),
                //       AppImages.face_reading,
                //       "Face Reading",
                //       ""),
                // ),
                // scanner_modes(
                // Color.fromARGB(255, 236, 240, 14),
                // Color.fromARGB(255, 228, 240, 102),
                //     AppImages.beauty_tips,
                //     "Beauty Tips",
                //     ""),
              ],
            ),
            Spacer(),
            Container(
                          height: SizeConfig.blockSizeVertical * 10,
                          margin: EdgeInsets.only(bottom: SizeConfig.blockSizeVertical * 1),
                          // margin: EdgeInsets.only(
                          //     top: SizeConfig.blockSizeVertical * 20),
                          width: double.infinity,
                          child: GestureDetector(
                            onTap: () async {
                              final InAppReview inAppReview =
                                  InAppReview.instance;

                              inAppReview.openStoreListing();
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                      bottom:
                                          SizeConfig.blockSizeVertical * 0.5),
                                  child: Text(
                                    "Rate Us",
                                    style: GoogleFonts.alata(
                                        color: Colors.black,
                                        fontSize:
                                            SizeConfig.blockSizeHorizontal *
                                                3.5,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: Colors.grey,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
         
          ],
        ),
      ),
    );
  }

  Widget scanner_modes(Color color1, Color color2, String image, String text1,
      String text2, Color shadowColor) {
    return Container(
      margin: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 2),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: shadowColor, // Shadow color
              spreadRadius: 1, // Spread radius
              blurRadius: 5, // Blur radius
              offset: Offset(0, 5), // Offset in x and y direction
            ),
          ],
          borderRadius:
              BorderRadius.circular(SizeConfig.blockSizeHorizontal * 6),
          gradient: LinearGradient(
              colors: [color1, color2],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            height: SizeConfig.blockSizeVertical * 12,
            width: SizeConfig.blockSizeHorizontal * 30,
            child: Image.asset(image),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text1,
                style: TextStyle(
                    fontSize: SizeConfig.blockSizeHorizontal * 4,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Text(
                text2,
                style: TextStyle(
                    fontSize: SizeConfig.blockSizeHorizontal * 4,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
