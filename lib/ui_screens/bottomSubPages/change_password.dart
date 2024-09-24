import 'package:fixit/ui_screens/app_header.dart';
import 'package:fixit/ui_screens/bottomSubPages/controller/change_password_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../common/bordered_button.dart';
import '../../common/color_constants.dart';
import '../../common/utils.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  ChangePasswordController controller =Get.put(ChangePasswordController());
  bool isShow=true;
  bool isShow1=true;
  bool isShow2=true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(7.h),
          child: const AppHeader(title: '',showBackIcon: true,)),
      body:Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Change Password".tr,
                  style: TextStyle(fontSize: 25, color: Theme.of(Get.context!).colorScheme.tertiary,),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 1.h,
                ),
                Text(
                  "Please enter your old and new password.".tr,
                  style:
                  TextStyle(fontSize: 18, color: Theme.of(Get.context!).colorScheme.onTertiary),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 3.h,
                ),
                Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left:20.sp,right: 20.sp),
                      child: TextFormField(
                        cursorColor: ColorConstants.primaryColor,
                        keyboardType: TextInputType.multiline,
                        controller: controller.oldPassword,
                        textInputAction: TextInputAction.next,
                        obscureText: isShow,
                        obscuringCharacter: "*",
                        style: TextStyle(fontSize: getNormalTextFontSIze(),color:Theme.of(Get.context!).colorScheme.onTertiary),
                        decoration: InputDecoration(
                            hintText: "Old Password".tr,
                            suffixIcon: GestureDetector(
                                onTap: (){
                                  setState(() {
                                    isShow=!isShow;
                                  });

                                },
                                child:Icon(isShow?Icons.visibility_off:Icons.visibility,color:Theme.of(Get.context!).colorScheme.error)),
                            hintStyle: TextStyle(
                                color: Theme.of(Get.context!).colorScheme.error,
                                fontSize: getNormalTextFontSIze()
                            ),
                            border: InputBorder.none),
                      ),
                    )),
                SizedBox(
                  height: 2.h,
                ),
                Container(
                  //  margin: EdgeInsets.symmetric(horizontal:5),
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left:20.sp,right: 20.sp),
                      child: TextFormField(
                        cursorColor: ColorConstants.primaryColor,
                        keyboardType: TextInputType.multiline,
                        controller: controller.newPassword,
                        obscureText: isShow1,
                        obscuringCharacter: "*",
                        textInputAction: TextInputAction.next,
                        style: TextStyle(fontSize: getNormalTextFontSIze(),color:Theme.of(Get.context!).colorScheme.onTertiary),
                        decoration: InputDecoration(
                            hintText: "New Password".tr,
                            suffixIcon: GestureDetector(
                                onTap: (){
                                  setState(() {
                                    isShow1=!isShow1;
                                  });

                                },
                                child:Icon(isShow1?Icons.visibility_off:Icons.visibility,color: Theme.of(Get.context!).colorScheme.error)),
                            hintStyle: TextStyle(
                                color: Theme.of(Get.context!).colorScheme.error,
                                fontSize: getNormalTextFontSIze()
                            ),
                            border: InputBorder.none),
                      ),
                    )),
                SizedBox(
                  height: 2.h,
                ),
                Container(
                  //  margin: EdgeInsets.symmetric(horizontal:5),
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left:20.sp,right: 20.sp),
                      child: TextFormField(
                        cursorColor: ColorConstants.primaryColor,
                        keyboardType: TextInputType.multiline,
                        controller: controller.confirmPassword,
                        textInputAction: TextInputAction.next,
                        obscureText: isShow2,
                        obscuringCharacter: "*",
                        style: TextStyle(fontSize: getNormalTextFontSIze(),color:Theme.of(Get.context!).colorScheme.onTertiary),
                        decoration: InputDecoration(
                            hintText: "Confirm Password".tr,
                            suffixIcon: GestureDetector(
                                onTap: (){
                                  setState(() {
                                    isShow2=!isShow2;
                                  });

                                },
                                child:Icon(isShow2?Icons.visibility_off:Icons.visibility,color: Theme.of(Get.context!).colorScheme.error)),
                            hintStyle: TextStyle(
                                color: Theme.of(Get.context!).colorScheme.error,
                                fontSize: getNormalTextFontSIze()
                            ),
                            border: InputBorder.none),
                      ),
                    )),
                SizedBox(
                  height: 2.h,
                ),
              ],
            ),
          ),
          const Spacer(),
          GestureDetector(onTap:(){
           controller.changePassword();
          },child: BorderedButton(width:1, text: "SAVE".tr,isReversed: true,)),
          SizedBox(
            height: 2.h,
          ),
        ],
      ) ,
    );
  }

}
