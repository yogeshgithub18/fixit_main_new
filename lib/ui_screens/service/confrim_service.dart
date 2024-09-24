import 'package:fixit/ui_screens/app_header.dart';
import 'package:fixit/ui_screens/service/star_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../common/bordered_button.dart';
import '../../common/color_constants.dart';

class ConfirmService extends StatefulWidget {
  const ConfirmService({
    Key? key,
  }) : super(key: key);

  @override
  State<ConfirmService> createState() => _ConfirmServiceState();
}

class _ConfirmServiceState extends State<ConfirmService> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(7.h),
            child: AppHeader(
              title: "Confirm Service".tr,
              showBackIcon: true,
            )),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 2.h,
              ),
              Stack(children: [
                SizedBox(
                    width: 100.w,
                    height: 65.h,
                    child: Image.asset(
                      "assets/images/long_map.png",
                      fit: BoxFit.fitWidth,
                    )),
                Positioned(
                    top: 20.sp,
                    left: 20.sp,
                    right: 20.sp,
                    child: Center(
                      child: Container(
                          height: 5.h,
                          width: 90.w,
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).colorScheme.primaryContainer,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(left: 20.sp),
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  "assets/images/locPin.svg",
                                  color: Theme.of(Get.context!)
                                      .colorScheme
                                      .onTertiary,
                                ),
                                SizedBox(
                                  width: 1.w,
                                ),
                                Text(
                                  "  123,  location  dum...,  iraq".tr,
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onTertiary),
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Text("Change".tr,
                                    style: TextStyle(
                                        color: ColorConstants.primaryColor))
                              ],
                            ),
                          )),
                    )),
              ]),
              Container(
                height: 8.h,
                decoration: BoxDecoration(
                  color: ColorConstants.buttonBgColor,
                  borderRadius: BorderRadius.circular(1),
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
                                height: 10.h,
                                width: 10.w,
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
                                      color: ColorConstants.subheadingTextDark,
                                      fontSize: 14),
                                ),
                                Text(
                                  "Plumber".tr,
                                  style: TextStyle(
                                      color: ColorConstants.subheadingTextDark,
                                      fontSize: 14),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "\$ 200.00",
                            style: TextStyle(
                                color: ColorConstants.subheadingTextDark,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                          //   children: [
                          //     SvgPicture.asset(
                          //       "assets/images/locator.svg",
                          //       color: ColorConstants.primaryColor,
                          //     ),
                          //     Text(
                          //       " 3.5 km",
                          //       style: TextStyle(
                          //         color: ColorConstants.subheadingTextDark,
                          //         fontSize: 12,
                          //       ),
                          //     ),
                          //     SizedBox(
                          //       width: 4.w,
                          //     )
                          //   ],
                          // ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              GestureDetector(
                  onTap: () => Get.back(),
                  child:
                      BorderedButton(width: 1, text: "Cancel".tr.toUpperCase())),
              SizedBox(
                height: 2.h,
              ),
              GestureDetector(
                  //onTap: () => Get.to(const StartService(id:0)),
                  child: BorderedButton(
                    width: 1,
                    text: "Confirm & Go".tr.toUpperCase(),
                    isReversed: true,
                  ))
            ],
          ),
        ));
  }
}
