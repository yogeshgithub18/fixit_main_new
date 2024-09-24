import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fixit/Routes/app_routes.dart';
import 'package:fixit/backend/modal/otp_response.dart';
import 'package:fixit/main.dart';
import 'package:fixit/ui_screens/auth/controller/signup_login_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import '../../../NewScreen/NewHome.dart';
import '../../../NewScreen/NewOtpVery.dart';
import '../../../backend/api_end_points.dart';
import '../../../backend/base_api.dart';
import '../../../backend/modal/location_data_model.dart';
import '../../../backend/modal/login_response.dart';
import '../../../common/base_overlays.dart';
import '../../../storage/base_shared_preference.dart';
import '../../../storage/sp_keys.dart';
import '../../locations/manage_address.dart';
import '../otp.dart';
import '../setpassword_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';
class LoginController extends GetxController {
  TextEditingController mobileNo = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController otp = TextEditingController();
  TextEditingController loginPassword = TextEditingController();
  RxBool isUsingMobile = true.obs;
  RxString activeAddress=''.obs;
  List<LocationData> locationDataList=[];

  RxString matchStatus = ''.obs;
  RxBool languageCollapse = false.obs;
  List<LanguagePenal> languageSelectName = [
    LanguagePenal(name:"EN",code:"en",),
    LanguagePenal(name:"AR",code:"ar",),
    LanguagePenal(name:"KU",code:"ku",)
  ];
  List<String> languageSelect = [
    "assets/images/en.svg",
    "assets/images/ar.svg",
    "assets/images/ku.svg"
  ];

  verifyByMobile() async {
    FocusScope.of(Get.context!).requestFocus(FocusNode());
    Map<String, dynamic> dataMobile = {"phone": mobileNo.text,"role_type":1,"auth_type":"login"};
    await BaseAPI().post(url: ApiEndPoints().login, data: dataMobile).then((value) {
      LoginResponse response = LoginResponse.fromJson(value?.data);
      print("response ----$response");
      if (response.status??false) {
        if ((response.message ?? "").isNotEmpty) {
          BaseOverlays().showSnackBar(message: response.message!, title: "Success".tr);
        }
        verifyMobile();
      } else {
        BaseOverlays().showSnackBar(message: response.message ?? "", title: "Error".tr);
      }
    });
  }

