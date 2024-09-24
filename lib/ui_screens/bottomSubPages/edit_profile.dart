import 'dart:io';

import 'package:fixit/common/base_overlays.dart';
import 'package:fixit/ui_screens/app_header.dart';
import 'package:fixit/ui_screens/auth/otp.dart';
import 'package:fixit/ui_screens/bottomSubPages/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../NewScreen/NewAppBar.dart';
import '../../common/base_image_network.dart';
import '../../common/bordered_button.dart';
import '../../common/color_constants.dart';
import '../../common/utils.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  ProfileController controller = Get.find<ProfileController>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.setData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(7.h),
          child:  NewAppHeader(
            title: "Edit Profile".tr,
            showBackIcon: true,
          )),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Edit Profile".tr,
                  style: TextStyle(
                      fontSize: 25,
                      color: Theme.of(context).colorScheme.tertiary),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 3.h,
                ),
                Stack(children: [
                  Obx(() => Container(
                        height: 16.h,
                        width: 33.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(150.0),
                        ),
                        child: controller.imageData.value.isEmpty &&
                                controller.profilePath.isEmpty
                            ? Image.asset(
                                "assets/images/profile.png",
                                fit: BoxFit.contain,
                              )
                            : controller.imageData.value.isNotEmpty
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(150),
                                    child: Image.file(
                                      controller.selectedFile!.value,
                                      fit: BoxFit.cover,
                                      alignment: Alignment.topCenter,
                                    ))
                                : BaseImageNetwork(
                                    link: controller.profilePath.value,
                                    fit: BoxFit.fill,
                                    borderRadius: 150,
                                    concatBaseUrl: false,
                                    errorWidget: Image.asset(
                                      "assets/images/profile.png",
                                      fit: BoxFit.cover,
                                      alignment: Alignment.topCenter,
                                    ),
                                  ),
                      )),
                  Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          BaseOverlays().showMediaPickerDialog(
                              onCameraClick: () async {
                            BaseOverlays().dismissOverlay();
                            ImagePicker picker = ImagePicker();
                            await picker
                                .pickImage(
                                    source: ImageSource.camera,
                                    imageQuality: 50)
                                .then(
                              (value) {
                                if (value != null) {
                                  controller.selectedFile?.value =
                                      File(value.path);
                                  controller.imageData.value =
                                      value.path.split("/").last;
                                }
                              },
                            );
                          }, onGalleryClick: () async {
                            BaseOverlays().dismissOverlay();
                            ImagePicker picker = ImagePicker();
                            await picker
                                .pickImage(
                                    source: ImageSource.gallery,
                                    imageQuality: 50)
                                .then((value) {
                              if (value != null) {
                                controller.selectedFile?.value =
                                    File(value.path);
                                controller.imageData.value =
                                    value.path.split("/").last;
                              }
                            });
                          });
                        },
                        child: Container(
                            width: 9.w,
                            height: 4.h,
                            decoration: BoxDecoration(
                              color: ColorConstants.primaryColor,
                              borderRadius: BorderRadius.circular(75),
                            ),
                            child: const Icon(
                              Icons.edit,
                              color: ColorConstants.white,
                              size: 20,
                            )),
                      ))
                ]),
                SizedBox(
                  height: 3.h,
                ),
                Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: EdgeInsets.only(left: 20.sp,right: 20.sp),
                      child: TextFormField(
                        cursorColor: ColorConstants.primaryColor,
                        keyboardType: TextInputType.multiline,
                        controller: controller.fullName,
                        textInputAction: TextInputAction.next,
                        style: TextStyle(
                            fontSize: getNormalTextFontSIze(),
                            color:
                                Theme.of(Get.context!).colorScheme.onTertiary),
                        decoration: InputDecoration(
                            hintText: "Full name".tr,
                            hintStyle: TextStyle(
                                color: Theme.of(Get.context!).colorScheme.error,
                                fontSize: getNormalTextFontSIze()),
                            border: InputBorder.none),
                      ),
                    )),
                SizedBox(
                  height: 2.h,
                ),
                Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: EdgeInsets.only(left: 20.sp,right: 20.sp),
                      child: TextFormField(
                        cursorColor: ColorConstants.primaryColor,
                        keyboardType: TextInputType.multiline,
                        controller: controller.mobileNo,
                        readOnly: false,
                        textInputAction: TextInputAction.next,
                        style: TextStyle(
                            fontSize: getNormalTextFontSIze(),
                            color: Theme.of(Get.context!).colorScheme.onTertiary),
                        decoration: InputDecoration(
                            hintText: "Mobile Number".tr,
                            // suffixIcon: GestureDetector(
                            //     onTap: () {
                            //       if(controller.mobileNo.value.text.trim().length==10){
                            //         controller.verifyMobile();
                            //         // controller.verify();
                            //       } else{
                            //         BaseOverlays().showSnackBar(message:"Please enter 10 digit mobile no".tr, title: "Error".tr);
                            //       }
                            //     },
                            //     child: Padding(
                            //       padding: EdgeInsets.all(15.sp),
                            //       child: Obx(() => Text(
                            //         controller.isVerified.value?"Verified":"Verify".tr,
                            //         style: const TextStyle(
                            //             color: ColorConstants.primaryColor,
                            //             fontSize: 16),
                            //       )),
                            //     )),
                            hintStyle: TextStyle(
                                color: Theme.of(Get.context!).colorScheme.error,
                                fontSize: getNormalTextFontSIze()),
                            border: InputBorder.none),
                      ),
                    )),
                SizedBox(
                  height: 2.h,
                ),
                Container(
                    //  margin: EdgeInsets.symmetric(horizontal:5),
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: EdgeInsets.only(left: 20.sp,right: 20.sp),
                      child: TextFormField(
                        cursorColor: ColorConstants.primaryColor,
                        keyboardType: TextInputType.multiline,
                        controller: controller.email,
                        textInputAction: TextInputAction.next,
                        style: TextStyle(
                            fontSize: getNormalTextFontSIze(),
                            color:
                                Theme.of(Get.context!).colorScheme.onTertiary),
                        decoration: InputDecoration(
                            hintText: "Email Address".tr,
                            hintStyle: TextStyle(
                                color: Theme.of(Get.context!).colorScheme.error,
                                fontSize: getNormalTextFontSIze()),
                            border: InputBorder.none),
                      ),
                    )),
                SizedBox(
                  height: 2.h,
                ),
              ],
            ),
          ),
          Obx(() => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Gender".tr,
                    style: TextStyle(
                        fontSize: 20,
                        color: Theme.of(context).colorScheme.onTertiary),
                    textAlign: TextAlign.center,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomRadio(
                        value: "male",
                        groupValue: controller.gender.value,
                        onChanged: (value) {
                          controller.gender.value = value;
                        },
                        text: 'Male'.tr,
                      ),
                      CustomRadio(
                        value: "female",
                        groupValue: controller.gender.value,
                        onChanged: (value) {
                          setState(() {
                            controller.gender.value = value;
                          });
                        },
                        text: 'Female'.tr,
                      ),
                    ],
                  ),
                ],
              )),
          SizedBox(
            height: 2.h,
          ),
          GestureDetector(
              onTap: () {
                if(controller.fullName.value.text.isEmpty){
                  BaseOverlays().showSnackBar(message:"Full Name is Required".tr, title: "Error".tr);
                }else if(controller.mobileNo.value.text.isEmpty){
                  BaseOverlays().showSnackBar(message:"Mobile No is Required".tr, title: "Error".tr);
                }else if(controller.email.value.text.isEmpty){
                  BaseOverlays().showSnackBar(message:"Email is Required".tr, title: "Error".tr);
                }else{
                  controller.updateProfile();
                }
              },
              child: BorderedButton(
                width: 1,
                text: "SAVE".tr,
                isReversed: true,
              )),
        ],
      ),
    );
  }
}

class CustomRadio extends StatelessWidget {
  final String value;
  final String groupValue;
  final ValueChanged<String> onChanged;
  final String text;

  CustomRadio({
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChanged(value),
      child: Row(
        children: [
          Radio<String>(
            value: value,
            groupValue: groupValue,
            onChanged: (value) {
              onChanged(value!);
            },
            splashRadius: 20.0,
            fillColor: MaterialStateProperty.all(ColorConstants.primaryColor),
          ),
          Text(
            text,
            style:
                TextStyle(color: Theme.of(Get.context!).colorScheme.onTertiary),
          ),
        ],
      ),
    );
  }
}
