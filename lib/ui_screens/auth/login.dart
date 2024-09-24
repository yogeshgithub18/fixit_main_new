import 'dart:io';

import 'package:fixit/NewScreen/NewOtpVery.dart';
import 'package:fixit/common/base_overlays.dart';
import 'package:fixit/common/bordered_button.dart';
import 'package:fixit/common/color_constants.dart';
import 'package:fixit/common/utils.dart';
import 'package:fixit/ui_screens/auth/controller/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../NewScreen/AppTextFile.dart';
import '../../NewScreen/NewPassWordScreen.dart';
import '../../NewScreen/NewSignUp.dart';
import '../../NewScreen/languageExpansionTile.dart';
import 'Forgetpassword_screen.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginController controller = Get.put(LoginController());
  bool isShow = true;
  bool isChecked = false;
  bool obscureText = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.matchStatus.value = controller.languageSelectName[0].name;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child:  Container(
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
          child: Column(
            children: [
              const SizedBox(height: 50,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset('assets/images/fixitlogo.svg'),
                      const SizedBox(height: 18,),
                       AppTexts.aeonikText16W500(
                        "Welcome!".tr,
                        fontSize: 38,
                          textColor: Theme.of(context).colorScheme.tertiary,
                        textAlign: TextAlign.center,
                          fontWeight: FontWeight.bold

                      ),
                       AppTexts.aeonikText16W500(
                        "Log in to Fixit".tr,
                        fontSize: 25,
                        textColor: Theme.of(context).colorScheme.tertiary,
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                  LanguageExpansionTile(
                    items: List.generate(3, (index) => controller.languageSelectName[index]),
                    items2: List.generate(3, (index) => controller.languageSelect[index]),
                  )
                ],
              ),
              const SizedBox(height:30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.only(left:20,top: 25,right: 10,bottom: 19),
                    decoration: BoxDecoration(
                        color: ColorConstants.fixitText,
                        borderRadius: getBorderRadius13()
                    ),
                    child:  Row(
                      children: [
                        SizedBox(
                            width: 26,
                            height: 15,
                            child: SvgPicture.asset('assets/images/ar.svg',fit: BoxFit.fill,)),
                        const SizedBox(width: 5,),
                        const AppTexts.aeonikText16W500(
                        "+964"
                        ),
                        const Icon(Icons.keyboard_arrow_down_rounded,color: ColorConstants.black,)
                      ],
                    ),
                  ),
                  const SizedBox(width: 10,),
                  Expanded(
                    child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                            color:  ColorConstants.fixitText,
                            borderRadius: getBorderRadius13()),
                        child: Padding(
                          padding: EdgeInsets.all( 11.sp),
                          child: TextFormField(
                            cursorColor: ColorConstants.primaryColor,
                            keyboardType: TextInputType.phone,
                            controller: controller.mobileNo,
                            textInputAction: TextInputAction.next,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(10),
                            ],
                            style: TextStyle(
                              fontSize: getNormalTextFontSIze() + 1,
                              color: ColorConstants.black,),
                            decoration: InputDecoration(
                                hintText: "Mobile Number".tr,
                                hintStyle: hintStyleTextField(),
                                border: InputBorder.none),
                          ),
                        )),
                  ),
                ],
              ),
              // Container(
              //   padding: const EdgeInsets.symmetric(horizontal: 5),
              //   margin: const EdgeInsets.symmetric(vertical: 10),
              //   decoration: BoxDecoration(
              //     color: const Color(0xffDDDDDD),
              //     borderRadius: BorderRadius.circular(12.8),
              //   ),
              //   child: Padding(
              //     padding: EdgeInsets.only(top:11.sp,bottom:11.sp),
              //     child: TextFormField(
              //       cursorColor: ColorConstants.primaryColor,
              //       controller: controller.loginPassword,
              //       textInputAction: TextInputAction.next,
              //       obscureText: obscureText,
              //       inputFormatters: [
              //         LengthLimitingTextInputFormatter(10), // Set your desired max length
              //       ],
              //       style: TextStyle(
              //         fontSize: getNormalTextFontSIze() + 1,
              //         color: ColorConstants.black,
              //       ),
              //       decoration: InputDecoration(
              //         hintText: "Otp".tr,
              //         prefixIcon: Padding(
              //           padding: EdgeInsets.only(bottom: 15.sp),
              //           child: Icon(Icons.keyboard_alt_outlined, color: ColorConstants.black),
              //         ),
              //         // suffixIcon: IconButton(
              //         //   icon: Icon(
              //         //     obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
              //         //     color: ColorConstants.black,
              //         //   ),
              //         //   onPressed: () {
              //         //     setState(() {
              //         //       obscureText = !obscureText;
              //         //     });
              //         //   },
              //         // ),
              //         hintStyle: TextStyle(
              //           color: ColorConstants.black,
              //           fontFamily: 'Aeonik',
              //           fontSize: getNormalTextFontSIze(),
              //         ),
              //         border: InputBorder.none,
              //       ),
              //     ),
              //   ),
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Row(
              //       children: [
              //         Theme(
              //           data: ThemeData(
              //             checkboxTheme: CheckboxThemeData(
              //               shape: RoundedRectangleBorder(
              //                 borderRadius: BorderRadius.circular(5),
              //               ),
              //             ),
              //           ),
              //           child: Checkbox(
              //             checkColor: ColorConstants.headerTextDark,
              //             activeColor: ColorConstants.primaryColor,
              //             value: isChecked,
              //             onChanged: (bool? value) {
              //               setState(() {
              //                 isChecked = value!;
              //               });
              //             },
              //           ),
              //         ),
              //         const Text("Remember Me ",style: TextStyle(
              //           fontSize: 13,
              //           color: Color(0xff464C6C),
              //           fontFamily: 'Gotham',
              //         ),),
              //       ],
              //     ),
              //     GestureDetector(
              //       onTap: ()=>Get.to(()=>const NewPasswordScreen()),
              //       child: const Text("Forgot Password?",style: TextStyle(
              //         fontSize: 13,
              //         color: ColorConstants.black,
              //         fontFamily: 'Gotham',
              //         decoration: TextDecoration.underline,
              //         decorationColor: ColorConstants.black, // Color of the underline
              //         decorationThickness: 1.5,
              //       ),),
              //     ),
              //   ],
              // ),
              const SizedBox(height: 40,),
              GestureDetector(onTap:(){
                if(controller.mobileNo.text.trim().isNotEmpty){
                  controller.verifyByMobile();
                 // Get.to(()=>NewOtp(phone:"8963805146", id:"grgret",pageName: "login",));
                }else{
                  BaseOverlays().showSnackBar(message:"Please enter mobile no".tr,title: "Error");
                }
              },
                  child: BorderedButton(width:60.0.w,text: "Continue".tr,isReversed: true,)
              ),
              const SizedBox(height: 56,),
              GestureDetector(
                onTap: (){
                  Get.to(const NewSignup());
                },
                child:
                Text("Create new account".tr,
                  style: const TextStyle(
                  fontSize: 16,
                  color: ColorConstants.primaryColor,
                  fontFamily: 'Aeonik',
                    fontWeight: FontWeight.w500,
                  decoration: TextDecoration.underline,
                  decorationColor: ColorConstants.primaryColor, // Color of the underline
                  decorationThickness: 1.5,
                ),),
              ),
              const SizedBox(height: 46,),
              Row(
                mainAxisAlignment:Platform.isIOS?MainAxisAlignment.spaceEvenly:MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: (){
                      controller.googleLogin();
                    },
                    child: Image.asset('assets/images/google_logo.png',width:40,height:40),
                  ),
                  if(Platform.isIOS)
                  GestureDetector(
                    onTap: (){
                      controller.appleLogin();
                    },
                    child: Image.asset('assets/images/apple.png',width:40,height:40),
                  ),
                ],
              ),
              const Spacer(),
               Text("Fixit uses cookies for analytics, personalized content and ads. By using Fixit services, you agree to this use of cookies".tr,
              style: TextStyle(
                fontSize: 12,
                color: Theme.of(context).colorScheme.tertiary,
                fontFamily: 'Aeonik',
                fontWeight: FontWeight.w400,
                decorationColor: ColorConstants.black, // Color of the underline
              ),)
            ],
          ),
        ),
      ),
    );
  }
}

