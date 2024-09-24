import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../common/base_overlays.dart';
import '../../common/bordered_button.dart';
import '../../common/color_constants.dart';
import '../app_header.dart';
import 'controller/signup_login_controller.dart';

class EmailOtpScreen extends StatefulWidget {
  String email;
   EmailOtpScreen({super.key,required this. email});

  @override
  State<EmailOtpScreen> createState() => _EmailOtpScreenState();
}

class _EmailOtpScreenState extends State<EmailOtpScreen> {
   TextEditingController otpController=TextEditingController();
  void initState() {
    super.initState();

    init();
  }
  int _counter = 0;
  late Timer _timer;
  bool resendStatus = false;

  @override

  String getFormattedTimer() {
    return _counter.toString().padLeft(2, '0');
  }
  void init() {
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      setState(() {
        _counter++;
        if (_counter >=49) {
          _timer.cancel();
          resendStatus = true;
        }
      });
    });
  }
  @override
  Widget build(BuildContext context) {
      return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(7.h),
          child: const AppHeader(
            title: "",
            showBackIcon: true,
          )),
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Text(
            "OTP".tr,
            style: TextStyle(
              fontSize: 25,
              color: Theme.of(Get.context!).colorScheme.tertiary,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 1.h,
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "Please enter 6-digit verification \n code that was send to your Email".tr,
                style: TextStyle(
                    fontSize: 18,
                    color: Theme.of(Get.context!).colorScheme.onTertiary),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(
            height: 3.h,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10, top: 10, bottom: 10),
            child: PinCodeTextField(
               controller: otpController,
              textStyle: const TextStyle(color: ColorConstants.primaryColor),
              length: 6,
              autoFocus: true,
              keyboardType: TextInputType.number,
              obscureText: false,
              cursorColor: Theme.of(Get.context!).colorScheme.error,
              animationType: AnimationType.fade,
              autovalidateMode: otpController.text.length == 6 ? AutovalidateMode.always : AutovalidateMode.disabled,
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.circle,
                borderRadius: BorderRadius.circular(20),
                fieldHeight: 7.h,
                inactiveColor:
                Theme.of(Get.context!).colorScheme.primaryContainer,
                fieldWidth: 7.h,
                borderWidth: 1,
                disabledColor:
                Theme.of(Get.context!).colorScheme.primaryContainer, activeColor: ColorConstants.primaryColor,
                selectedFillColor: Theme.of(Get.context!).colorScheme.onPrimaryContainer,
                inactiveFillColor: Theme.of(Get.context!).colorScheme.primaryContainer,
                selectedColor: ColorConstants.primaryColor,
                activeFillColor:
                Theme.of(Get.context!).colorScheme.onPrimaryContainer,
                errorBorderColor: Colors.red,
              ),
              animationDuration: const Duration(milliseconds: 300),
              enableActiveFill: true,
              onCompleted: (v) {
                debugPrint("Completed");
              },
              validator: (otp) {
                return null;
              },
              onChanged: (value) {
                debugPrint(value);
              },
              beforeTextPaste: (text) {
                return true;
              },
              appContext: context,
            ),
          ),
          SizedBox(
            height: 3.h,
          ),
          GestureDetector(
              onTap: () async{
                if (otpController.text.length == 6) {
                  Get.find<AuthController>().checkOtp(otpController.text,widget.email);
                  otpController.clear();
                } else {
                  BaseOverlays().showSnackBar(
                      message: "Enter 6 Digit OTP".tr, title: "Error".tr);
                }
                // Get.toNamed(Routes.setLocation);
              },
              child: BorderedButton(
                width: 60.0.w,
                text: "SUBMIT".tr,
                isReversed: true,
              )),
          SizedBox(
            height: 3.h,
          ),
          // Flexible(
          //   child: Padding(
          //     padding: const EdgeInsets.all(10.0),
          //     child: Text(
          //       'OTP Expire Within:${getFormattedTimer()}',///todo
          //       style: TextStyle(
          //           fontSize: 18,
          //           color: Theme.of(Get.context!).colorScheme.onTertiary),
          //       textAlign: TextAlign.center,
          //     ),
          //   ),
          // ),
          // Flexible(
          //   child: Padding(
          //     padding: EdgeInsets.all(10.sp),
          //     child: GestureDetector(
          //       onTap: () {
          //          Get.find<ChangePasswordController>().forgetPasswordScreen(true);
          //       },
          //       child: InkWell(
          //         onTap: () {
          //           // if (resendStatus) {
          //           //   resendStatus = false;
          //           //   _counter = 0;
          //           //   init();
          //           // }
          //         },
          //         child:  Text(
          //           "Resend OTP ?".tr,
          //           style: const TextStyle(
          //               fontSize: 16.0,
          //               color: ColorConstants.primaryColor,
          //               fontWeight: FontWeight.w400),
          //           textAlign: TextAlign.center,
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
