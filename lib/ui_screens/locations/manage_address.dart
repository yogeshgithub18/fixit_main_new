import 'package:fixit/ui_screens/auth/controller/login_controller.dart';
import 'package:fixit/ui_screens/locations/add_location.dart';
import 'package:fixit/ui_screens/locations/controller/location_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../NewScreen/AppTextFile.dart';
import '../../NewScreen/NewAppBar.dart';
import '../../NewScreen/NewHome.dart';
import '../../Routes/app_routes.dart';
import '../../common/bordered_button.dart';
import '../../common/color_constants.dart';
import '../../common/utils.dart';
import '../app_header.dart';

class ManageAddress extends StatefulWidget {
  final String page;

  const ManageAddress({super.key, required this.page});

  @override
  State<ManageAddress> createState() => _ManageAddressState();
}

class _ManageAddressState extends State<ManageAddress> {
  LocationController controller = Get.put(LocationController());

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(7.h),
            child: NewAppHeader(
              title: 'FIXIT',
              showBackIcon: widget.page != "Login",
            )),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 1.h,
              ),
              Obx(() => ListView.builder(
                physics: ScrollPhysics(),
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        controller.activateLocations(controller.locationDataList[index].id);
                      },
                      child:  Container(
                        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primaryContainer,
                          borderRadius: getBorderRadius13(),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: (){

                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SvgPicture.asset('assets/images/cardLocationLogo.svg'),
                                  GestureDetector(
                                    onTap: (){
                                      controller.deleteLocations(
                                          controller
                                              .locationDataList[
                                          index]
                                              .id);
                                    },
                                    child: Row(
                                      children: [
                                        SvgPicture.asset('assets/images/delete.svg'),
                                        const SizedBox(width: 5),
                                         AppTexts.aeonikText13W400(
                                          'DELETE'.tr,
                                          textColor: ColorConstants.fixitRed,
                                          fontWeight: FontWeight.w500,
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 1.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AppTexts.helveticaText16W500(
                                  'Home Address'.tr,
                                  textColor:Theme.of(context).colorScheme.onTertiary,
                                ),
                                Icon(
                                  controller.locationDataList[index]
                                      .status ==
                                      1
                                      ? Icons
                                      .radio_button_checked_outlined
                                      :
                                  Icons
                                      .radio_button_unchecked_outlined,
                                  color: ColorConstants.primaryColor,
                                ),
                              ],
                            ),
                            SizedBox(height: 1.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                 Expanded(
                                   child: Text(
                                    '${controller.locationDataList[index].streetNo}, ${controller.locationDataList[index].streetName}, ${controller.locationDataList[index].city}${controller.locationDataList[index].location!=null?",${controller.locationDataList[index].location}":''}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: ColorConstants.primaryColor,
                                      fontFamily: 'Helvetica Neue',
                                    ),
                                                                 ),
                                 ),
                                GestureDetector(
                                    onTap: () {
                                      Get.put(
                                          LocationController());
                                      Get.to(() => AddLocation(
                                        latitude: controller
                                            .locationDataList[
                                        index]
                                            .latitude,
                                        longitude: controller
                                            .locationDataList[
                                        index]
                                            .longitude,
                                        locationId: controller
                                            .locationDataList[
                                        index]
                                            .id,
                                        isEditLocation: true,
                                        streetNo: controller
                                            .locationDataList[
                                        index]
                                            .streetNo,
                                        streetName: controller
                                            .locationDataList[
                                        index]
                                            .streetName,
                                        pincode: controller
                                            .locationDataList[
                                        index]
                                            .pincode,
                                        city: controller
                                            .locationDataList[
                                        index]
                                            .city,
                                        country: controller
                                            .locationDataList[
                                        index]
                                            .country,
                                        location: controller
                                            .locationDataList[
                                        index]
                                            .location,
                                      ));
                                    },
                                    child:  Text.rich(
                                      TextSpan(
                                        text: 'EDIT'.tr,
                                        style: TextStyle(
                                          color:Theme.of(context).colorScheme.onTertiary,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'Aeonik',
                                          fontSize: 16,
                                          decoration: TextDecoration.underline,
                                          decorationColor: Theme.of(context).colorScheme.onTertiary,
                                          decorationThickness: 1.5,
                                        ),
                                      ),
                                      style: TextStyle(
                                        height: 2,
                                      ),
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    itemCount: controller.locationDataList.length,
                    shrinkWrap: true,
                  )),
              GestureDetector(
                onTap: () {
                  Get.to(AddLocation());
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  width: double.infinity,
                  height: 130,
                  decoration: BoxDecoration(
                    borderRadius: getBorderRadius13(),
                    color:Theme.of(context).colorScheme.primaryContainer,
                  ),
                  child:  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add_circle_outline_rounded,
                        color:Theme.of(context).colorScheme.onTertiary,
                        size: 30,
                      ),
                      AppTexts.helveticaText16W500(
                        'Add New Address'.tr,
                        textColor:Theme.of(context).colorScheme.onTertiary,
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Obx(() => controller.locationDataList.isNotEmpty
                  ? GestureDetector(
                      onTap: () {
                        Get.put(LoginController());
                        for (var location in controller.locationDataList) {
                          if (location.status == 1) {
                            Get.find<LoginController>().activeAddress.value =
                                "${location.streetNo}, ${location.streetName}, ${location.location}";
                          }
                        }
                        print(
                            "address---${Get.find<LoginController>().activeAddress.value}");
                        if (widget.page == "Login") {
                          Get.offAll( const FixitHomeScreen());
                        } else {
                          Get.back();
                        }
                      },
                      child: BorderedButton(
                        width: double.infinity,
                        text: "DONE".tr,
                        isReversed: true,
                      ))
                  : const SizedBox()),
              SizedBox(
                height: 2.h,
              ),
            ],
          ),
        ));
  }

  void getData() async {
     await controller.getUserLocations();
  }
}

class CustomRadio extends StatelessWidget {
  final int value;
  final int groupValue;
  final ValueChanged<int> onChanged;
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
      onTap: () {
        onChanged(value);
      },
      child: Row(
        children: [
          Radio<int>(
            value: value,
            groupValue: groupValue,
            onChanged: (value) {
              onChanged(value!);
            },
            splashRadius: 10.0,
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

// class addressCard extends StatelessWidget {
//   const addressCard({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return
//       Container(
//       margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
//       width: double.infinity,
//       padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
//       decoration: BoxDecoration(
//         color: Theme.of(context).colorScheme.primaryContainer,
//         borderRadius: getBorderRadius13(),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           GestureDetector(
//             onTap: (){
//
//             },
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 SvgPicture.asset('assets/images/cardLocationLogo.svg'),
//                 GestureDetector(
//                   onTap: (){
//                     controller.deleteLocations(
//                         controller
//                             .locationDataList[
//                         index]
//                             .id);
//                   },
//                   child: Row(
//                     children: [
//                       SvgPicture.asset('assets/images/delete.svg'),
//                       const SizedBox(width: 5),
//                       const AppTexts.aeonikText13W400(
//                         'DELETE',
//                         textColor: ColorConstants.fixitRed,
//                         fontWeight: FontWeight.w500,
//                       )
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(height: 1.h),
//            Row(
//              mainAxisAlignment: MainAxisAlignment.spaceBetween,
//              children: [
//                AppTexts.helveticaText16W500(
//                 'Home Address',
//                 textColor:Theme.of(context).colorScheme.onTertiary,
//                          ),
//                Icon(
//                  controller.locationDataList[index]
//                      .status ==
//                      1
//                      ? Icons
//                      .radio_button_checked_outlined
//                      :
//                  Icons
//                      .radio_button_unchecked_outlined,
//                  color: ColorConstants.primaryColor,
//                ),
//              ],
//            ),
//           SizedBox(height: 1.h),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: [
//               const Text(
//                 '${controller.locationDataList[index].streetNo}, ${controller.locationDataList[index].streetName}, ${controller.locationDataList[index].location}',
//                 style: TextStyle(
//                   fontSize: 16,
//                   color: ColorConstants.primaryColor,
//                   fontFamily: 'Helvetica Neue',
//                 ),
//               ),
//               GestureDetector(
//                   onTap: () {
//                     Get.put(
//                         LocationController());
//                     Get.to(() => AddLocation(
//                       latitude: controller
//                           .locationDataList[
//                       index]
//                           .latitude,
//                       longitude: controller
//                           .locationDataList[
//                       index]
//                           .longitude,
//                       locationId: controller
//                           .locationDataList[
//                       index]
//                           .id,
//                       isEditLocation: true,
//                       streetNo: controller
//                           .locationDataList[
//                       index]
//                           .streetNo,
//                       streetName: controller
//                           .locationDataList[
//                       index]
//                           .streetName,
//                       pincode: controller
//                           .locationDataList[
//                       index]
//                           .pincode,
//                       city: controller
//                           .locationDataList[
//                       index]
//                           .city,
//                       country: controller
//                           .locationDataList[
//                       index]
//                           .country,
//                       location: controller
//                           .locationDataList[
//                       index]
//                           .location,
//                     ));
//                   },
//                   child:  Text.rich(
//                     TextSpan(
//                       text: 'EDIT',
//                       style: TextStyle(
//                         color:Theme.of(context).colorScheme.onTertiary,
//                         fontWeight: FontWeight.w500,
//                         fontFamily: 'Aeonik',
//                         fontSize: 16,
//                         decoration: TextDecoration.underline,
//                         decorationColor: Theme.of(context).colorScheme.onTertiary,
//                         decorationThickness: 1.5,
//                       ),
//                     ),
//                     style: TextStyle(
//                       height: 2,
//                     ),
//                   )),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
