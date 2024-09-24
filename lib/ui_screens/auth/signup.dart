import 'dart:async';
import 'package:fixit/common/utils.dart';
import 'package:fixit/ui_screens/auth/controller/signup_login_controller.dart';
import 'package:fixit/ui_screens/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../NewScreen/languageExpansionTile.dart';
import '../../Routes/app_routes.dart';
import '../../common/base_overlays.dart';
import '../../common/bordered_button.dart';
import '../../common/color_constants.dart';
import '../profileSubPage/termCondition.dart';
import 'controller/login_controller.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  AuthController controller=Get.put(AuthController());
  LoginController sController = Get.put(LoginController());

  bool isShow = true;
  bool isShow1 = true;
  bool isAccept = false;
   Timer ? _debounce;

   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.isVerified.value=false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.headerTextDark,
     // resizeToAvoidBottomInset: false,
      body:SingleChildScrollView(
        child: Column(
          mainAxisAlignment:MainAxisAlignment.start,
          children: [
            SizedBox(height: 8.h,),
            Container(
              padding: const EdgeInsets.all(20),
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
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.arrow_back,color: Colors.black,),
                            const Text("Back",
                              style: TextStyle(
                                fontSize: 16,
                                color: ColorConstants.black,
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
                  SizedBox(height: 2.h,),
                  const Text(
                    "Setup your account",
                    style: TextStyle(
                        fontSize: 30,
                        color: ColorConstants.black,
                        fontFamily: 'Aeonik',
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: const Text(
                      "Full the following information and setup your Accounts password to get you started",
                      style: TextStyle(
                        fontSize: 14,
                        color: ColorConstants.black,
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
               // SizedBox(
               //   height: 2.h,
               //  ),
                  // Container(
                  //     decoration: BoxDecoration(
                  //         color: Theme.of(context).colorScheme.primaryContainer,
                  //         borderRadius: BorderRadius.circular(10)
                  //     ),
                  //     child: Padding(
                  //       padding: EdgeInsets.only(left:20.sp,right: 20.sp),
                  //       child: TextFormField(
                  //         cursorColor: ColorConstants.primaryColor,
                  //         keyboardType: TextInputType.phone,
                  //         controller:controller.mobileNo.value,
                  //         textInputAction: TextInputAction.next,
                  //         inputFormatters: [LengthLimitingTextInputFormatter(10), // Set your desired max length
                  //         ],
                  //         style: TextStyle(fontSize: getNormalTextFontSIze()+1,color:Theme.of(Get.context!).colorScheme.onTertiary),
                  //         decoration: InputDecoration(
                  //             hintText: "Mobile Number".tr,
                  //             prefixIcon:Padding(
                  //               padding: EdgeInsets.only(top: 15.sp),
                  //               child: Text("+964 ",style: TextStyle(color:Theme.of(Get.context!).colorScheme.onTertiary,fontSize: 16),),
                  //             ) ,
                  //             suffixIcon: GestureDetector(
                  //                 onTap: (){
                  //                   if(controller.mobileNo.value.text.length==10){
                  //                     controller.verifyMobile();
                  //                   } else{
                  //                     BaseOverlays().showSnackBar(message:"Please enter 10 digit mobile no".tr, title: "Error".tr);
                  //                   }
                  //                 },
                  //                 child:Obx(() =>Padding(
                  //                   padding: EdgeInsets.all(15.sp),
                  //                   child: Text(controller.isVerified.value?"Verified":"Verify".tr,style: const TextStyle(color: ColorConstants.primaryColor,fontSize: 16),),
                  //                 ))),
                  //             hintStyle: TextStyle(
                  //                 color: Theme.of(Get.context!).colorScheme.error,
                  //                 fontSize: getNormalTextFontSIze()
                  //             ),
                  //             border: InputBorder.none),
                  //       ),
                  //     )),
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
            Container(
                //margin: EdgeInsets.symmetric(horizontal:5),
                decoration: BoxDecoration(
                    color:const Color(0xffDDDDDD),
                    borderRadius: BorderRadius.circular(13)
                ),
                child: Padding(
                  padding: EdgeInsets.only(left:10.sp,right: 20.sp,top:11.sp,bottom:11.sp),
                  child: TextFormField(
                    cursorColor: ColorConstants.primaryColor,
                    keyboardType: TextInputType.multiline,
                    controller:controller.password.value,
                    textInputAction: TextInputAction.next,
                    obscureText: isShow,
                    obscuringCharacter: "*",
                    style: TextStyle(fontSize: getNormalTextFontSIze(),color: ColorConstants.black),
                    decoration: InputDecoration(
                        hintText: "Password".tr,
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(bottom: 15.sp),
                          child: Icon(Icons.lock_outline, color: ColorConstants.black),
                        ),
                        suffixIcon: GestureDetector(
                            onTap: (){
                              setState(() {
                                isShow=!isShow;
                              });
                            },
                            child:Icon(isShow? Icons.visibility_off_outlined : Icons.visibility_outlined,color: ColorConstants.black)),
                        hintStyle: TextStyle(
                            color: ColorConstants.black,
                            fontSize: getNormalTextFontSIze(),
                            fontFamily: 'Aeonik',
                          fontWeight: FontWeight.w400,
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
                    color:const Color(0xffDDDDDD),
                    borderRadius: BorderRadius.circular(13)
                ),
                child: Padding(
                  padding: EdgeInsets.only(left:10.sp,right: 20.sp,top:11.sp,bottom:11.sp),
                  child: TextFormField(
                    cursorColor: ColorConstants.primaryColor,
                    keyboardType: TextInputType.multiline,
                    controller:controller.confirmPassword.value,
                    textInputAction: TextInputAction.next,
                    obscureText: isShow1,
                    onChanged: (String value){
                      if (_debounce?.isActive ?? false) _debounce!.cancel();
                      _debounce = Timer(const Duration(milliseconds:1500), () {
                        if(controller.password.value.text != value){
                          BaseOverlays().showSnackBar(message:"Password not matched".tr, title: "Error".tr);
                        }
                      });
                    },
                    obscuringCharacter: "*",
                    style: TextStyle(fontSize: getNormalTextFontSIze(),color: ColorConstants.black),
                    decoration: InputDecoration(
                        hintText: "Re-Type Password".tr,
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(bottom: 15.sp),
                          child: Icon(Icons.lock_outline, color: ColorConstants.black),
                        ),
                        suffixIcon: GestureDetector(
                            onTap: (){
                              setState(() {
                                isShow1=!isShow1;
                              });
                            },
                            child:Icon(isShow1? Icons.visibility_off_outlined : Icons.visibility_outlined,color:ColorConstants.black)),
                          hintStyle: TextStyle(
                             color: ColorConstants.black,
                            fontSize: getNormalTextFontSIze(),
                              fontFamily: 'Aeonik',
                            fontWeight: FontWeight.w400,
                        ),
                        border: InputBorder.none),
                  ),
                )),
            // SizedBox(
            //   height: 2.h,
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Theme(
                  data: ThemeData(
                    checkboxTheme: CheckboxThemeData(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                  child: Checkbox(
                    checkColor: ColorConstants.headerTextDark,
                    activeColor: ColorConstants.primaryColor,
                    value: isAccept,
                    onChanged: (bool? value) {
                      setState(() {
                        isAccept=!isAccept;
                      });
                    },
                  ),
                ),
                // GestureDetector(
                //     onTap:(){
                //       setState(() {
                //         isAccept=!isAccept;
                //       });
                //     },
                //     child: Icon(isAccept?Icons.check_box_outlined:Icons.check_box_outline_blank,color: ColorConstants.primaryColor,)
                // ),
                // SizedBox(
                //   width:1.w,
                // ),
                GestureDetector(
                  onTap: () => Get.to(const TermsConditions()),
                  child: RichText(
                    text: const TextSpan(
                      text: 'Accept ',
                      style: TextStyle(
                        fontFamily: 'Gotham',
                        fontSize: 13,
                        color: ColorConstants.black,
                        height: 1,
                      ),
                      children: [
                        TextSpan(
                          text: 'Term & Condition',
                          style: TextStyle(
                            fontFamily: 'Gotham',
                            fontSize: 13,
                            color: ColorConstants.primaryColor, // Change to your desired color
                            decoration: TextDecoration.underline, // Add underline
                          ),
                        ),
                      ],
                    ),
                  ),
                )

              ],
            ),
            // SizedBox(
            //   height: 2.h,
            // ),
            GestureDetector(onTap:(){
              if(controller.fullName.value.text.isEmpty){
                BaseOverlays().showSnackBar(message:"Full Name is Required".tr, title: "Error".tr);
              }else if(controller.email.value.text.isEmpty){
                BaseOverlays().showSnackBar(message:"Email is Required".tr, title: "Error".tr);
              }else if(controller.password.value.text.isEmpty){
                BaseOverlays().showSnackBar(message:"Password is Required".tr, title: "Error".tr);
              }else if(!isAccept){
                BaseOverlays().showSnackBar(message:"Please accept our term & conditions".tr, title: "Error".tr);
              }
              else{
                Get.to(LoginScreen());
               // controller.signUp();
              }
            },child: BorderedButton(width:1, text: "Complete".tr,isReversed: true,)),
            SizedBox(
              height: 3.h,
            ),
            // GestureDetector(
            //   onTap: ()=>Get.offAndToNamed(Routes.loginScreen),
            //   child: Text.rich(
            //     TextSpan(
            //       style: TextStyle(
            //         fontFamily: 'Work Sans',
            //         fontSize: 15,
            //         color: Theme.of(context).colorScheme.tertiary,
            //         height: 1,
            //       ),
            //       children: [
            //         TextSpan(
            //           text: 'if you already have an account?'.tr,
            //         ),
            //         TextSpan(
            //           text: 'Login'.tr,
            //           style: const TextStyle(
            //             color: Color(0xff039759),
            //           ),
            //         ),
            //       ],
            //     ),
            //     textHeightBehavior:
            //     const TextHeightBehavior(applyHeightToFirstAscent: false),
            //     textAlign: TextAlign.center,
            //     softWrap: false,
            //   ),
            // ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}