import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fixit/common/color_constants.dart';
import 'package:fixit/ui_screens/auth/controller/signup_login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../common/base_overlays.dart';
import '../../common/bordered_button.dart';
import '../app_header.dart';

class Otp extends StatefulWidget {
  final String phone;
  final String pageName;
  final String id;
  const Otp({Key? key, required this.phone, required this.pageName,required this.id})
      : super(key: key);

  @override
  State<Otp> createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  late TextEditingController otpController;
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
    otpController = TextEditingController();
    init();
  }
  int _counter = 49;
  late Timer _timer;
  bool resendStatus = false;

  @override

  String getFormattedTimer() {
    return _counter.toString().padLeft(2, '0');
  }
  void init() {
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      setState(() {
        _counter--;
        if (_counter <=0) {
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
                "${"Please enter 6-digit verification \n code that was send to your Mobile Number".tr} \"${widget.phone}\"",
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
            // padding: const EdgeInsets.only(
            //     left: 10.0, right: 10, top: 10, bottom: 10),
            padding: EdgeInsets.only(left:10.sp,right: 10.sp),
            child: PinCodeTextField(
              controller: otpController,
              textStyle: const TextStyle(color: ColorConstants.primaryColor),
              length: 6,
              autoFocus: true,
              keyboardType: TextInputType.number,
              obscureText: false,
              cursorColor: Theme.of(Get.context!).colorScheme.error,
              animationType: AnimationType.fade,
              autovalidateMode: otpController.text.length == 6
                  ? AutovalidateMode.always
                  : AutovalidateMode.disabled,
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.circle,
                borderRadius: BorderRadius.circular(20),
                fieldHeight: 6.h,
                fieldOuterPadding: EdgeInsets.all(8.sp),
                inactiveColor: Theme.of(Get.context!).colorScheme.primaryContainer,
                fieldWidth: 14.w,
                borderWidth: 1,
                disabledColor:
                    Theme.of(Get.context!).colorScheme.primaryContainer,
                activeColor: ColorConstants.primaryColor,
                selectedFillColor:
                    Theme.of(Get.context!).colorScheme.onPrimaryContainer,
                inactiveFillColor:
                    Theme.of(Get.context!).colorScheme.primaryContainer,
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
                    PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: widget.id, smsCode:otpController.text.trim());
                    BaseOverlays().showLoader(showLoader:true);
                      await auth.signInWithCredential(credential).then((result) {
                      print("result-->>${result}");
                      BaseOverlays().dismissOverlay(showLoader:true);
                      Get.find<AuthController>().checkOtp(otpController.text, widget.phone);
                    }).catchError((e) {
                      print("[OTPScreen] $e");
                      otpController.clear();
                      BaseOverlays().dismissOverlay(showLoader:true);
                      if (e is FirebaseAuthException) {
                       if (e.code == "invalid-verification-code") {
                          BaseOverlays().showSnackBar(message:"The verification code from SMS/OTP is invalid. Please check and enter the correct verification code again".tr, title: "Error".tr);
                        } else {
                         BaseOverlays().showSnackBar(message:"Something Went Wrong!!!".tr, title: "Error".tr);
                        }
                      } else {
                        BaseOverlays().showSnackBar(message:"Something Went Wrong!!!".tr, title: "Error".tr);
                      }
                    });
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
          _counter != 0 ? Flexible(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                '${"OTP Expire Within".tr}:${getFormattedTimer()}',///todo
                style: TextStyle(
                    fontSize: 18,
                    color: Theme.of(Get.context!).colorScheme.onTertiary),
                textAlign: TextAlign.center,
              ),
            ),
          ) : SizedBox.shrink(),
          Flexible(
            child: Padding(
              padding: EdgeInsets.all(10.sp),
              child: GestureDetector(
                onTap: () {
                  Get.find<AuthController>().verify();
                },
                child: InkWell(
                  onTap: () {
                    if (resendStatus) {
                      resendStatus = false;
                      _counter = 49;
                      init();
                    }
                  },
                  child:  Text(
                    "Resend OTP ?".tr,
                    style: const TextStyle(
                        fontSize: 16.0,
                        color: ColorConstants.primaryColor,
                        fontWeight: FontWeight.w400),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
