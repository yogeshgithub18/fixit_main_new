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
import '../ui_screens/auth/setpassword_screen.dart';
import 'AppTextFile.dart';
import 'languageExpansionTile.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({super.key});

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.headerTextDark,
      body: SafeArea(
        child:  SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 60),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset('assets/images/fixitlogo.svg'),
                    // LanguageExpansionTile(
                    //   items: List.generate(3, (index) => controller.languageSelectName[index]),
                    //   items2: List.generate(3, (index) => controller.languageSelect[index]),
                    // )
                  ],
                ),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    AppTexts.aeonikText16W500(
                      "Reset Password",
                      fontSize: 30,
                        fontWeight: FontWeight.bold,
                      textAlign: TextAlign.center,
                    ),
                     AppTexts.aeonikText14W400(
                      "Enter your mobile number to reset your account Password",
                      maxLines: 2,
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.visible,
                    )
                  ],
                ),

                const SizedBox(height: 40,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left:20,top: 19,right: 10,bottom: 19),
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

                        "+964 ",

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
                              borderRadius:getBorderRadius13()
                          ),
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
                                  hintStyle:hintStyleTextField(),
                                  border: InputBorder.none),
                            ),
                          )),
                    ),
                  ],
                ),
                const SizedBox(height: 30,),
                GestureDetector(onTap:(){
                  if(controller.mobileNo.text.trim().isNotEmpty){
                    controller.verifyByMobile();
                  }else{
                    BaseOverlays().showSnackBar(message:"Please enter mobile no".tr,title: "Error");
                  }
                },
                    child: BorderedButton(width:60.0.w,text: "Next".tr,isReversed: true,)
                ),
                const SizedBox(height: 50,),
                // ElevatedButton(
                //   onPressed: () {
                //     Navigator.push(context, MaterialPageRoute(builder: (context)=>SetPasswordScreen(email: '',)));
                //   },
                //   style: ElevatedButton.styleFrom(
                //     foregroundColor: Colors.white, backgroundColor: Colors.teal, // Button text color
                //     padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12), // Button padding
                //     shape: RoundedRectangleBorder(
                //       borderRadius: getEdgyBorderRadius(), // Button border radius
                //     ),
                //   ),
                //   child: const Text(
                //     "Next",
                //     style: TextStyle(
                //       fontSize: 16,
                //       fontFamily: 'Aeonik',
                //       fontWeight: FontWeight.w500,
                //     ),
                //   ),
                // ),


              ],
            ),
          ),
        ),
      ),
    );
  }
}

