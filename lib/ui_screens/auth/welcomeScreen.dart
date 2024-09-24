import 'package:fixit/common/bordered_button.dart';
import 'package:fixit/common/color_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../Routes/app_routes.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<String> welcomePages = [
    "Welcome to Page 1",
    "Welcome to Page 2",
    "Welcome to Page 3",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: ColorConstants.primaryColor,
              height: 45.h,
              child: PageView.builder(
                controller: _pageController,
                itemCount: welcomePages.length,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                itemBuilder: (context, index) {
                  return Center(
                    child:Image.asset("assets/images/bullet${index + 1}.png",width:35.w,height:35.h,),
                  );
                },
              ),
            ),
            SizedBox(height:2.h,),
            buildBullets(),
            SizedBox(height:3.h,),
            Center(
              child:_currentPage.isOdd? Text("Rate For Provider & \n Our Application".tr,style:TextStyle(fontSize: 25,color:Theme.of(context).colorScheme.tertiary),textAlign:TextAlign.center,):
              Text("Select Your Service & \n""Book Service".tr,style:TextStyle(fontSize: 25,color:Theme.of(context).colorScheme.tertiary),textAlign:TextAlign.center,),
            ),
            // SizedBox(height:2.h,),
            // Text("Lorem Ipsum is simply dummy text \n of the printing and typesetting \n industry.".tr,style:TextStyle(fontSize:16,color:Theme.of(context).colorScheme.onTertiary),textAlign:TextAlign.center,),
            SizedBox(height: 5.h,),
            Column(
              children: [
                GestureDetector(onTap: (){
                  Get.toNamed(Routes.loginScreen);
                },child: BorderedButton(width:1, text:"LOGIN".tr)),
                SizedBox(height: 2.h,),
                GestureDetector(onTap:(){
                  Get.toNamed(Routes.signUpScreen);
                },child: BorderedButton(width:1, text:"SIGN UP".tr,isReversed: true)),
              ],
            ),
            //SizedBox(height: 5.h,),
            // Align(
            //   alignment: Alignment.bottomCenter,
            //   child: GestureDetector(
            //     onTap: (){
            //       Get.toNamed(Routes.loginScreen);
            //     },
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: [
            //         Text(
            //           'Skip'.tr,
            //           style: TextStyle(
            //             fontSize: 16,
            //             color: ColorConstants.primaryColor,
            //           ),
            //         ),
            //         SizedBox(width:3.w,),
            //         SvgPicture.asset("assets/images/long_arrow.svg"),
            //       ],
            //     ),
            //   ),
            // ),
            SizedBox(height: 2.h,),
          ],
        ),
      ),
    );
  }

  Widget buildBullets() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        welcomePages.length,
            (index) => buildBullet(index),
      ),
    );
  }

  Widget buildBullet(int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: 2.w,
      height: 2.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _currentPage == index ? ColorConstants.primaryColor :Theme.of(Get.context!).colorScheme.primaryContainer,
      ),
    );
  }
}