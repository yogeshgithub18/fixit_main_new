import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../common/bordered_button.dart';
import '../../common/color_constants.dart';
import '../../common/utils.dart';
import '../app_header.dart';
import '../bottomSubPages/controller/change_password_controller.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  ChangePasswordController controller =Get.put(ChangePasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(7.h),
          child:  const AppHeader(title: '',showBackIcon: true,)),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Text(
                "Forgot password".tr,
                style: TextStyle(fontSize: 25, color: Theme.of(Get.context!).colorScheme.tertiary,),
                textAlign: TextAlign.center,
              ),
            ),
           SizedBox(
             height: 2.h,
           ),
           Center(
             child: Text(
                "Please enter email address for reset your password".tr,
                style: TextStyle(fontSize: 16, color: Theme.of(Get.context!).colorScheme.tertiary,),
                textAlign: TextAlign.center,
              ),
           ),
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
                    controller: controller.email,
                    textInputAction: TextInputAction.next,
                    obscuringCharacter: "*",
                    style: TextStyle(fontSize: getNormalTextFontSIze(),color:Theme.of(Get.context!).colorScheme.onTertiary),
                    decoration: InputDecoration(
                        hintText: "Email Address".tr,
                        hintStyle: TextStyle(
                            color: Theme.of(Get.context!).colorScheme.error,
                            fontSize: getNormalTextFontSIze()
                        ),
                        border: InputBorder.none),
                  ),
                )),
            SizedBox(
              height: 3.h,
            ),
            GestureDetector(onTap:(){
              controller.forgetPasswordScreen(false);
            },child: BorderedButton(width:1, text: "Send".tr,isReversed: true,)),

          ],
        ),
      ),
    );
  }
}
