import 'package:fixit/common/color_constants.dart';
import 'package:fixit/ui_screens/bottomSubPages/controller/profile_controller.dart';
import 'package:fixit/ui_screens/bottomSubPages/edit_profile.dart';
import 'package:fixit/ui_screens/bottomSubPages/settings.dart';
import 'package:fixit/ui_screens/locations/manage_address.dart';
import 'package:fixit/ui_screens/profileSubPage/aboutUs.dart';
import 'package:fixit/ui_screens/profileSubPage/my_bookings.dart';
import 'package:fixit/ui_screens/profileSubPage/privacy_policy.dart';
import 'package:fixit/ui_screens/profileSubPage/termCondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../NewScreen/NewAppBar.dart';
import '../../common/base_image_network.dart';
import '../../common/bordered_button.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({
    Key? key,
  }) : super(key: key);

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  ProfileController controller = Get.find<ProfileController>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(7.h),
            child:  NewAppHeader(
              title: "My Profile".tr,
              showBackIcon: true,
            )),
        body: Padding(
          padding: EdgeInsets.only(top: 30.sp),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Obx(() => Column(
                children: [
                  Container(
                    height: 16.h,
                    width: 33.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(150.0),
                    ),
                    child: BaseImageNetwork(
                      fit: BoxFit.cover,
                      borderRadius: 150,
                      link: controller.data.value.image ?? "",
                      concatBaseUrl: false,
                      errorWidget: Image.asset(
                        "assets/images/profile.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Text(
                    controller.data.value.name ?? '', style: TextStyle(fontSize: 20,
                      color: Theme.of(context).colorScheme.tertiary),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Text(controller.data.value.email ?? '', style: TextStyle(fontSize: 16,
                      color: Theme.of(Get.context!).colorScheme.onTertiary),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Text(
                    controller.data.value.phone ?? '',
                    style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(Get.context!).colorScheme.onTertiary),
                    textAlign: TextAlign.center,
                  ),
                ],
              )),
              SizedBox(
                height: 2.h,
              ),
              GestureDetector(
                  onTap: () {
                    Get.to(const EditProfile())?.then((value) {
                      controller.getProfile();
                    });
                  },
                  child: BorderedButton(
                    width: 1,
                    text: "Edit Profile".tr.toUpperCase(),
                    isReversed: true,
                  )),
              SizedBox(
                height: 3.h,
              ),
              // GestureDetector(
              //     onTap: () {
              //       Get.to(const MyBookings());
              //     },
              //     child: BorderedButton(
              //       width: 1,
              //       text: "My Bookings".tr.toUpperCase(),
              //     )),
              // SizedBox(
              //   height: 3.h,
              // ),
              Container(
                height:32.h,
                width: 88.w,
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(5)),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.to(const ManageAddress(page: "profile",));
                        },
                        child: Padding(
                          padding:
                          EdgeInsets.only(left: 12.sp, right: 12.sp, top: 8.sp),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.location_pin,
                                      color:
                                      Theme.of(context).colorScheme.onTertiary),
                                  SizedBox(
                                    width: 1.w,
                                  ),
                                  Text(
                                    "Manage Address".tr,
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onTertiary),
                                  )
                                ],
                              ),
                              SvgPicture.asset("assets/images/long_arrow.svg"),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 12.sp, right: 12.sp, top: 12.sp, bottom: 12.sp),
                        child: Divider(
                          height: 1.h,
                          color: ColorConstants.divderColor,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Get.to(const Settings()),
                        child: Padding(
                          padding: EdgeInsets.only(left: 12.sp, right: 12.sp),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.settings,
                                    color: Theme.of(context).colorScheme.onTertiary,
                                  ),
                                  SizedBox(
                                    width: 1.w,
                                  ),
                                  Text(
                                    "Settings".tr,
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onTertiary),
                                  )
                                ],
                              ),
                              SvgPicture.asset("assets/images/long_arrow.svg"),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 12.sp, right: 12.sp, top: 12.sp, bottom: 12.sp),
                        child: Divider(
                          height: 1.h,
                          color: ColorConstants.divderColor,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Get.to(const PrivacyPolicy()),
                        child: Padding(
                          padding: EdgeInsets.only(left: 12.sp, right: 12.sp),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.shield,
                                    color: Theme.of(context).colorScheme.onTertiary,
                                  ),
                                  SizedBox(
                                    width: 1.w,
                                  ),
                                  Text(
                                    "Privacy Policy".tr,
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onTertiary),
                                  )
                                ],
                              ),
                              SvgPicture.asset("assets/images/long_arrow.svg"),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 12.sp, right: 12.sp, top: 12.sp, bottom: 12.sp),
                        child: Divider(
                          height: 1.h,
                          color: ColorConstants.divderColor,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Get.to(const TermsConditions()),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                // mainAxisAlignment:MainAxisAlignment.spaceAround,
                                children: [
                                  Icon(
                                    Icons.file_copy,
                                    color: Theme.of(context).colorScheme.onTertiary,
                                  ),
                                  SizedBox(
                                    width: 1.w,
                                  ),
                                  Text(
                                    "Term & Conditions".tr,
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onTertiary),
                                  )
                                ],
                              ),
                              SvgPicture.asset("assets/images/long_arrow.svg"),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 12.sp, right: 12.sp, top: 12.sp, bottom: 12.sp),
                        child: Divider(
                          height: 1.h,
                          color: ColorConstants.divderColor,
                        ),
                      ),
                      GestureDetector(
                        //  onTap: () => Get.to(const LanguageChangeScreen()),
                        onTap: () => Get.to(const AboutUs()),
                        child: Padding(
                          padding: EdgeInsets.only(left: 12.sp, right: 12.sp),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                // mainAxisAlignment:MainAxisAlignment.spaceAround,
                                children: [
                                  Icon(Icons.warning_rounded,
                                      color:
                                      Theme.of(context).colorScheme.onTertiary),
                                  SizedBox(
                                    width: 1.w,
                                  ),
                                  Text(
                                    "About Us".tr,
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onTertiary),
                                  )
                                ],
                              ),
                              SvgPicture.asset("assets/images/long_arrow.svg"),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
