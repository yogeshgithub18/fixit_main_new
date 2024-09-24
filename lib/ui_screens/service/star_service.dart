import 'package:fixit/ui_screens/locations/manage_address.dart';
import 'package:fixit/ui_screens/service/controller/start_service_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import '../../../backend/modal/location_data_model.dart' as loc;
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../NewScreen/AppTextFile.dart';
import '../../common/base_image_network.dart';
import '../../common/base_overlays.dart';
import '../../common/bordered_button.dart';
import '../../common/color_constants.dart';
import '../../common/utils.dart';
import '../app_header.dart';

class StartService extends StatefulWidget {
  final int id;
  final int subId;
  final String catName;
  final String subCatName;
  final String image;
  final String price;
  const StartService({Key? key,required this.price, required this.id,required this.subId,required this.catName,required this.subCatName,required this.image}) : super(key: key);

  @override
  State<StartService> createState() => _StartServiceState();
}

class _StartServiceState extends State<StartService> {
  double  ?lat;
  double  ?long;
  late Marker marker;
  StartServiceController controller = Get.put(StartServiceController());
  late GoogleMapController mapController;
  @override
  void initState() {
    // TODO: implement initState
    controller.dateCtrl.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
    controller.fromTimeCtrl.text = DateFormat('hh:mm a').format(DateTime.now());
    controller.toTimeCtrl.text = DateFormat('hh:mm a').format(DateTime.now().add(const Duration(hours: 1)));
    super.initState();
    getData();
  }

