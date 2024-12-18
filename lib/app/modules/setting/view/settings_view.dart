import 'package:face_scanner/app/modules/setting/controller/settings_view_ctl.dart';
import 'package:face_scanner/app/utills/colors.dart';
import 'package:face_scanner/app/utills/images.dart';
import 'package:face_scanner/app/utills/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsView extends GetView<SettingsCTL> {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
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
                Get.back();
              },
              child: Icon(Icons.arrow_back_ios_new_rounded)),
        ),
        body: Column(children: [
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
