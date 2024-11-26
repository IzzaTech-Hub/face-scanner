import 'package:face_scanner/app/routes/app_pages.dart';
import 'package:face_scanner/app/utills/images.dart';
import 'package:face_scanner/app/utills/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Beauty Scanner",
          style: TextStyle(
              fontSize: SizeConfig.blockSizeHorizontal * 5,
              fontWeight: FontWeight.bold),
        ),
        leading: Icon(Icons.menu),
        actions: [Icon(Icons.question_mark_rounded)],
      ),
      body: Column(
        children: [
          Center(
            child: GestureDetector(
              onTap: () {
                Get.toNamed(Routes.FACEBEAUTYANALYSIS);
              },
              child: Container(
                margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 2),
                width: SizeConfig.blockSizeHorizontal * 92,
                height: SizeConfig.blockSizeVertical * 15,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade400, // Shadow color
                        spreadRadius: 2, // Spread radius
                        blurRadius: 10, // Blur radius
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
              Get.toNamed(Routes.FACEREADING);
            },
            child: Container(
              margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 2),
              width: SizeConfig.blockSizeHorizontal * 92,
              height: SizeConfig.blockSizeVertical * 15,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade400, // Shadow color
                      spreadRadius: 2, // Spread radius
                      blurRadius: 10, // Blur radius
                      offset: Offset(0, 5), // Offset in x and y direction
                    ),
                  ],
                  gradient: LinearGradient(colors: [
                    Color.fromARGB(255, 0, 201, 252),
                    Color.fromARGB(255, 140, 223, 241),
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
            padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 5),
            children: [
              GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.CELEBRITYLOOK);
                },
                child: scanner_modes(Color(0xFFD06810), Color(0xFFCA986F),
                    AppImages.celebrity_look, "Looks like a", "Celebrity"),
              ),
              // scanner_modes(
              //     Color.fromARGB(255, 71, 216, 76),
              //     Color.fromARGB(255, 113, 209, 111),
              //     AppImages.facial_symmetry,
              //     "Facial Symmetery",
              //     ""),
              GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.BEAUTYSCORE);
                },
                child: scanner_modes(
                    Color(0xFFBF04C3),
                    Color.fromARGB(255, 226, 134, 228),
                    AppImages.beauty_score,
                    "Beauty Score",
                    "Showdown"),
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
          )
        ],
      ),
    );
  }

  Widget scanner_modes(
      Color color1, Color color2, String image, String text1, String text2) {
    return Container(
      margin: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 2),
      decoration: BoxDecoration(
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
            height: SizeConfig.blockSizeVertical * 10,
            width: SizeConfig.blockSizeHorizontal * 20,
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
