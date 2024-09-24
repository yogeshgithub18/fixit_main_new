import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../common/base_overlays.dart';
import '../common/bordered_button.dart';
import '../common/color_constants.dart';
import '../common/utils.dart';
import '../ui_screens/auth/controller/login_controller.dart';
import '../ui_screens/auth/controller/signup_login_controller.dart';
import '../ui_screens/auth/signup.dart';
import 'AppTextFile.dart';
import 'NewHome.dart';
import 'languageExpansionTile.dart';

class NewOtp extends StatefulWidget {
  final String phone;
  final String pageName;
  final String id;
  const NewOtp({Key? key,required this.phone, required this.pageName,required this.id}) : super(key: key);

  @override
  State<NewOtp> createState() => _NewOtpState();
}

class _NewOtpState extends State<NewOtp> {
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
      body: SafeArea(
        child:  SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 60),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     InkWell(
                    onTap: (){
                     Get.back();
                      },
                       child:  Row(
                         crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                           Icon(Icons.arrow_back,color:Theme.of(context).colorScheme.tertiary),
                          Text("Back".tr,
                            style: TextStyle(
                              fontSize: 16,
                              color: Theme.of(context).colorScheme.tertiary,
                              fontFamily: 'Aeonik',
                              fontWeight: FontWeight.w500,
                              decorationColor: ColorConstants.black, // Color of the underline
                            ),),
                        ],),
                     ),
                     SvgPicture.asset('assets/images/fixitlogo.svg'),
                     const SizedBox(width: 50,)
                   ],
                 ),
                 Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 18,),
                     AppTexts.aeonikText13W400(
                      "OTP Verification",
                      fontSize: 30,
                        textColor: Theme.of(context).colorScheme.tertiary,
                      textAlign: TextAlign.center,
                        fontWeight: FontWeight.bold
                    ),

                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child:  AppTexts.aeonikText14W400(
                        "We sent you the OTP code in SMS to your mobile number",
                        maxLines: 2,
                        textColor: Theme.of(context).colorScheme.tertiary,
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.visible,

                      ),
                    )
                  ],
                ),
                const SizedBox(height: 40,),
                Padding(
                  padding: EdgeInsets.only(left:1.sp,right:1.sp),
                  child: PinCodeTextField(
                    controller: otpController,
                    textStyle:  TextStyle(color:Theme.of(Get.context!).colorScheme.tertiary, fontWeight: FontWeight.w500,fontFamily: 'Aeonik',),
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
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(10),
                      fieldOuterPadding: EdgeInsets.all(5.sp),
                      inactiveColor: Theme.of(Get.context!).colorScheme.primaryContainer,
                      fieldWidth: 13.5.w,
                      fieldHeight:7.h,
                      borderWidth: 1,
                      disabledColor: Theme.of(Get.context!).colorScheme.primaryContainer,
                      activeColor:Theme.of(Get.context!).colorScheme.primaryContainer,
                      selectedFillColor: Theme.of(Get.context!).colorScheme.primaryContainer,
                      inactiveFillColor: Theme.of(Get.context!).colorScheme.primaryContainer,
                      selectedColor: Theme.of(Get.context!).colorScheme.primaryContainer,
                      activeFillColor: Theme.of(Get.context!).colorScheme.primaryContainer,
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
                const SizedBox(height: 30,),
                GestureDetector(
                  onTap: () async{
                    //  Get.find<AuthController>().checkOtp(otpController.text, widget.phone, widget.pageName);
                    // return;
                    if (otpController.text.length == 6) {
                       PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: widget.id, smsCode:otpController.text.trim());
                        BaseOverlays().showLoader(showLoader:true);
                        await auth.signInWithCredential(credential).then((result) {
                        BaseOverlays().dismissOverlay(showLoader:true);
                        if(widget.pageName=='login'){
                          Get.find<AuthController>().checkOtp(otpController.text, widget.phone);
                        }else {
                          Get.find<AuthController>().signUp();
                        }
                       // Get.find<AuthController>().checkOtp(otpController.text, widget.phone, widget.pageName);
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
                  }, child: BorderedButton(width:60.0.w,text: "Next".tr,isReversed: true,)
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