  void getData() async {
    await controller.getUserLocations();
    controller.lat.value=0.0;
    for (int i = 0; controller.locationDataList.length>i; i++) {
      if (controller.locationDataList[i].status == 1) {
        controller.activeAddress.value = "${controller.locationDataList[i].streetNo},${controller.locationDataList[i].streetName},${controller.locationDataList[i].location}";
        controller.lat.value=double.parse(controller.locationDataList[i].latitude!);
        controller.long.value=double.parse(controller.locationDataList[i].longitude!);
        print("--changed--->${controller.long.value}");
        marker = Marker(
          markerId: const MarkerId('YourMarkerID'),
          position: LatLng(controller.lat.value, controller.long.value),
          infoWindow: const InfoWindow(
            title: 'Marker', // Add your title
            snippet: 'Marker', // Add your snippet
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // appBar: AppBar(backgroundColor: Theme.of(context).scaffoldBackgroundColor,automaticallyImplyLeading: false,),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 5.h,),
                Row(
                 mainAxisAlignment: MainAxisAlignment.start,
                 crossAxisAlignment: CrossAxisAlignment.center,
                 children: [
                   SizedBox(width: 10,),
                   GestureDetector(
                   onTap: (){
                    Get.back();
                   },
                     child: const Icon(Icons.cancel,color: ColorConstants.primaryColor,size:40)),
                   Padding(
                     padding: const EdgeInsets.only(right:8,left: 8),
                     child:  Container(
                       clipBehavior: Clip.antiAliasWithSaveLayer,
                       height: 8.h,
                       width: 10.w,
                       padding: EdgeInsets.all(2.sp),
                       decoration: const BoxDecoration(
                         shape: BoxShape.circle,
                         // color: ColorConstants.scaffoldDark,
                       ),
                       child: BaseImageNetwork(
                         link:widget.image ?? '',
                         fit: BoxFit.cover,
                         concatBaseUrl: false,
                         errorWidget: Image.asset(
                           "assets/images/profile.png",
                           fit: BoxFit.cover,
                         ),
                       ),
                     ),
                   ),
                   Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       AppTexts.helveticaText16W500(
                         widget.catName,
                         textColor: Theme.of(context).colorScheme.tertiary,
                       ),
                       SizedBox(
                         width: 60.w,
                         height: 3.h,
                         child:  AppTexts.helveticaText16W400(
                           widget.subCatName,
                           overflow: TextOverflow.ellipsis,
                           maxLines: 2,
                           textColor: ColorConstants.primaryColor,
                         ),
                       ),
                     ],
                   ),
               ],),
                 Obx(() => Stack(
                  children: [
                 SizedBox(
                  width: 100.w,
                  height: 30.h,
                 child:controller.locationDataList.isNotEmpty && controller.lat.value!=0.0?GoogleMap(
                   onMapCreated: (controller) {
                     mapController = controller;
                   },
                   initialCameraPosition: CameraPosition(
                     target: LatLng(controller.lat.value, controller.long.value),
                     zoom: 15.0, // You can adjust the initial zoom level
                   ),
                   markers: Set<Marker>.of([marker]), // Add the marker to the map
                 ): Center(child: Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     CircularProgressIndicator(),
                     SizedBox(height: 2.h,),
                     Text("No address found..")
                   ],
                 ),
                 // child: MapScreen(latitude:controller.lat.value, longitude:controller.long.value),
                )),
                  Positioned(
                    bottom: 20.sp,
                    left: 20.sp,
                    right: 20.sp,
                    child: Center(
                      child: Container(
                          height: 5.h,
                          width: 90.w,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(left: 15.sp,right: 10.sp),
                            child: Row(
                              children: [
                                Obx(() => SizedBox(
                                      width:60.w,
                                      child: Text(
                                        controller.locationDataList.isNotEmpty && controller.lat.value!=0.0? controller.activeAddress.value:"Please add address",
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(color: ColorConstants.white),
                                      ),
                                    ),
                                ),
                                SizedBox(
                                  width:2.w,
                                ),
                                GestureDetector(
                                  onTap: () async{
                                   await Get.to(() => const ManageAddress(page: "Profile"))?.then((value){
                                     getData();
                                   });
                                  },
                                  child: Text("Change".tr,
                                      style: const TextStyle(
                                          color: ColorConstants.white)),
                                ),
                              ],
                            ),
                          )),
                    )),
                  ])),
                 Obx(() => Padding(
                   padding: EdgeInsets.symmetric(horizontal: 15.sp,vertical: 2.h),
                   child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primaryContainer,
                           borderRadius: getBorderRadius(),
                           ),
                            child: RadioListTile(
                              dense: true,
                              activeColor: Theme.of(context).colorScheme.primary,
                              title:  Text('Book Now'.tr),
                              value: true,
                              groupValue: controller.selectedOption.value,
                              onChanged: (value) {
                                controller.selectedOption.value = !controller.selectedOption.value;
                              },
                            ),
                          ),
                        ),
                        SizedBox(width: 2.w,),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primaryContainer,
                              borderRadius: getBorderRadius(),
                            ),
                            child: RadioListTile(
                              dense: true,
                              activeColor: Theme.of(context).colorScheme.primary,
                              title:  Text('Schedule'.tr),
                              value: false,
                              groupValue: controller.selectedOption.value,
                              onChanged: (value) {
                                controller.selectedOption.value = !controller.selectedOption.value;
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                 )),
              Obx(() => Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.sp),
                    child: Column(
                      children: [
                        Visibility(
                            visible: controller.selectedOption.value == false,
                            child:  Text(
                                "Select the Date & time slot for serive provider to reach you on".tr)),
                        SizedBox(
                          height: 1.h,
                        ),
                        Visibility(
                          visible: controller.selectedOption.value == false,
                          child: Container(
                            padding: EdgeInsets.only(left: 15.sp,right: 15.sp),
                            decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .primaryContainer,
                                borderRadius: BorderRadius.circular(10)),
                            child: TextFormField(
                              controller: controller.dateCtrl,
                              onTap: () {
                                showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime.now()
                                            .add(const Duration(days: 30)))
                                    .then((value) {
                                  print(value);
                                  if (value != null) {
                                    String pickedDate = DateFormat('dd/MM/yyyy').format(value);
                                    controller.dateCtrl.text = pickedDate;
                                    controller.dateCheck = value;
                                    controller.update();
                                  }
                                });
                              },
                              keyboardType: TextInputType.text,
                              readOnly: true,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  suffixIcon: Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    color: Theme.of(Get.context!)
                                        .colorScheme
                                        .error,
                                  ),
                                  hintText: 'Select Date'.tr,
                                  hintStyle: TextStyle(
                                      color: Theme.of(Get.context!)
                                          .colorScheme
                                          .error,
                                      fontWeight: FontWeight.w300)),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Visibility(
                          visible: controller.selectedOption.value == false,
                          child:Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("From Time".tr),
                                    SizedBox(height: 1.h),
                                    Container(
                                      padding: EdgeInsets.only(left: 20.sp, right: 20.sp),
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).colorScheme.primaryContainer,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: TextFormField(
                                        controller: controller.fromTimeCtrl,
                                        onTap: () {
                                          showTimePicker(
                                            context: context,
                                            initialTime: TimeOfDay.now(),
                                          ).then((value) {
                                            if (value != null) {
                                              final utcTime = DateTime(0, 1, 1, value.hour, value.minute).toUtc();
                                              var selectedTime = TimeOfDay.fromDateTime(utcTime.toLocal());
                                              DateTime now = DateTime.now();
                                              TimeOfDay nowTime = TimeOfDay.now();
                                              if (now.isBefore(DateTime(controller.dateCheck.year, controller.dateCheck.month, controller.dateCheck.day, value.hour, value.minute))) {
                                                TimeOfDay fromTime = selectedTime;
                                                if (controller.toTimeCtrl.text.isNotEmpty) {
                                                  List<String> timeParts = controller.toTimeCtrl.text.split(' ');
                                                  List<String> hourMinuteParts = timeParts[0].split(':');
                                                  int hour = int.parse(hourMinuteParts[0]);
                                                  int minute = int.parse(hourMinuteParts[1]);
                                                  String ampm = timeParts[1].toUpperCase();
                                                  if (ampm == 'PM' && hour < 12) {
                                                    hour += 12;
                                                  } else if (ampm == 'AM' && hour == 12) {
                                                    hour = 0;
                                                  }
                                                  TimeOfDay toTime = TimeOfDay(hour: hour, minute: minute);
                                                  if (fromTime.hour >= toTime.hour && fromTime.minute > toTime.minute) {
                                                    BaseOverlays().showSnackBar(message: "From Time cannot be after To Time".tr, title: "Error".tr);
                                                    return;
                                                  }
                                                }
                                                controller.fromTimeCtrl.text = fromTime.format(context);
                                              } else {
                                                TimeOfDay fromTime = nowTime;
                                                controller.fromTimeCtrl.text = fromTime.format(context);
                                                BaseOverlays().showSnackBar(message: "Invalid Time".tr, title: "Error".tr);
                                              }
                                            }
                                            controller.update();
                                          });
                                        },
                                        keyboardType: TextInputType.text,
                                        readOnly: true,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          suffixIcon: Icon(
                                            Icons.keyboard_arrow_down_rounded,
                                            color: Theme.of(Get.context!).colorScheme.error,
                                          ),
                                          hintText: 'From Time'.tr,
                                          hintStyle: TextStyle(
                                            color: Theme.of(Get.context!).colorScheme.error,
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 1.w),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("To Time".tr),
                                      SizedBox(height: 1.h),
                                      Container(
                                        padding: EdgeInsets.only(left: 20.sp, right: 20.sp),
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).colorScheme.primaryContainer,
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: TextFormField(
                                          controller: controller.toTimeCtrl,
                                          onTap: () {
                                            showTimePicker(
                                              context: context,
                                              initialTime: TimeOfDay.now(),
                                            ).then((value) {
                                              if (value != null) {
                                                final utcTime = DateTime(0, 1, 1, value.hour, value.minute).toUtc();
                                                var selectedTime = TimeOfDay.fromDateTime(utcTime.toLocal());
                                                DateTime now = DateTime.now();
                                                TimeOfDay nowTime = TimeOfDay.now();
                                                if (now.isBefore(DateTime(controller.dateCheck.year, controller.dateCheck.month, controller.dateCheck.day, value.hour, value.minute))) {
                                                  TimeOfDay toTime = selectedTime;
                                                  if (controller.fromTimeCtrl.text.isNotEmpty) {
                                                    List<String> fromTimeParts = controller.fromTimeCtrl.text.split(' ');
                                                    List<String> fromHourMinuteParts = fromTimeParts[0].split(':');
                                                    int fromHour = int.parse(fromHourMinuteParts[0]);
                                                    int fromMinute = int.parse(fromHourMinuteParts[1]);
                                                    String fromAmPm = fromTimeParts[1].toUpperCase();
                                                    if (fromAmPm == 'PM' && fromHour < 12) {
                                                      fromHour += 12;
                                                    } else if (fromAmPm == 'AM' && fromHour == 12) {
                                                      fromHour = 0;
                                                    }
                                                    TimeOfDay fromTime = TimeOfDay(hour: fromHour, minute: fromMinute);
                                                    if (toTime.hour < fromTime.hour || (toTime.hour == fromTime.hour && toTime.minute < fromTime.minute)) {
                                                      BaseOverlays().showSnackBar(message: "To Time cannot be before From Time".tr, title: "Error".tr);
                                                      return;
                                                    }
                                                  }
                                                  controller.toTimeCtrl.text = toTime.format(context);
                                                } else {
                                                  TimeOfDay toTime = nowTime;
                                                  controller.toTimeCtrl.text = DateFormat('hh:mm a').format(DateTime.now().add(const Duration(hours: 1)));
                                                  BaseOverlays().showSnackBar(message: "Invalid Time".tr, title: "Error".tr);
                                                }
                                              }
                                              controller.update();
                                            });
                                          },
                                          keyboardType: TextInputType.text,
                                          readOnly: true,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            suffixIcon: Icon(
                                              Icons.keyboard_arrow_down_rounded,
                                              color: Theme.of(Get.context!).colorScheme.error,
                                            ),
                                            hintText: 'To Time'.tr,
                                            hintStyle: TextStyle(
                                              color: Theme.of(Get.context!).colorScheme.error,
                                              fontWeight: FontWeight.w300,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                          // Row(
                          //   children: [
                          //     Expanded(
                          //       child: Column(
                          //         crossAxisAlignment:
                          //             CrossAxisAlignment.start,
                          //         children: [
                          //            Text("From Time".tr),
                          //           SizedBox(
                          //             height: 1.h,
                          //           ),
                          //           Container(
                          //             padding: EdgeInsets.only(left: 20.sp,right: 20.sp),
                          //             decoration: BoxDecoration(
                          //                 color: Theme.of(context)
                          //                     .colorScheme
                          //                     .primaryContainer,
                          //                 borderRadius:
                          //                     BorderRadius.circular(10)),
                          //             child: TextFormField(
                          //               controller: controller.fromTimeCtrl,
                          //               onTap: () {
                          //                 showTimePicker(
                          //                         context: context,
                          //                         initialTime: TimeOfDay.now())
                          //                     .then((value) {
                          //                   print(value);
                          //                   if (value != null) {
                          //                     final utcTime = DateTime(0, 1, 1, value.hour, value.minute).toUtc();
                          //                     var selectedTime = TimeOfDay.fromDateTime(utcTime.toLocal());
                          //                     print('Time.... ${selectedTime}');
                          //                     DateTime now = DateTime.now();
                          //                     TimeOfDay nowTime = TimeOfDay.now();
                          //                     if(now.isBefore(DateTime(controller.dateCheck.year, controller.dateCheck.month, controller.dateCheck.day, value.hour, value.minute))){
                          //                       TimeOfDay fromtime = selectedTime;
                          //                       controller.fromTimeCtrl.text =
                          //                           fromtime.format(context);
                          //                     }else{
                          //                       TimeOfDay fromtime = nowTime;
                          //                       controller.fromTimeCtrl.text = fromtime.format(context);
                          //                       BaseOverlays().showSnackBar(
                          //                           message:"Invalid Time".tr, title: "Error".tr);
                          //                     }
                          //                   }
                          //                   controller.update();
                          //                 });
                          //               },
                          //               keyboardType: TextInputType.text,
                          //               readOnly: true,
                          //               decoration: InputDecoration(
                          //                   border: InputBorder.none,
                          //                   suffixIcon: Icon(
                          //                     Icons
                          //                         .keyboard_arrow_down_rounded,
                          //                     color: Theme.of(Get.context!)
                          //                         .colorScheme
                          //                         .error,
                          //                   ),
                          //                   hintText: 'From Time'.tr,
                          //                   hintStyle: TextStyle(
                          //                       color: Theme.of(Get.context!)
                          //                           .colorScheme
                          //                           .error,
                          //                       fontWeight: FontWeight.w300)),
                          //             ),
                          //           ),
                          //         ],
                          //       ),
                          //     ),
                          //     SizedBox(width: 1.w,),
                          //     Expanded(
                          //       child: Padding(
                          //         padding: const EdgeInsets.symmetric(
                          //             horizontal: 5, vertical: 5),
                          //         child: Column(
                          //           crossAxisAlignment:
                          //               CrossAxisAlignment.start,
                          //           children: [
                          //              Text("To Time".tr),
                          //             SizedBox(
                          //               height: 1.h,
                          //             ),
                          //             Container(
                          //               padding: EdgeInsets.only(left: 20.sp,right: 20.sp),
                          //               decoration: BoxDecoration(
                          //                   color: Theme.of(context)
                          //                       .colorScheme
                          //                       .primaryContainer,
                          //                   borderRadius:
                          //                       BorderRadius.circular(10)),
                          //               child: TextFormField(
                          //                 controller: controller.toTimeCtrl,
                          //                 onTap: () {
                          //                   showTimePicker(
                          //                           context: context,
                          //                           initialTime:
                          //                               TimeOfDay.now())
                          //                       .then((value) {
                          //
                          //                     print(value);
                          //                     if (value != null) {
                          //                       // Convert the picked time to UTC time
                          //                       final utcTime = DateTime(0, 1, 1, value.hour, value.minute).toUtc();
                          //                       var selectedTime = TimeOfDay.fromDateTime(utcTime.toLocal());
                          //                       print('Time.... ${selectedTime}');
                          //                       DateTime now = DateTime.now();
                          //                       TimeOfDay nowTime = TimeOfDay.now();
                          //                       if(now.isBefore(DateTime(controller.dateCheck.year, controller.dateCheck.month, controller.dateCheck.day, value.hour, value.minute))){
                          //                         TimeOfDay totime = selectedTime;
                          //                         controller.toTimeCtrl.text =
                          //                             totime.format(context);
                          //                       }else{
                          //                         TimeOfDay totime = nowTime;
                          //                         controller.fromTimeCtrl.text = totime.format(context);
                          //                         BaseOverlays().showSnackBar(
                          //                             message:"Invalid Time".tr, title: "Error".tr);
                          //                       }
                          //                     }
                          //                     controller.update();
                          //                   });
                          //                 },
                          //                 keyboardType: TextInputType.text,
                          //                 readOnly: true,
                          //                 decoration: InputDecoration(
                          //                     border: InputBorder.none,
                          //                     suffixIcon: Icon(
                          //                       Icons
                          //                           .keyboard_arrow_down_rounded,
                          //                       color: Theme.of(Get.context!)
                          //                           .colorScheme
                          //                           .error,
                          //                     ),
                          //                     hintText: 'To Time'.tr,
                          //                     hintStyle: TextStyle(
                          //                         color: Theme.of(Get.context!)
                          //                             .colorScheme
                          //                             .error,
                          //                         fontWeight: FontWeight.w300)),
                          //               ),
                          //             ),
                          //           ],
                          //         ),
                          //       ),
                          //     ),
                          //   ],
                          // ),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 15.sp,right: 15.sp,top: 10),
                          decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
                              borderRadius: BorderRadius.circular(10)),
                          child: TextFormField(
                            controller: controller.descriptionCtrl,
                            keyboardType: TextInputType.text,
                            // readOnly: true,
                            maxLines: 3,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Description'.tr,
                                hintStyle: TextStyle(
                                    color: Theme.of(Get.context!)
                                        .colorScheme
                                        .error,
                                    fontWeight: FontWeight.w300)),
                          ),
                        ),
                        if (!controller.isFillDescription.value)
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5.0),
                            child: Text(
                              "Fill the description before proceeding the request".tr,
                              style: const TextStyle(color: Colors.red, fontSize: 12),
                            ),
                          )
                      ],
                    ),
                  )),
              SizedBox(
                height: 2.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.sp,right:15.sp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 1.5.h,),
                      decoration: BoxDecoration(
                          color:Theme.of(context).colorScheme.primaryContainer,
                          border: Border.all(color: Theme.of(context).colorScheme.primaryContainer,width: 1.5),
                          borderRadius:getCustomBorderRadius(13)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            addText("Order Price", getSubheadingTextFontSIze(), ColorConstants.primaryColor,FontWeight.w500,fontFamily: 'Aeonik'),
                            addText("${widget.price?? 0} IQD", getSubheadingTextFontSIze(), ColorConstants.primaryColor,FontWeight.w500,fontFamily: 'Aeonik'),

                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 2.w,),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          if (controller.descriptionCtrl.text.isNotEmpty) {
                            controller.createServiceRequest(widget.id,widget.subId);
                          } else {
                            controller.isFillDescription.value = false;
                          }
                        },
                        child: Container(
                          height:8.2.h,
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(vertical: 1.5.h,),
                          decoration: BoxDecoration(
                              color:ColorConstants.primaryColor,
                              border: Border.all(color: ColorConstants.primaryColor,width: 1.5),
                              borderRadius:getCustomBorderRadius(13)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: addText("Book Now", getSubheadingTextFontSIze(), ColorConstants.white,FontWeight.w500,fontFamily: 'Aeonik'),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
            ],
          ),
        ));
  }

  Widget? location() {
    if (controller.locationDataList.isNotEmpty) {
      for (int i = 0; i < controller.locationDataList.length; i++) {
        if (controller.locationDataList[i].status == 1) {
          return Text(
            "${controller.locationDataList[i].streetNo},${controller.locationDataList[i].streetName},${controller.locationDataList[i].city}",
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Theme.of(context).colorScheme.onTertiary),
          );
        }
      }
    } else {
      return Text(
        ",,",
        style: TextStyle(color: Theme.of(context).colorScheme.onTertiary),
      );
    }
    return null;
  }

  void _onMapCreated(GoogleMapController controller1) {
    mapController = controller1;
  }
}
