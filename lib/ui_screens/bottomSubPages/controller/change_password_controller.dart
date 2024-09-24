import 'package:fixit/ui_screens/auth/controller/login_controller.dart';
import 'package:fixit/ui_screens/auth/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../backend/api_end_points.dart';
import '../../../backend/base_api.dart';
import '../../../common/base_overlays.dart';
import '../../auth/emailotp_screen.dart';

class  ChangePasswordController extends GetxController{
  TextEditingController email =TextEditingController();
  TextEditingController oldPassword=TextEditingController();
  TextEditingController newPassword=TextEditingController();
  TextEditingController confirmPassword=TextEditingController();

  changePassword()async{
    FocusScope.of(Get.context!).requestFocus(FocusNode());
     Map<String, dynamic> data = {
      "old_password": oldPassword.text,
      "new_password": newPassword.text,
      "new_password_confirmation": confirmPassword.text,
    };
    await BaseAPI().post(url: ApiEndPoints().changePassword, data: data,showLoader: true).then((value) {
      if (value?.statusCode == 200) {
          Get.back();
          BaseOverlays().showSnackBar(message:"Password updated".tr, title: "Success".tr);
      } else {
        BaseOverlays().showSnackBar(message:"Something Went Wrong!!!".tr, title: "Error".tr);
      }
    });
  }
  forgetPasswordScreen(bool resend)async{
    FocusScope.of(Get.context!).requestFocus(FocusNode());
    Map<String, dynamic> data = {
      "email":email.text,
    };
    await BaseAPI().post(url: ApiEndPoints().forgetPassword, data: data,showLoader: true).then((value) {
      if (value?.statusCode == 200) {
        if(!resend){
          Get.to(EmailOtpScreen(email:email.text));
        }
        BaseOverlays().showSnackBar(message:"Otp Sent To Register Email".tr, title: "Success".tr);
      } else {
        BaseOverlays().showSnackBar(message:"Something Went Wrong!!!".tr, title: "Error".tr);
      }
    });
  }

  setPassword(String mail)async{
    FocusScope.of(Get.context!).requestFocus(FocusNode());
    Map<String, dynamic> data = {
      "email":mail,
      "new_password": newPassword.text,
      "new_password_confirmation": confirmPassword.text,
    };
    await BaseAPI().post(url: ApiEndPoints().updateForgotPassword, data: data,showLoader: true).then((value) {
      if (value?.statusCode == 200) {
        Get.offAll(const LoginScreen());
        BaseOverlays().showSnackBar(message:"Password updated".tr, title: "Success".tr);
      } else {
        BaseOverlays().showSnackBar(message:"Something Went Wrong!!!".tr, title: "Error".tr);
      }
    });
  }
}