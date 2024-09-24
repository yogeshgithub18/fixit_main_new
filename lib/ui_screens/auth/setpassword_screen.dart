import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../NewScreen/AppTextFile.dart';
import '../../NewScreen/languageExpansionTile.dart';
import '../../common/base_overlays.dart';
import '../../common/bordered_button.dart';
import '../../common/color_constants.dart';
import '../../common/utils.dart';
import '../app_header.dart';
import '../bottomSubPages/controller/change_password_controller.dart';
import 'controller/login_controller.dart';

class SetPasswordScreen extends StatefulWidget {
  String email;
   SetPasswordScreen({super.key,required this.email});

  @override
  State<SetPasswordScreen> createState() => _SetPasswordScreenState();
}

class _SetPasswordScreenState extends State<SetPasswordScreen> {
  bool isShow=false;
  bool isShow1=true;
  bool isShow2=true;
  LoginController setController = Get.put(LoginController());

  ChangePasswordController controller =Get.put(ChangePasswordController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.headerTextDark,
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 6.h,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset('assets/images/fixitlogo.svg'),
                // LanguageExpansionTile(
                //   items: List.generate(2, (index) => setController.languageSelectName[index]),
                //   items2: List.generate(2, (index) => setController.languageSelect[index]),
                // )
              ],
            ),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [


                AppTexts.aeonikText16W500(
                  "Enter New Password",
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  textAlign: TextAlign.center,
                ),
                AppTexts.aeonikText14W400(
                  "Enter your new account password that you want to Assigned to your account",
                  maxLines: 2,
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.visible,
                )
              ],
            ),
            SizedBox(
              height: 2.h,
            ),
            Container(
              //  margin: EdgeInsets.symmetric(horizontal:5),
                decoration: BoxDecoration(
                    color: ColorConstants.fixitText,
                    borderRadius: getBorderRadius13()
                ),
                child: Padding(
                  padding: EdgeInsets.only(left:10.sp,right: 10.sp,top: 11.sp,bottom: 11.sp),
                  child: TextFormField(
                    cursorColor: ColorConstants.primaryColor,
                    keyboardType: TextInputType.multiline,
                    controller: controller.newPassword,
                    textInputAction: TextInputAction.next,
                    obscureText: isShow1,
                    obscuringCharacter: "*",
                    style: TextStyle(fontSize: getNormalTextFontSIze(),color:ColorConstants.black),
                    decoration: InputDecoration(
                        hintText: "New Password".tr,
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
                            child:Icon(isShow1?Icons.visibility_off_outlined:Icons.visibility_outlined,color: ColorConstants.black)),
                        hintStyle: hintStyleTextField(),
                        border: InputBorder.none),
                  ),
                )),
            SizedBox(
              height: 2.h,
            ),
            Container(
              //  margin: EdgeInsets.symmetric(horizontal:5),
                decoration: BoxDecoration(
                    color:ColorConstants.fixitText,
                    borderRadius: getBorderRadius13()
                ),
                child: Padding(
                  padding: EdgeInsets.only(left:10.sp,right: 10.sp,top: 11.sp,bottom: 11.sp),
                  child: TextFormField(
                    cursorColor: ColorConstants.primaryColor,
                    keyboardType: TextInputType.multiline,
                    controller: controller.confirmPassword,
                    textInputAction: TextInputAction.next,
                    obscureText: isShow2,
                    obscuringCharacter: "*",
                    style: TextStyle(fontSize: getNormalTextFontSIze(),color: ColorConstants.black),
                    decoration: InputDecoration(
                        hintText: "Re-Type New Password".tr,
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(bottom: 15.sp),
                          child: const Icon(Icons.lock_outline, color: ColorConstants.black),
                        ),
                        suffixIcon: GestureDetector(
                            onTap: (){
                              setState(() {
                                isShow2=!isShow2;
                              });

                            },
                            child:Icon(isShow2?Icons.visibility_off_outlined:Icons.visibility_outlined,color: ColorConstants.black)),
                        hintStyle: hintStyleTextField(),
                        border: InputBorder.none),
                  ),
                )),
            Padding(padding:  EdgeInsets.only(bottom: 20.sp,top: 24.sp),
              child: SizedBox(
                height: 6.h,
                child: GestureDetector(onTap:(){
                  if(controller.newPassword.value.text.trim() !=controller.confirmPassword.value.text.trim()){
                    BaseOverlays().showSnackBar(message:"Password not matched".tr, title: "Error".tr);
                  }else {
                    controller.setPassword(widget.email);
                  }
                },child: BorderedButton(width:1, text: "Complete".tr,isReversed: true,)),
              ),
            )
          ],
        ),
      ),

    );
  }
}
