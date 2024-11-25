import 'package:dotted_border/dotted_border.dart';
import 'package:face_scanner/app/modules/face_reading/controller/face_reading_ctl.dart';
import 'package:face_scanner/app/utills/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScannerWidget extends StatefulWidget {
  const ScannerWidget({super.key});

  @override
  State<ScannerWidget> createState() => _ScannerWidgetState();
}

class _ScannerWidgetState extends State<ScannerWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  late Animation<double> _linePositionAnimation;
  double _scanningProgress = 0.0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _linePositionAnimation =
        Tween<double>(begin: 0, end: 180).animate(_animationController);
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);
    // Simulate progress
    // _simulateScanningProgress();
  }

  void _simulateScanningProgress() {
    Future.delayed(Duration(milliseconds: 100), () {
      if (_scanningProgress < 100) {
        setState(() {
          _scanningProgress += 5;
        });
        _simulateScanningProgress();
      }
    });
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
      body: GetX<FaceReadingCtl>(
        builder: (controller) {
          return Container(
            height: SizeConfig.screenHeight,
            width: SizeConfig.screenWidth,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    DottedBorder(
                      borderType: BorderType.Circle,
                      color: Colors.greenAccent,
                      strokeWidth: 2,
                      dashPattern: [6, 3],
                      child: Container(
                        width: 200,
                        height: 200,
                      ),
                    ),
                    CircleAvatar(
                      radius: 95,
                      backgroundColor: Colors.white,
                      backgroundImage: controller.selectedImage.value != null
                          ? FileImage(controller.selectedImage.value!)
                          : null,
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      child: Container(
                        width: SizeConfig.blockSizeHorizontal * 10,
                        height: SizeConfig.blockSizeVertical * 5,
                        decoration: BoxDecoration(
                          border: Border(
                            top:
                                BorderSide(color: Colors.greenAccent, width: 4),
                            left:
                                BorderSide(color: Colors.greenAccent, width: 4),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        width: SizeConfig.blockSizeHorizontal * 10,
                        height: SizeConfig.blockSizeVertical * 5,
                        decoration: BoxDecoration(
                          border: Border(
                            top:
                                BorderSide(color: Colors.greenAccent, width: 4),
                            right:
                                BorderSide(color: Colors.greenAccent, width: 4),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      child: Container(
                        width: SizeConfig.blockSizeHorizontal * 10,
                        height: SizeConfig.blockSizeVertical * 5,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom:
                                BorderSide(color: Colors.greenAccent, width: 4),
                            left:
                                BorderSide(color: Colors.greenAccent, width: 4),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: SizeConfig.blockSizeHorizontal * 10,
                        height: SizeConfig.blockSizeVertical * 5,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom:
                                BorderSide(color: Colors.greenAccent, width: 4),
                            right:
                                BorderSide(color: Colors.greenAccent, width: 4),
                          ),
                        ),
                      ),
                    ),
                    // Scanning line with animation
                    AnimatedBuilder(
                      animation: _linePositionAnimation,
                      builder: (context, child) {
                        return Positioned(
                          top: _linePositionAnimation.value,
                          child: Container(
                            width: 180,
                            height: 2,
                            color: Colors.greenAccent,
                          ),
                        );
                      },
                    ),
                  ],
                ),
                SizedBox(height: 30),

                Text(
                  'SCANNING...'.tr,
                  style: TextStyle(
                    color: Colors.greenAccent,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
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
                          // Calculate how far each block is from the animated position
                          final basePosition = _animation.value * 20;
                          final distanceFromWave = (basePosition - index).abs();

                          // If within 0, 1, or 2 steps of the animated position, highlight it
                          final isInWave = distanceFromWave < 2;
                          final color = isInWave
                              ? Colors.greenAccent
                              // .withOpacity(1 - (distanceFromWave / 3))
                              : Colors.black;

                          return Expanded(
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 1),
                              color: color,
                            ),
                          );
                        }),
                      );
                    },
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
