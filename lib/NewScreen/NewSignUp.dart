import 'package:fixit/ui_screens/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../common/base_overlays.dart';
import '../common/bordered_button.dart';
import '../common/color_constants.dart';
import '../common/utils.dart';
import '../ui_screens/auth/controller/login_controller.dart';
import '../ui_screens/auth/controller/signup_login_controller.dart';
import 'AppTextFile.dart';
import 'NewOtpVery.dart';

class NewSignup extends StatefulWidget {
  const NewSignup({super.key});

  @override
  State<NewSignup> createState() => _NewSignupState();
}

class _NewSignupState extends State<NewSignup> {
  AuthController controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              const SizedBox(height: 50,),
              Column(
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
                            Icon(Icons.arrow_back,color: Theme.of(context).colorScheme.tertiary,),
                            Text("Back".tr,
                              style: TextStyle(
                                fontSize: 16,
                                color: Theme.of(context).colorScheme.tertiary,
                                fontFamily: 'Aeonik',
                                fontWeight: FontWeight.w500,
                                decorationColor: ColorConstants.black, // Color of the underline
                              ),
                            ),
                          ],),
                      ),
                      SvgPicture.asset('assets/images/fixitlogo.svg'),
                      const SizedBox(width: 50,)
                    ],
                  ),
                  const SizedBox(
                    height:20,
                  ),
                   AppTexts.aeonikText16W500(
                    "Sign Up",
                    fontSize: 38,
                      textColor: Theme.of(context).colorScheme.tertiary,
                      fontWeight: FontWeight.bold,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 0,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Text(

                      "Full the following information and setup your Accounts password to get you started".tr,
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.tertiary,
                        fontFamily: 'Aeonik',
                      ),
                      maxLines: 2,
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.visible,
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Container(
                      decoration: BoxDecoration(
                          color: const Color(0xffDDDDDD),
                          borderRadius: BorderRadius.circular(12.8)
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left:10.sp,right: 20.sp),
                        child: addEditText2(controller.fullName.value,"Full Name".tr,
                          iconPath: 'assets/images/fullNamePrifix.svg',
                        ),
                      )
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Container(
                    //  margin: EdgeInsets.symmetric(horizontal:5,vertical:5),
                      decoration: BoxDecoration(
                          color: const Color(0xffDDDDDD),
                          borderRadius: BorderRadius.circular(12.8)
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left:10.sp,right: 20.sp),
                        child: addEditText2(controller.email.value,"Email Address".tr,
                          iconPath: 'assets/images/emailPrifix.svg',
                        ),
                      )),
                  SizedBox(
                    height: 2.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(
                            left: 20, top: 19, right: 10, bottom: 19),
                        decoration: BoxDecoration(
                            color: ColorConstants.fixitText,
                            borderRadius: getBorderRadius13()
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                                width: 26,
                                height: 15,
                                child: SvgPicture.asset(
                                  'assets/images/ar.svg',
                                  fit: BoxFit.fill,
                                )),
                            const SizedBox(
                              width: 5,
                            ),


                        const AppTexts.aeonikText16W500(
                          "+964 ",
                        ),
                            const Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: ColorConstants.black,
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                                color:ColorConstants.fixitText,
                                borderRadius: getBorderRadius13()),
                            child: Padding(
                              padding: EdgeInsets.all(11.sp),
                              child: TextFormField(
                                cursorColor: ColorConstants.primaryColor,
                                keyboardType: TextInputType.phone,
                                controller: controller.mobileNo.value,
                                textInputAction: TextInputAction.next,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(10),
                                ],
                                style: TextStyle(
                                  fontSize: getNormalTextFontSIze() + 1,
                                  color: ColorConstants.black,
                                ),
                                decoration: InputDecoration(
                                    hintText: "Mobile Number".tr,
                                    hintStyle: hintStyleTextField(),
                                    border: InputBorder.none),
                              ),
                            )),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                      onTap: () {
                         if (controller.fullName.value.text.trim().isEmpty) {
                           BaseOverlays().showSnackBar(message: "Full Name is Required".tr, title: "Error");
                           return;
                        }
                       else if (controller.mobileNo.value.text.trim().isEmpty) {
                          BaseOverlays().showSnackBar(message: "Please enter mobile no".tr, title: "Error");
                          return;
                        } else if (controller.email.value.text.trim().isEmpty) {
                          BaseOverlays().showSnackBar(message: "Please enter email".tr, title: "Error");
                          return;
                        }  else {
                          controller.verify();
                        }
                      },
                      child: BorderedButton(
                        width: 60.0.w,
                        text: "Next".tr,
                        isReversed: true,
                      )),
                ],
              ),
              const Spacer(),
              InkWell(
                onTap: (){
                  Get.offAll(()=>const LoginScreen());
                },
                child: RichText(
                  text:  TextSpan(
                    text: "If you already have an account,".tr,
                    style:TextStyle(
                        color: Theme.of(context).colorScheme.tertiary,
                        fontFamily: 'Aeonik',
                        fontSize: 16
                    ),
                    children:  [
                      TextSpan(
                          text: "Login Here".tr,
                        style: const TextStyle(
                          fontSize: 16,
                          color: ColorConstants.primaryColor,
                          fontFamily: 'Aeonik',
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}






