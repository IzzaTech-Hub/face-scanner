// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:face_scanner/app/modules/face_reading/controller/face_reading_ctl.dart';
import 'package:face_scanner/app/utills/size_config.dart';

class DualScannerWidget extends StatefulWidget {
  File image1;
  File image2;
  DualScannerWidget({
    Key? key,
    required this.image1,
    required this.image2,
  }) : super(key: key);

  @override
  State<DualScannerWidget> createState() => _DualScannerWidgetState();
}

class _DualScannerWidgetState extends State<DualScannerWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  late Animation<double> _linePositionAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _linePositionAnimation =
        Tween<double>(begin: 0, end: 90).animate(_animationController);
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        height: SizeConfig.screenHeight,
        width: SizeConfig.screenWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Scanner for Image 1
                _buildScanner(
                  widget.image1,
                  _linePositionAnimation,
                  "Person 1",
                ),
                // Scanner for Image 2
                _buildScanner(
                  widget.image2,
                  _linePositionAnimation,
                  "Person 2",
                ),
              ],
            ),
            // const SizedBox(height: 30),
            verticalSpace(SizeConfig.blockSizeVertical * 23),

            Text(
              'SCANNING...'.tr,
              style: const TextStyle(
                color: Colors.greenAccent,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            verticalSpace(SizeConfig.blockSizeVertical * 2),
            // Progress bar with animation
            Container(
              width: 250,
              height: 20,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.greenAccent),
                borderRadius: BorderRadius.circular(5),
              ),
              child: AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Row(
                    children: List.generate(20, (index) {
                      final basePosition = _animation.value * 20;
                      final distanceFromWave = (basePosition - index).abs();
                      final isInWave = distanceFromWave < 2;
                      final color =
                          isInWave ? Colors.greenAccent : Colors.black;

                      return Expanded(
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 1),
                          color: color,
                        ),
                      );
                    }),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScanner(
      File? imageFile, Animation<double> animation, String label) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(color: Colors.greenAccent),
        ),
        verticalSpace(10),
        Stack(
          alignment: Alignment.center,
          children: [
            DottedBorder(
              borderType: BorderType.Circle,
              color: Colors.greenAccent,
              strokeWidth: 2,
              dashPattern: [6, 3],
              child: Container(
                width: SizeConfig.blockSizeHorizontal * 30,
                height: SizeConfig.blockSizeHorizontal * 30,
              ),
            ),
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.white,
              backgroundImage: imageFile != null ? FileImage(imageFile) : null,
            ),
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                width: SizeConfig.blockSizeHorizontal * 10 / 2,
                height: SizeConfig.blockSizeVertical * 5 / 2,
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Colors.greenAccent, width: 4),
                    left: BorderSide(color: Colors.greenAccent, width: 4),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                width: SizeConfig.blockSizeHorizontal * 10 / 2,
                height: SizeConfig.blockSizeVertical * 5 / 2,
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Colors.greenAccent, width: 4),
                    right: BorderSide(color: Colors.greenAccent, width: 4),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: Container(
                width: SizeConfig.blockSizeHorizontal * 10 / 2,
                height: SizeConfig.blockSizeVertical * 5 / 2,
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.greenAccent, width: 4),
                    left: BorderSide(color: Colors.greenAccent, width: 4),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                width: SizeConfig.blockSizeHorizontal * 10 / 2,
                height: SizeConfig.blockSizeVertical * 5 / 2,
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.greenAccent, width: 4),
                    right: BorderSide(color: Colors.greenAccent, width: 4),
                  ),
                ),
              ),
            ),
            AnimatedBuilder(
              animation: animation,
              builder: (context, child) {
                return Positioned(
                  top: animation.value,
                  child: Container(
                    width: SizeConfig.blockSizeHorizontal * 30,
                    height: 2,
                    color: Colors.greenAccent,
                  ),
                );
              },
            ),
            // Positioned(
            //   bottom: -60,
            //   child: Text(
            //     label,
            //     style: const TextStyle(
            //       color: Colors.greenAccent,
            //       fontSize: 16,
            //       fontWeight: FontWeight.bold,
            //     ),
            //   ),
            // ),
          ],
        ),
      ],
    );
  }
}
