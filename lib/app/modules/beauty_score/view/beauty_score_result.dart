import 'package:face_scanner/app/modules/beauty_score/controller/beauty_score_ctl.dart';
import 'package:face_scanner/app/utills/images.dart';
import 'package:face_scanner/app/utills/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BeautyScoreResult extends GetView<BeautyScoreCtl> {
  const BeautyScoreResult({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Scoreboard",
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
            )),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.blockSizeHorizontal * 4,
                vertical: SizeConfig.blockSizeVertical * 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                        height: SizeConfig.blockSizeVertical * 9,
                        width: SizeConfig.blockSizeHorizontal * 18,
                        decoration: BoxDecoration(shape: BoxShape.circle),
                        child: controller.selectedImage1.value != null
                            ? Container(
                                width: double.infinity,
                                height: 300,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        SizeConfig.blockSizeHorizontal * 13),
                                    border: Border.all(
                                        color: Colors.white, width: 3)),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                      SizeConfig.blockSizeHorizontal * 13),
                                  child: Image.file(
                                    controller.selectedImage1.value!,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              )
                            : Container()),
                    Obx(
                      () => Image.asset(
                        controller.winner.value == 1
                            ? AppImages.beauty_winner_2
                            : AppImages.beauty_winner_1,
                        height: SizeConfig.blockSizeVertical * 12,
                        width: SizeConfig.blockSizeHorizontal * 25,
                      ),
                    ),
                  ],
                ),
                Container(
                  child: Image.asset(
                    AppImages.vs, // Replace with your desired image asset
                    // height: SizeConfig.blockSizeVertical * ,
                    width: SizeConfig.blockSizeHorizontal * 17,
                  ),
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: SizeConfig.blockSizeVertical * 9,
                      width: SizeConfig.blockSizeHorizontal * 18,
                      decoration: BoxDecoration(shape: BoxShape.circle),
                      child: controller.selectedImage2.value != null
                          ? Container(
                              width: double.infinity,
                              height: 300,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      SizeConfig.blockSizeHorizontal * 13),
                                  border: Border.all(
                                      color: Colors.white, width: 3)),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                    SizeConfig.blockSizeHorizontal * 13),
                                child: Image.file(
                                  controller.selectedImage2.value!,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            )
                          : Container(),
                    ),
                    Obx(
                      () => Image.asset(
                        controller.winner.value == 2
                            ? AppImages.beauty_winner_2
                            : AppImages.beauty_winner_1,
                        height: SizeConfig.blockSizeVertical * 12,
                        width: SizeConfig.blockSizeHorizontal * 25,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Obx(
            () => Text(
              "Person ${controller.winner.value} is winner.",
              style: TextStyle(
                  fontSize: SizeConfig.blockSizeHorizontal * 4.5,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          verticalSpace(SizeConfig.blockSizeVertical * 2),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Obx(() {
                return controller.winner.value == 1
                    ? Image.asset(
                        AppImages.crown,
                        width: SizeConfig.blockSizeHorizontal * 10,
                      )
                    : Container(); // Empty container if not the winner
              }),
              Obx(() {
                return controller.winner.value == 2
                    ? Container() // Empty container for the second player (no crown)
                    : Image.asset(
                        AppImages.crown,
                        color: Colors.transparent,
                        width: SizeConfig.blockSizeHorizontal * 10,
                      );
              }),
            ],
          ),

          verticalSpace(SizeConfig.blockSizeVertical * 2),

          // /////////////////////// //
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    height: SizeConfig.blockSizeVertical * 55,
                    width: SizeConfig.blockSizeHorizontal * 12,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Color(0xFF00BDD3),
                              offset: Offset(0, 0),
                              blurRadius: 5,
                              spreadRadius: 5)
                        ],
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(
                              SizeConfig.blockSizeHorizontal * 8),
                          topRight: Radius.circular(
                              SizeConfig.blockSizeHorizontal * 8),
                          bottomLeft: Radius.circular(
                              SizeConfig.blockSizeHorizontal * 2),
                          bottomRight: Radius.circular(
                              SizeConfig.blockSizeHorizontal * 2),
                        ),
                        // border: Border.all(color: Colors.grey, width: 3)
                        color: Color(0xFF00264E)),
                  ),
                  AnimatedStackModule1(),
                ],
              ),
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    height: SizeConfig.blockSizeVertical * 55,
                    width: SizeConfig.blockSizeHorizontal * 12,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Color(0xFF00BDD3),
                              offset: Offset(0, 0),
                              blurRadius: 5,
                              spreadRadius: 5)
                        ],
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(
                              SizeConfig.blockSizeHorizontal * 8),
                          topRight: Radius.circular(
                              SizeConfig.blockSizeHorizontal * 8),
                          bottomLeft: Radius.circular(
                              SizeConfig.blockSizeHorizontal * 2),
                          bottomRight: Radius.circular(
                              SizeConfig.blockSizeHorizontal * 2),
                        ),
                        color: Color(0xFF00264E)
                        // border: Border.all(color: Colors.grey, width: 3)
                        ),
                  ),
                  AnimatedStackModule2(),
                ],
              ),
            ],
          ),
          verticalSpace(SizeConfig.blockSizeVertical * 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "${controller.score1.value}",
                style: TextStyle(
                    fontSize: SizeConfig.blockSizeHorizontal * 4,
                    color: Colors.white),
              ),
              Text(
                "${controller.score2.value}",
                style: TextStyle(
                    fontSize: SizeConfig.blockSizeHorizontal * 4,
                    color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class AnimatedStackModule1 extends StatefulWidget {
  @override
  _AnimatedStackModuleState1 createState() => _AnimatedStackModuleState1();
}

class _AnimatedStackModuleState1 extends State<AnimatedStackModule1>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _heightAnimation;
  bool _showImages = false;

  final controller =
      Get.find<BeautyScoreCtl>(); // Replace with your controller class

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    _heightAnimation =
        Tween<double>(begin: 0, end: 0.01 * (10 * controller.score1.value))
            .animate(_controller)
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              setState(() {
                _showImages = true;
              });
            }
          });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          margin: EdgeInsets.symmetric(
              vertical: SizeConfig.blockSizeHorizontal * 1),
          height: (SizeConfig.blockSizeVertical * 55 -
                  SizeConfig.blockSizeHorizontal * 2) *
              _heightAnimation.value,
          width: SizeConfig.blockSizeHorizontal * 10,
          decoration: BoxDecoration(
            color: Color(0xFF00CABD),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(SizeConfig.blockSizeHorizontal * 8),
              topRight: Radius.circular(SizeConfig.blockSizeHorizontal * 8),
              bottomLeft: Radius.circular(SizeConfig.blockSizeHorizontal * 2),
              bottomRight: Radius.circular(SizeConfig.blockSizeHorizontal * 2),
            ),
          ),
        ),
        if (_showImages)
          Stack(
            alignment: Alignment.center,
            children: [
              controller.selectedImage1.value != null
                  ? Container(
                      width: SizeConfig.blockSizeHorizontal * 10.5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            SizeConfig.blockSizeHorizontal * 13),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                            SizeConfig.blockSizeHorizontal * 13),
                        child: Image.file(
                          controller.selectedImage1.value!,
                          fit: BoxFit.fill,
                        ),
                      ),
                    )
                  : Container(),
              Obx(
                () => Image.asset(
                  controller.winner.value == 1
                      ? 'assets/images/beauty_winner_2.png'
                      : 'assets/images/beauty_winner_1.png',
                  width: SizeConfig.blockSizeHorizontal * 15,
                ),
              ),
            ],
          ),
      ],
    );
  }
}

