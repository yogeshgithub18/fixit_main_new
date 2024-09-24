// ignore: unused_import
import 'package:fixit/ui_screens/service/provider_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../common/bordered_button.dart';
import '../../common/color_constants.dart';
import '../app_header.dart';
import '../profileSubPage/my_bookings.dart';

class SServiceCompleted extends StatefulWidget {
  const SServiceCompleted({super.key});

  @override
  State<SServiceCompleted> createState() => _SServiceCompletedState();
}

class _SServiceCompletedState extends State<SServiceCompleted> {
  double _rating = 4.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(7.h),
          child: AppHeader(
            title: '',
            showBackIcon: true,
            isBackIcon: true,
          )),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SvgPicture.asset("assets/images/completed.svg"),
          Text(
            "Service Completed".tr,
            style: TextStyle(
                fontSize: 25, color: Theme.of(context).colorScheme.tertiary),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 1.h,
          ),
          Text(
            "Lorem Ipsum is simply dummy text \n of the printing and typesetting \n industry.".tr,
            style: TextStyle(
                fontSize: 18,
                color: Theme.of(Get.context!).colorScheme.onTertiary),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 1.h,
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 18.h,
                      width: 91.w,
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(5)),
                      child: Container(
                        padding: EdgeInsets.only(left: 20.sp, top: 15.sp),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Service Detail".tr,
                              style: TextStyle(
                                  color: Theme.of(Get.context!)
                                      .colorScheme
                                      .tertiary,
                                  fontSize: 18),
                            ),
                            SizedBox(height: 1.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SvgPicture.asset(
                                  "assets/images/plumber.svg",
                                  width: 2.w,
                                  height: 2.h,
                                  color: Theme.of(Get.context!)
                                      .colorScheme
                                      .onTertiary,
                                ),
                                SizedBox(width: 5.w),
                                Text(
                                  "Plumber".tr,
                                  style: TextStyle(
                                      color: Theme.of(Get.context!)
                                          .colorScheme
                                          .onTertiary,
                                      fontSize: 16),
                                ),
                              ],
                            ),
                            SizedBox(height: 2.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SvgPicture.asset(
                                  "assets/images/locPin.svg",
                                  color: Theme.of(Get.context!)
                                      .colorScheme
                                      .onTertiary,
                                ),
                                SizedBox(width: 5.w),
                                Text(
                                  "123, location...iraq".tr,
                                  style: TextStyle(
                                      color: Theme.of(Get.context!)
                                          .colorScheme
                                          .onTertiary,
                                      fontSize: 16),
                                ),
                              ],
                            ),
                            // SizedBox(height: 2.h),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.start,
                            //   children: [
                            //     SvgPicture.asset(
                            //       "assets/images/locator.svg",
                            //       color: Theme.of(Get.context!)
                            //           .colorScheme
                            //           .onTertiary,
                            //     ),
                            //     SizedBox(width: 5.w),
                            //     Text(
                            //       "3.5 km",
                            //       style: TextStyle(
                            //           color: Theme.of(Get.context!)
                            //               .colorScheme
                            //               .onTertiary,
                            //           fontSize: 16),
                            //     ),
                            //   ],
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  height: 8.h,
                  decoration: BoxDecoration(
                    color: ColorConstants.buttonBgColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: 15.sp),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          // onTap: ()=>Get.to(ProviderProfile()),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                  height: 12.h,
                                  width: 12.w,
                                  child:
                                      Image.asset("assets/images/profile.png")),
                              SizedBox(
                                width: 2.w,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Mrinal Joe".tr,
                                    style: TextStyle(
                                        color:
                                            ColorConstants.subheadingTextDark,
                                        fontSize: 16),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  " \$ 200.00",
                                  style: TextStyle(
                                      color: ColorConstants.subheadingTextDark,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 4.w,
                                )
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Text(
                "Give Rating".tr,
                style: TextStyle(
                  fontSize: 20,
                  color: Theme.of(Get.context!).colorScheme.tertiary,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 2.h),
              RatingBar.builder(
                initialRating: _rating,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: false,
                itemCount: 5,
                itemSize: 40.0,
                unratedColor: ColorConstants.hintColor,
                itemBuilder: (context, _) => Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Icon(
                    Icons.star_rounded,
                    size: 25,
                    color: ColorConstants.primaryColor,
                  ),
                ),
                onRatingUpdate: (rating) {
                  setState(() {
                    _rating = rating;
                  });
                },
              ),
              SizedBox(height: 3.h),
              Container(
                height: 12.h,
                width: 80.w,
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Write your review here'.tr,
                      hintStyle: TextStyle(
                          color: Theme.of(Get.context!).colorScheme.error),
                      border: InputBorder.none,
                    ),
                    maxLines: 5,
                    onChanged: (value) {
                      // setState(() {
                      //   _comment = value;
                      // });
                    },
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: [
              SizedBox(
                height: 2.h,
              ),
              GestureDetector(
                  onTap: () => Get.back(),
                  child: BorderedButton(
                    width: 1,
                    text: "SUBMIT".tr.toUpperCase(),
                    isReversed: true,
                  )),
              SizedBox(
                height: 2.h,
              ),
              GestureDetector(
                  onTap: () => Get.to(MyBookings()),
                  child: BorderedButton(
                    width: 1,
                    text: "MY BOOKINGS".tr.toUpperCase(),
                  ))
            ],
          )
        ],
      ),
    );
  }
}
