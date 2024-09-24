import 'package:fixit/ui_screens/bottomSubPages/change_password.dart';
import 'package:fixit/ui_screens/bottomSubPages/controller/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../NewScreen/NewAppBar.dart';
import '../../common/bordered_button.dart';
import '../../common/color_constants.dart';
import '../../change_language/choose_language.dart';
import '../../storage/base_shared_preference.dart';
import '../../storage/sp_keys.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool _isSwitched = true;
  SettingsController controller = Get.put(SettingsController());
  void initState() {
    // TODO: implement initState
    super.initState();
    getNotif();
  }

  Future<void> getNotif() async {
    Future.delayed(Duration.zero, () async {
      controller.isNotificationSend.value = await BaseSharedPreference().getString(SpKeys().isNotification) == "1";
      print("staus${controller.isNotificationSend.value}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(6.9.h),
          child: NewAppHeader(
            title: "Settings".tr,
            showBackIcon: true,
          )
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
          Padding(
          padding: EdgeInsets.only(top: 30.sp),
          child: Column(
            children: [
              Text(
                "Settings".tr,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.tertiary,
                    fontSize: 25),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 2.h,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(5)),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // GestureDetector(
                        //   onTap: () {
                        //     Get.to(const ChangePassword());
                        //   },
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     children: [
                        //       Row(
                        //         children: [
                        //           Icon(
                        //             Icons.lock,
                        //             color: Theme.of(context)
                        //                 .colorScheme
                        //                 .onTertiary,
                        //           ),
                        //           SizedBox(
                        //             width: 1.w,
                        //           ),
                        //           Text(
                        //             "Change Password".tr,
                        //             style: TextStyle(
                        //                 fontSize: 16,
                        //                 color: Theme.of(context)
                        //                     .colorScheme
                        //                     .onTertiary),
                        //           )
                        //         ],
                        //       ),
                        //       Padding(
                        //         padding: EdgeInsets.only(right: 15.sp),
                        //         child: SvgPicture.asset(
                        //             "assets/images/long_arrow.svg"),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        // Padding(
                        //   padding: EdgeInsets.only(
                        //       left: 12.sp,
                        //       right: 12.sp,
                        //       top: 12.sp,
                        //      // bottom: 6.sp
                        //   ),
                        //   child: Divider(
                        //     height: 1.h,
                        //     color: ColorConstants.divderColor,
                        //   ),
                        // ),
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.notifications,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onTertiary),
                                SizedBox(
                                  width: 1.w,
                                ),
                                Text(
                                  "Notifications".tr,
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onTertiary),
                                )
                              ],
                            ),
                            Obx(() => Switch(
                              activeColor: Colors
                                  .white, // Color when switch is ON
                              activeTrackColor: ColorConstants
                                  .primaryColor, // Track color when switch is ON
                              inactiveThumbColor: Colors
                                  .grey, // Color when switch is OFF
                              inactiveTrackColor: Colors.grey[300],
                              value:
                              controller.isNotificationSend.value,
                              onChanged: (value) {
                                controller.isNotificationSend.value =
                                    value;
                                controller.notificationSetting();
                              },
                            )),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 12.sp,
                              right: 12.sp,
                             // top: 6.sp,
                              bottom: 12.sp),
                          child: Divider(
                            height: 1.h,
                            color: ColorConstants.divderColor,
                          ),
                        ),
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                    'assets/images/language@3x.png',
                                    height: 25,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onTertiary),
                                SizedBox(
                                  width: 1.w,
                                ),
                                Text(
                                  "Change Language".tr,
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onTertiary),
                                ),
                              ],
                            ),
                            InkWell(
                              onTap: () {
                                Get.to( const ChooseLanguage(pageName: 'setting',));
                              },
                              child: Padding(
                                padding: EdgeInsets.only(right: 15.sp),
                                child: SvgPicture.asset(
                                    "assets/images/long_arrow.svg"),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 12.sp,
                              right: 12.sp,
                              top: 12.sp,
                              bottom: 12.sp),
                          child: Divider(
                            height: 1.h,
                            color: ColorConstants.divderColor,
                          ),
                        ),
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.shield,
                                  color: Theme.of(context).colorScheme.onTertiary,
                                ),
                                // Image.asset(
                                //     'assets/images/language@3x.png',
                                //     height: 25,
                                //     color: Theme.of(context)
                                //         .colorScheme
                                //         .onTertiary),
                                SizedBox(
                                  width: 1.w,
                                ),
                                Text(
                                  "Delete Account".tr,
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onTertiary),
                                ),
                              ],
                            ),
                            InkWell(
                              onTap: () {
                               Get.dialog(AlertDialog(
                                 shape: RoundedRectangleBorder(
                                     borderRadius: BorderRadius.circular(10)),
                                 title:Center(
                                     child: Text('Delete Account'.tr)),
                                 content:  Column(
                                   mainAxisSize: MainAxisSize.min,
                                   children: [
                                     Text("Are you sure you want to delete your account?".tr,style: const TextStyle(fontSize: 16,),textAlign:TextAlign.center,),
                                     SizedBox(height: 5,),
                                     Text("This action will erase all your data from our record.".tr,style: const TextStyle(fontSize: 12),),
                                   ],
                                 ),
                                 actions: [
                                   Row(
                                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                     children: [
                                       Center(
                                         child: TextButton(
                                           style: const ButtonStyle(
                                             backgroundColor:
                                             MaterialStatePropertyAll(
                                                 Colors.black),
                                             elevation:
                                             MaterialStatePropertyAll(1),
                                           ),
                                           onPressed: () {
                                             Get.back();
                                           },
                                           child:  Text(
                                             'Cancel'.tr,
                                             style: TextStyle(color: Colors.white),
                                           ),
                                         ),
                                       ),Center(
                                         child: TextButton(
                                           style: const ButtonStyle(
                                             backgroundColor:
                                             MaterialStatePropertyAll(
                                                 Colors.deepOrange),
                                             elevation:
                                             MaterialStatePropertyAll(1),
                                           ),
                                           onPressed: () async{
                                             Get.back();
                                             final Uri url = Uri.parse('https://fixitservice.co/delete-my-account');
                                             if (!await launchUrl(url)) {
                                             throw Exception('Could not launch $url');
                                             }
                                           },
                                           child:  Text(
                                             'Proceed'.tr,
                                             style: TextStyle(color: Colors.white),
                                           ),
                                         ),
                                       ),
                                     ],
                                   ),
                                 ],
                               ));
                              },
                              child: Padding(
                                padding: EdgeInsets.only(right: 15.sp),
                                child: SvgPicture.asset(
                                    "assets/images/long_arrow.svg"),
                              ),
                            ),
                          ],
                        ),

                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 5.h),
          child: Column(
            children: [
              Text(
                "${"App version".tr} 1.0",
                style: TextStyle(
                    color: Theme.of(context).colorScheme.tertiary,
                    fontSize: 14),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 2.h,
              ),
              GestureDetector(
                  onTap: () {
                    // BaseSharedPreference().clearAllSharedPreference();
                    controller.logout();
                  },
                  child: BorderedButton(
                    width: 1,
                    text: "LOGOUT".tr,
                    isReversed: true,
                  )),
            ],
          ),
        )
      ]),
    );
  }
}