class AnimatedStackModule2 extends StatefulWidget {
  @override
  _AnimatedStackModuleState2 createState() => _AnimatedStackModuleState2();
}

class _AnimatedStackModuleState2 extends State<AnimatedStackModule2>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _heightAnimation;
  bool _showImages = false;

  final controller =
      Get.find<BeautyScoreCtl>(); // Replace with your controller class

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    _heightAnimation =
        Tween<double>(begin: 0, end: 0.01 * (10 * controller.score2.value))
            .animate(_controller)
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              setState(() {
                _showImages = true;
              });
            }
          });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          margin: EdgeInsets.symmetric(
              vertical: SizeConfig.blockSizeHorizontal * 1),
          height: (SizeConfig.blockSizeVertical * 55 -
                  SizeConfig.blockSizeHorizontal * 2) *
              _heightAnimation.value,
          width: SizeConfig.blockSizeHorizontal * 10,
          decoration: BoxDecoration(
            color: Color(0xFF00CABD),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(SizeConfig.blockSizeHorizontal * 8),
              topRight: Radius.circular(SizeConfig.blockSizeHorizontal * 8),
            ),
          ),
        ),
        if (_showImages)
          Stack(
            alignment: Alignment.center,
            children: [
              controller.selectedImage2.value != null
                  ? Container(
                      width: SizeConfig.blockSizeHorizontal * 10.5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            SizeConfig.blockSizeHorizontal * 13),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                            SizeConfig.blockSizeHorizontal * 13),
                        child: Image.file(
                          controller.selectedImage2.value!,
                          fit: BoxFit.fill,
                        ),
                      ),
                    )
                  : Container(),
              Obx(
                () => Image.asset(
                  controller.winner.value == 2
                      ? 'assets/images/beauty_winner_2.png'
                      : 'assets/images/beauty_winner_1.png',
                  width: SizeConfig.blockSizeHorizontal * 15,
                ),
              ),
            ],
          ),
      ],
    );
  }
}
