import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fixit/backend/api_end_points.dart';
import 'package:fixit/backend/base_api.dart';
import 'package:fixit/backend/modal/profile_response.dart';
import 'package:fixit/backend/modal/profile_update_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;

import '../../../common/base_overlays.dart';
import '../../auth/otp.dart';
class ProfileController extends GetxController{
  Rx<ProfileData> data=ProfileData().obs;
  TextEditingController fullName=TextEditingController();
  TextEditingController mobileNo=TextEditingController();
  TextEditingController email=TextEditingController();
  RxString gender="male".obs;
  Rx<File> ?selectedFile = File("").obs;
  RxString  imageData =''.obs;
  RxString  profilePath =''.obs;

  RxBool isVerified=false.obs;

  getProfile()async{
    await BaseAPI().get(url:ApiEndPoints().profile,showLoader: false).then((value){
      if(value?.statusCode==200){
       ProfileResponse response=ProfileResponse.fromJson(value?.data);
       data.value=response.data!;
      }
    });
  }

  setData() {
    fullName.text = data.value.name ?? "";
    mobileNo.text = data.value.phone!=null ?"+964${ data.value.phone}" :"+964 ";
    email.text = data.value.email ?? "";
    gender.value = data.value.gender ?? "male";
    profilePath.value = data.value.image ?? "";
  }


  updateProfile() async {
    FocusScope.of(Get.context!).requestFocus(FocusNode());
    dio.FormData data = dio.FormData.fromMap({
      "name": fullName.value.text,
      "email": email.value.text,
      "phone": mobileNo.value.text,
      "gender":gender.value,
    });
    if ((selectedFile?.value.path??"").isNotEmpty) {
      data.files.add (MapEntry("profile" ,await dio.MultipartFile.fromFile(selectedFile?.value.path??"", filename: selectedFile?.value.path.split("/").last??"")));
    }
    await BaseAPI().post(url: ApiEndPoints().updateProfile, data: data).then((value) {
      EditProfileResponse response = EditProfileResponse.fromJson(value?.data);
      if (value?.statusCode == 200) {
        Get.back();
        if ((response.message ?? "").isNotEmpty) {
          BaseOverlays().showSnackBar(message: response.message!, title: "Success");
        }
      } else {
        BaseOverlays().showSnackBar(message: response.message ?? "", title: "Error");
      }
    });
  }

 Future<void> verifyMobile() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    BaseOverlays().showLoader(showLoader: true);
    await auth.verifyPhoneNumber(
      phoneNumber: '+964${mobileNo.value.text.trim()}',
      timeout:Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential credential) async {
        BaseOverlays().dismissOverlay(showLoader: true);
        print("kuldeeppppppppppp----11--${credential.smsCode}");
      },
      verificationFailed: (FirebaseAuthException e) {
        print("kuldeeppppppppppp----333--${e.code}");
        BaseOverlays().dismissOverlay(showLoader: true);
        if (e.code == 'invalid-phone-number') {
          BaseOverlays().showSnackBar(message:"The provided phone number is not valid.".tr, title: "Error".tr);
        }
        if (e.code == 'too-many-requests') {
          BaseOverlays().showSnackBar(message:"We have blocked all requests from this device due to unusual activity. Try again later", title: "Error".tr);
        }
      },
      codeSent: (String verificationId, int? resendToken) async {
        print("kuldeeppppppppppp----444-${verificationId }-");
        BaseOverlays().dismissOverlay(showLoader: true);
       await Get.to(Otp(
          phone: mobileNo.text.trim(),
          id:verificationId,
          pageName: "profile",
        ));
       isVerified.value=true;
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        print("kuldeeppppppppppp----error--${verificationId}");
        // Auto-resolution timed out...
      },
    );
  }

}