class MobileLoginForm extends StatelessWidget {
  LoginController controller = Get.find<LoginController>();

  MobileLoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.sp),
      child: Column(
        children: [
          // Container(
          //     margin: EdgeInsets.symmetric(horizontal:5.sp,vertical:5.sp),
          //     decoration: BoxDecoration(
          //         color:Theme.of(Get.context!).colorScheme.primaryContainer,
          //     borderRadius: BorderRadius.circular(10)
          //     ),
          //     child: Padding(
          //       padding: EdgeInsets.only(left:20.sp,right: 20.sp),
          //       child: addEditText2(controller.mobileNo,"Mobile Number".tr,inputType: TextInputType.number),
          //     )),
          Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: EdgeInsets.only(left: 20.sp, right: 20.sp),
                child: TextFormField(
                  cursorColor: ColorConstants.primaryColor,
                  keyboardType: TextInputType.phone,
                  controller: controller.mobileNo,
                  textInputAction: TextInputAction.next,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(10),
                    // Set your desired max length
                  ],
                  style: TextStyle(
                      fontSize: getNormalTextFontSIze() + 1,
                      color: Theme.of(Get.context!).colorScheme.onTertiary),
                  decoration: InputDecoration(
                      hintText: "Mobile Number".tr,
                      // prefixIcon:Padding(
                      //   padding: EdgeInsets.only(top: 15.sp),
                      //   child:  Text("+964 ",style: TextStyle(color:Theme.of(Get.context!).colorScheme.onTertiary,fontSize: 16),),
                      // ) ,
                      hintStyle: TextStyle(
                          color: Theme.of(Get.context!).colorScheme.error,
                          fontSize: getNormalTextFontSIze()),
                      border: InputBorder.none),
                ),
              )),
          SizedBox(height: 5.h),
          GestureDetector(
              onTap: () {
                if (controller.mobileNo.text.trim().isNotEmpty) {
                  controller.verifyByMobile();
                } else {
                  BaseOverlays().showSnackBar(
                      message: "Please enter mobile no".tr, title: "Error");
                }
              },
              child: BorderedButton(
                width: 60.0.w,
                text: "LOGIN".tr,
                isReversed: true,
              ))
        ],
      ),
    );
  }
}
class EmailLoginForm extends StatefulWidget {
  @override
  State<EmailLoginForm> createState() => _EmailLoginFormState();
}

