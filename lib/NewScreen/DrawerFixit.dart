import 'package:fixit/ui_screens/bottomSubPages/controller/profile_controller.dart';
import 'package:fixit/ui_screens/profileSubPage/aboutUs.dart';
import 'package:fixit/ui_screens/profileSubPage/privacy_policy.dart';
import 'package:fixit/ui_screens/profileSubPage/termCondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Routes/app_routes.dart';
import '../backend/base_api.dart';
import '../common/base_image_network.dart';
import '../common/base_overlays.dart';
import '../common/color_constants.dart';
import '../common/utils.dart';
import '../storage/base_shared_preference.dart';
import '../ui_screens/bottomSubPages/edit_profile.dart';
import '../ui_screens/bottomSubPages/my_profile.dart';
import '../ui_screens/bottomSubPages/settings.dart';
import '../ui_screens/locations/controller/location_controller.dart';
import '../ui_screens/locations/manage_address.dart';
import '../ui_screens/service/chat_screen.dart';
import 'AppTextFile.dart';
import 'NewAddAddress.dart';
import 'NewHome.dart';

class DrawerFixitScreen extends StatefulWidget {
  const DrawerFixitScreen({super.key});

  @override
  State<DrawerFixitScreen> createState() => _DrawerFixitScreenState();
}

class _DrawerFixitScreenState extends State<DrawerFixitScreen> {
  ProfileController controller=Get.find<ProfileController>();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      child: Container(
        color: ColorConstants.fixitGreenDark,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              padding: EdgeInsets.only(left: 12.sp, right: 20.sp),
              height: 18.h,
              margin: EdgeInsets.zero,
              decoration: const BoxDecoration(
                color: ColorConstants.fixitGreenDark,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 5.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SvgPicture.asset('assets/images/OnlyFitixLogo.svg'),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: ColorConstants.headerTextDark),
                          child: const Center(
                              child: Icon(
                            Icons.close_rounded,
                            color: ColorConstants.fixitGreenToDark,
                          )),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                   Text(
                    'Menu'.tr,
                    style: const TextStyle(
                        color: ColorConstants.headerTextDark,
                        fontSize: 28,
                        fontFamily: 'Aeonik',
                        fontWeight: FontWeight.w700
                    ),
                  ),
                ],
              ),
            ),
           Obx(()=> Container(
              margin: EdgeInsets.only(left: 12.sp, right: 15.sp),
              decoration: BoxDecoration(
                  color: ColorConstants.fixitText,
                  borderRadius: getBorderRadius13()),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap:(){
                          //  Get.to(()=>const MyProfile());
                          },
                          child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(150.0),
                            ),
                            child: BaseImageNetwork(
                              fit: BoxFit.cover,
                              borderRadius: 150,
                              link: controller.data.value.image ?? "",
                              concatBaseUrl: false,
                              errorWidget: Image.asset(
                                "assets/images/profile.png",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 1.5.w,
                        ),
                         Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width:200,
                              child: AppTexts.aeonikText16W500(
                                controller.data.value.name??"",
                                overflow: TextOverflow.ellipsis,
                                fontSize: 17,
                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                Get.to(const EditProfile())?.then((value) {
                                  controller.getProfile();
                                });
                              },
                              child: Column(
                                children: [
                                   AppTexts.aeonikText16W500(
                                    'Edit Profile'.tr,
                                    fontSize: 14,
                                    style: TextStyle(
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                  Container(
                                    width: 78,
                                    height: 1,
                                    color: ColorConstants.black,
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),

                  ],
                ),
              ),
            )),
            SizedBox(
              height: 1.h,
            ),
            drawerListTile('assets/images/cardLocationLogo.svg', 'Manage Address', context, const ManageAddress(page: '',),),
            drawerListTile('assets/images/settingDrawer.svg', 'Settings', context, const Settings()),
            drawerListTile('assets/images/privacyDrawer.svg', 'Privacy Policy', context,const PrivacyPolicy()),
            drawerListTile('assets/images/termsDrawer.svg', 'Terms & Conditions', context,const TermsConditions()),
            drawerListTile('assets/images/aboutDrawer.svg', 'About Us', context,const AboutUs()),
         //   drawerListTile('assets/images/helpDrawer.svg', 'Help Center', context, const ChatScreen()),
            Container(
              margin: EdgeInsets.only(
                left: 18.sp,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 4.h,
                  ),
               AppTexts.aeonikText16W400(
                'Follow us:'.tr,
                textColor: ColorConstants.fixitText,
              ),
                  SizedBox(
                    height: 2.h,
                  ),
                  GestureDetector(
                    onTap: () async {
                      final Uri googleUrl = Uri.parse('https://www.instagram.com/fixit.iq?igsh=dWw3YndoaWZ4c3U1');
                      if (await canLaunchUrl(googleUrl)) {
                      await launchUrl(googleUrl);
                      } else {
                      throw 'Could not launch $googleUrl';
                      }
                    },
                    child: Padding(
                      padding: EdgeInsets.only(right: 18.sp),
                      child: SvgPicture.asset(
                        'assets/images/instagram.svg',
                        width: 18,
                        height: 18,
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 6.h,
            ),
            GestureDetector(
              onTap: (){
                logout();
              },
              child: ListTile(
                leading: SvgPicture.asset(
                  'assets/images/logOutDrawer.svg',
                  width: 24,
                  height: 24,
                  color: ColorConstants.headerTextDark,
                  fit: BoxFit.scaleDown,
                ),
                title:  AppTexts.aeonikText16W400(
                  'LOG OUT'.tr,
                  textColor: ColorConstants.fixitText,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget drawerListTile(String svgAsset, String title, BuildContext context, Widget route) {
    return Column(
      children: [
        ListTile(
          trailing: const Icon(
            Icons.arrow_forward_ios_rounded,
            color: ColorConstants.headerTextDark,
            size: 18,
          ),
          tileColor: ColorConstants.fixitGreenDark,
          leading: SvgPicture.asset(
            svgAsset,
            width: 24,
            height: 24,
            color: ColorConstants.headerTextDark,
            fit: BoxFit.scaleDown,
          ),
          title: AppTexts.aeonikText16W400(
            title.tr  ,
            textColor: ColorConstants.fixitText,
          ),
          onTap: () {
            if (route is AddAddress) {
              Get.put(LocationController());
            }
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => route),
            );
          },
        ),
        const Divider(
          color: ColorConstants.fixitText,
          thickness: 1,
          height: 1,
        ),
      ],
    );
  }

  logout() async {
    GoogleSignIn _googleSignIn = GoogleSignIn();
    await BaseAPI().get(url: 'user/logout').then((value) async {
      if (value?.statusCode == 200) {
         await _googleSignIn.signOut();
        BaseOverlays().showSnackBar(message: "LogOut Successfully".tr, title: "Success");
        Get.offAllNamed(Routes.loginScreen);
        BaseSharedPreference().clearLoginSession();
      } else {
        BaseOverlays().showSnackBar(message: "Something Went Wrong!!!".tr, title: "Error");
      }
    });
  }
}

class SocialMediaIconsRow extends StatelessWidget {
  final List<String> iconPaths = [
    'assets/images/instagram.svg'
  ];


  @override
  Widget build(BuildContext context) {
    return Row(
      children: iconPaths.map((path) => Padding(
                padding: EdgeInsets.only(right: 18.sp),
                child: SvgPicture.asset(
                  path,
                  width: 18,
                  height: 18,
                  fit: BoxFit.scaleDown,
                ),
              ))
          .toList(),
    );
  }
}
