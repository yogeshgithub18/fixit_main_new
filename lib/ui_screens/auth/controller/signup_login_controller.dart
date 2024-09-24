import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fixit/backend/api_end_points.dart';
import 'package:fixit/backend/base_api.dart';
import 'package:fixit/common/base_overlays.dart';
import 'package:fixit/ui_screens/auth/otp.dart';
import 'package:fixit/ui_screens/auth/setpassword_screen.dart';
import 'package:fixit/ui_screens/locations/manage_address.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../NewScreen/NewHome.dart';
import '../../../NewScreen/NewOtpVery.dart';
import '../../../Routes/app_routes.dart';
import '../../../backend/modal/location_data_model.dart';
import '../../../backend/modal/login_response.dart';
import '../../../backend/modal/otp_response.dart';
import '../../../backend/modal/signUp_response.dart';
import '../../../main.dart';
import '../../../storage/base_shared_preference.dart';
import '../../../storage/sp_keys.dart';

class AuthController extends GetxController {
  late Rx<TextEditingController> fullName;
   Rx<TextEditingController>  mobileNo = TextEditingController().obs;

  late Rx<TextEditingController> email;

  late Rx<TextEditingController> password;

  late Rx<TextEditingController> confirmPassword;
  RxBool isVerified=false.obs;
  List<LocationData> locationDataList=[];
  @override
  void onInit() {
    super.onInit();
    fullName = TextEditingController().obs;
    email = TextEditingController().obs;
    password = TextEditingController().obs;
    confirmPassword = TextEditingController().obs;
  }

  verify() async {
    FocusScope.of(Get.context!).requestFocus(FocusNode());
    Map<String, dynamic> data = {"phone": mobileNo.value.text,"role_type":1,"auth_type":"register"};
    await BaseAPI().post(url: ApiEndPoints().login, data: data).then((value) {
       LoginResponse response = LoginResponse.fromJson(value?.data);
      if (response.status??false) {
        BaseOverlays().showSnackBar(message: response.message!, title: "Success".tr);
        verifyMobile();
      } else {
        BaseOverlays().showSnackBar(message: response.message ?? "", title: "Error".tr);
      }
    });
  }

  Future<void>  verifyMobile() async {
      FirebaseAuth auth = FirebaseAuth.instance;
      BaseOverlays().showLoader(showLoader: true);
      await auth.verifyPhoneNumber(
       phoneNumber: '+964${mobileNo.value.text.trim()}',
     // phoneNumber: '+91 ${mobileNo.value.text.trim()}',
      timeout:const Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential credential) async {
        print("kuldeeppppppppppp----11--${credential.smsCode}");
      },
      verificationFailed: (FirebaseAuthException e) {
        print("kuldeeppppppppppp----333--${e}");
        BaseOverlays().dismissOverlay(showLoader:true);
        if (e.code == 'invalid-phone-number') {
          BaseOverlays().showSnackBar(message:"The provided phone number is not valid.".tr, title: "Error".tr);
        }
      },
      codeSent: (String verificationId, int? resendToken) async {
        BaseOverlays().dismissOverlay(showLoader:true);
        Get.to(NewOtp(
          phone: mobileNo.value.text.trim(),
          id:verificationId,
          pageName: "signup",
        ));
      }, codeAutoRetrievalTimeout: (String verificationId) {

    },
    );
  }

  signUp() async {
    if(Platform.isAndroid){
      if (deviceToken == '' || deviceToken.isEmpty || deviceToken == '1234') {
        deviceToken = await FirebaseMessaging.instance.getToken() ?? '1234';
      }
    }else if(Platform.isIOS){
      if (deviceToken == '' || deviceToken.isEmpty || deviceToken == '1234') {
        deviceToken = await FirebaseMessaging.instance.getAPNSToken() ?? '1234';
      }
    }
    FocusScope.of(Get.context!).requestFocus(FocusNode());
    Map<String, dynamic> data = {
      "name": fullName.value.text,
      "email": email.value.text,
      "phone": mobileNo.value.text,
      "password": "123456",
      "device_token":deviceToken,
      "password_confirmation": "123456",
    };
    await BaseAPI()
        .post(url: ApiEndPoints().register, data: data)
        .then((value) async {
      OtpResponse response = OtpResponse.fromJson(value?.data);
      if (response.status??false) {
        isVerified.value=false;
        BaseSharedPreference().setBool(SpKeys().isLoggedIn, true);
        BaseSharedPreference().setString(SpKeys().apiToken, response.data?.token ?? "");
        BaseSharedPreference().setInt(SpKeys().userId, response.data?.id ?? "");
        BaseSharedPreference().setString(SpKeys().isNotification, response.data?.isNotification ?? "0");
        await getUserLocations();
        BaseOverlays().showSnackBar(message: response.message!, title: "Success".tr);
      } else {
        BaseOverlays().showSnackBar(message: response.message ?? "", title: "Error".tr);
      }
    });
  }

  Future <void> getUserLocations() async {
    Map<String, dynamic> params = {};
    await BaseAPI()
        .get(url: ApiEndPoints().getLocations, queryParameters: params)
        .then((value) {
      if (value!=null && value.statusCode == 200) {
        locationDataList=LocationDataModel.fromJson(value.data).data ?? [];
        if(locationDataList.isEmpty){
          Get.offAll( const ManageAddress(page:"Login"));
        }else{
          Get.offAll( const FixitHomeScreen());
        }
      }else{
        Get.offAll( const ManageAddress(page:"Login"));
      }
    });
  }

  checkOtp(String otp, String mobile) async {
    if(Platform.isAndroid){
      if (deviceToken == '' || deviceToken.isEmpty || deviceToken == '1234') {
        deviceToken = await FirebaseMessaging.instance.getToken() ?? '1234';
      }
    }else if(Platform.isIOS){
      if (deviceToken == '' || deviceToken.isEmpty || deviceToken == '1234') {
        deviceToken = await FirebaseMessaging.instance.getAPNSToken() ?? '1234';
      }
    }
    FocusScope.of(Get.context!).requestFocus(FocusNode());
    Map<String, dynamic> data = {
      "phone":mobile,
      "otp":otp,
      'fcm_token': deviceToken
    };
    await BaseAPI().post(url: ApiEndPoints().otpVerify, data: data, showLoader: true).then((value) async {
      OtpResponse response = OtpResponse.fromJson(value?.data);
      if (value?.statusCode == 200) {
        BaseSharedPreference().setBool(SpKeys().isLoggedIn, true);
        BaseSharedPreference().setString(SpKeys().apiToken, response.data?.token ?? "");
        BaseSharedPreference().setInt(SpKeys().userId, response.data?.id ?? "");
        BaseSharedPreference().setString(SpKeys().isNotification, response.data?.isNotification ?? "0");
        await getUserLocations();
        if ((response.message ?? "").isNotEmpty) {
          BaseOverlays().showSnackBar(message: response.message!, title: "Success".tr);
        }
       } else {
        BaseOverlays().showSnackBar(message: response.message ?? "", title: "Error".tr);
      }
    });
  }

}