class _EmailLoginFormState extends State<EmailLoginForm> {
  LoginController controller = Get.find<LoginController>();
  bool isShow = true;

  void _seenPassword() {
    setState(() {
      isShow = !isShow;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.sp),
      child: Column(
        children: [
          Container(
              margin: EdgeInsets.symmetric(horizontal: 5.sp),
              decoration: BoxDecoration(
                  color: Theme.of(Get.context!).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: EdgeInsets.only(left: 20.sp, right: 20.sp),
                child: addEditText2(controller.email, "Email Address".tr),
              )),
          SizedBox(height: 2.h),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 5.sp),
              decoration: BoxDecoration(
                  color: Theme.of(Get.context!).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: EdgeInsets.only(left: 20.sp, right: 20.sp),
                child: TextFormField(
                  cursorColor: ColorConstants.primaryColor,
                  keyboardType: TextInputType.multiline,
                  controller: controller.password,
                  textInputAction: TextInputAction.next,
                  obscureText: isShow,
                  obscuringCharacter: "*",
                  style: TextStyle(fontSize: getNormalTextFontSIze()),
                  decoration: InputDecoration(
                      hintText: "Password".tr,
                      suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              isShow = !isShow;
                            });
                          },
                          child: Icon(
                            isShow ? Icons.visibility_off : Icons.visibility,
                            color:
                                Theme.of(Get.context!).colorScheme.onTertiary,
                          )),
                      hintStyle: TextStyle(
                          color: Theme.of(Get.context!).colorScheme.error,
                          fontSize: getNormalTextFontSIze()),
                      border: InputBorder.none),
                ),
              )),
          SizedBox(height: 2.h),
          GestureDetector(
              onTap: () => Get.to(() => const ForgetPasswordScreen()),
              child: Text(
                "Forgot password".tr,
                style: const TextStyle(
                    fontSize: 16, color: ColorConstants.primaryColor),
                textAlign: TextAlign.center,
              )),
          SizedBox(height: 2.h),
          GestureDetector(
              onTap: () {
                if (controller.email.text.trim().isEmpty) {
                  BaseOverlays().showSnackBar(
                      message: "Please enter email".tr, title: "Error");
                } else if (controller.password.text.trim().isEmpty) {
                  BaseOverlays().showSnackBar(
                      message: "Please enter password".tr, title: "Error");
                } else {
                  controller.verifyByEmail();
                }
              },
              child: BorderedButton(
                width: 1,
                text: "LOGIN".tr,
                isReversed: true,
              ))
        ],
      ),
    );
  }
}
