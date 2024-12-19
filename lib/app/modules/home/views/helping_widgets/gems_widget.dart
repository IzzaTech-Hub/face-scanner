import 'package:face_scanner/app/routes/app_pages.dart';
import 'package:face_scanner/app/utills/colors.dart';
import 'package:face_scanner/app/utills/images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class gems_widget extends StatelessWidget {
  const gems_widget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.GEMSVIEW);
      },
      child: Container(
        height: 23,
        width: 60,
        // margin: EdgeInsets.fromLTRB(40, 0, 0, 0),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          // color: Colors.grey[100],
          borderRadius: BorderRadius.circular(20), // Rounded edges
          border: Border.all(
            color: AppColors.primaryColor, // Green border color
            width: 2,
          ),
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image(
              image: AssetImage(AppImages.gems),
              alignment: Alignment.centerLeft,
              width: 18,
              height: 35,
            ),
            // Obx(() =>
            Text(
              'x10',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w900,
              ),
            )
            // ),
          ],
        ),
      ),
    );
  }
}