  verifyMobile() async {
    print("calling verifyMobile ----");
    FirebaseAuth auth = FirebaseAuth.instance;
    BaseOverlays().showLoader(showLoader: true);
    await auth.verifyPhoneNumber(
      phoneNumber: '+964${mobileNo.text.trim()}',
      timeout:const Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential credential) async {
        print("verification complete while sending otp");
        await auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        print("error in otp ----$e");
        BaseOverlays().dismissOverlay(showLoader: true);
        if (e.code == 'invalid-phone-number') {
          BaseOverlays().showSnackBar(message:"The provided phone number is not valid.".tr, title: "Error".tr);
        }else if (e.code == 'too-many-requests') {
          BaseOverlays().showSnackBar(message:"We have blocked all requests from this device due to unusual activity. Try again later".tr, title: "Error".tr);
        }else{
          BaseOverlays().showSnackBar(message:"Something Went Wrong!!!".tr, title: "Error".tr);
        }
      },
      codeSent: (String verificationId, int? resendToken) async {
         BaseOverlays().dismissOverlay(showLoader: true);
         Get.to(()=>NewOtp(phone: mobileNo.text.trim(), id:verificationId,pageName: "login",));
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        // Auto-resolution timed out...
      },
    );
  }

  verifyByEmail() async {
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
    Map<String, dynamic> dataEmail = {
      "email": email.text,
      "password": password.text,
      'fcm_token': deviceToken,
      'role_type': 1
    };
    await BaseAPI().post(url: ApiEndPoints().login, data: dataEmail).then((value) {
      OtpResponse response = OtpResponse.fromJson(value?.data);
      if (value?.statusCode == 200) {
        BaseSharedPreference().setBool(SpKeys().isLoggedIn, true);
        BaseSharedPreference().setString(SpKeys().apiToken, response.data?.token ?? "");
        BaseSharedPreference().setInt(SpKeys().userId, response.data?.id ?? "");
        if ((response.message ?? "").isNotEmpty) {
          BaseOverlays()
              .showSnackBar(message: response.message!, title: "Success".tr);
        }
        print('nukul1');
        getUserLocations();
        print('2');

        // Get.offAll( const ManageAddress(page:"Login"));
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
         // Get.offAllNamed(Routes.home);
        }
      }else{
        Get.offAll( const ManageAddress(page:"Login"));
      }
    });
  }


  checkOtp(String otp) async {
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
      "phone": mobileNo.value.text,
      "otp": otp,
      'fcm_token': deviceToken
    };
    await BaseAPI()
        .post(url: ApiEndPoints().otpVerify, data: data, showLoader: true)
        .then((value) {
      OtpResponse response = OtpResponse.fromJson(value?.data);
      if (value?.statusCode == 200) {
        BaseSharedPreference().setBool(SpKeys().isLoggedIn, true);
        BaseSharedPreference()
            .setString(SpKeys().apiToken, response.data?.token ?? "");
        BaseSharedPreference().setInt(SpKeys().userId, response.data?.id ?? "");
        if ((response.message ?? "").isNotEmpty) {
          BaseOverlays()
              .showSnackBar(message: response.message!, title: "Success".tr);
        }
        Get.offAll( const FixitHomeScreen());
      } else {
        BaseOverlays()
            .showSnackBar(message: response.message ?? "", title: "Error".tr);
      }
    });
  }

  Future<void> googleLogin() async {
    try {
      if(Platform.isAndroid){
        if (deviceToken == '' || deviceToken.isEmpty || deviceToken == '1234') {
          deviceToken = await FirebaseMessaging.instance.getToken() ?? '1234';
        }
      }else if(Platform.isIOS){
        if (deviceToken == '' || deviceToken.isEmpty || deviceToken == '1234') {
          deviceToken = await FirebaseMessaging.instance.getAPNSToken() ?? '1234';
        }
      }
      final FirebaseAuth _auth = FirebaseAuth.instance;
      GoogleSignIn _googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return; // User canceled the sign-in
      }
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
              accessToken: googleAuth.accessToken,
              idToken: googleAuth.idToken,
      );
      final UserCredential userCredential = await _auth.signInWithCredential(credential);
      print("credential---$credential");
      print("googleAuth---${userCredential}");
     String googleEmail = _googleSignIn.currentUser?.email ?? "";
     String  googleName = _googleSignIn.currentUser?.displayName ?? "";
     String gimage = _googleSignIn.currentUser?.photoUrl ?? "";
     print("---$googleEmail----$googleName=----$gimage----${googleAuth.accessToken}");
      Map<String, dynamic> param = {
      "social_id":userCredential.user?.uid,
      "login_type":"google",
      "name":googleName,
      "phone":userCredential.user?.phoneNumber,
      "email":googleEmail,
        "device_token":deviceToken,
        "image":gimage
      };
      print("---$param");
       await BaseAPI().post(url: ApiEndPoints().googleLogin,data: param).then((value){
        print("value---$value");
        OtpResponse response = OtpResponse.fromJson(value?.data);
        if (value?.statusCode == 200) {
          BaseSharedPreference().setBool(SpKeys().isLoggedIn, true);
          BaseSharedPreference().setString(SpKeys().apiToken, response.data?.token ?? "");
          BaseSharedPreference().setInt(SpKeys().userId, response.data?.id ?? "");
          if ((response.message ?? "").isNotEmpty) {
            BaseOverlays()
                .showSnackBar(message: response.message!, title: "Success".tr);
          }
          getUserLocations();
          // Get.offAll( const ManageAddress(page:"Login"));
        } else {
          BaseOverlays().showSnackBar(message: response.message ?? "", title: "Error".tr);
        }
      });
    }catch(e){
      print("eee--$e");
    }
  }


  Future<void> appleLogin() async {
    try {
      if(Platform.isAndroid){
        if (deviceToken == '' || deviceToken.isEmpty || deviceToken == '1234') {
          deviceToken = await FirebaseMessaging.instance.getToken() ?? '1234';
        }
      }else if(Platform.isIOS){
        if (deviceToken == '' || deviceToken.isEmpty || deviceToken == '1234') {
          deviceToken = await FirebaseMessaging.instance.getAPNSToken() ?? '1234';
        }
      }
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ]
      );
      var code = credential.userIdentifier;
      var email = credential.email;
      String ? firstName = credential.givenName?.split(" ").first ?? "";
      String ? familyName = credential.familyName??'';
     String ? socialName = (firstName.isNotEmpty && familyName.isNotEmpty)
          ? "$firstName $familyName"
          : (firstName.isNotEmpty
          ? firstName
          : (familyName.isNotEmpty
          ? familyName
          : 'User${DateTime.now().millisecondsSinceEpoch}'));
      // final FirebaseAuth _auth = FirebaseAuth.instance;
      // GoogleSignIn _googleSignIn = GoogleSignIn();
      // final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      // if (googleUser == null) {
      //   return; // User canceled the sign-in
      // }
      // final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      // final AuthCredential credential = GoogleAuthProvider.credential(
      //         accessToken: googleAuth.accessToken,
      //         idToken: googleAuth.idToken,
      // );
      // final UserCredential userCredential = await _auth.signInWithCredential(credential);
      Map<String, dynamic> param = {
      "social_id":code,
      "login_type":"apple",
      "name":socialName,
      "phone":'',
      "email":email,
        "device_token":deviceToken,
        "image":null
      };
      print("---$param");
       await BaseAPI().post(url: ApiEndPoints().googleLogin,data: param).then((value){
        print("value---$value");
        OtpResponse response = OtpResponse.fromJson(value?.data);
        if (value?.statusCode == 200) {
          BaseSharedPreference().setBool(SpKeys().isLoggedIn, true);
          BaseSharedPreference().setString(SpKeys().apiToken, response.data?.token ?? "");
          BaseSharedPreference().setInt(SpKeys().userId, response.data?.id ?? "");
          if ((response.message ?? "").isNotEmpty) {
            BaseOverlays().showSnackBar(message: response.message!, title: "Success".tr);
          }
          getUserLocations();
        } else {
          BaseOverlays().showSnackBar(message: response.message ?? "", title: "Error".tr);
        }
      });
    }catch(e){
      print("eee--$e");
    }
  }
}

class LanguagePenal{
  String name;
  String code;

  LanguagePenal({required this.name,required this.code});
}
