import 'package:fixit/backend/modal/service_provider_response.dart';
import 'package:fixit/common/base_image_network.dart';
import 'package:fixit/common/base_overlays.dart';
import 'package:fixit/ui_screens/app_header.dart';
import 'package:fixit/ui_screens/bottomSubPages/controller/dashboardController.dart';
import 'package:fixit/ui_screens/service/star_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../common/bordered_button.dart';

class ProviderIntro extends StatefulWidget {
  final ServiceProvider data;
  const ProviderIntro({super.key, required this.data});

  @override
  State<ProviderIntro> createState() => _ProviderIntroState();
}

class _ProviderIntroState extends State<ProviderIntro> {
  DashBoardController controller = Get.find<DashBoardController>();
  @override
  void initState() {
    controller.dateCtrl.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
    controller.fromTimeCtrl.text = DateFormat('hh:mm a').format(DateTime.now());
    controller.toTimeCtrl.text = DateFormat('hh:mm a').format(DateTime.now().add(const Duration(hours: 1)));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(7.h),
        child: const AppHeader(
          showBackIcon: true,
          title: '',
        ),
      ),
      body: GetBuilder<DashBoardController>(builder: (controller) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 20.sp),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                 // height: 10.h,
                  width: 90.w,
                  padding: EdgeInsets.only(top: 10.sp,left: 15.sp,bottom: 10.sp),
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(5)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          BaseImageNetwork(
                              link: widget.data.image,
                              height: 8.h,
                              width: 20.w,
                              fit: BoxFit.fill),
                          SizedBox(
                            width: 4.w,
                          ),
                          SizedBox(
                            width: 30.w,
                            child: Text(
                              widget.data.name!,
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.tertiary,
                                  fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.only(end: 10.0),
                        child: Text(
                          "${widget.data.price ?? "N/A"} IQD",
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.tertiary,
                              fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.sp,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.sp),
                  child: SizedBox(
                    height: 60.h,
                    width: 90.w,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Text(
                            widget.data.description != null
                                ? widget.data.description!
                                : "Lorem Ipsum is simply dummy text of the printing and typesetting. Lorem Ipsum is simply dummy text of the printing and typesetting. Lorem Ipsum is simply dummy text of the printing and typesetting. Lorem Ipsum is simply dummy text of the printing and typesetting.".tr,
                            style: TextStyle(
                                fontSize: 15,
                                color:
                                    Theme.of(context).colorScheme.onTertiary),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.sp,
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 4.h,
                    ),
                    // GestureDetector(
                    //   onTap: () {
                    //     Get.back();
                    //     // Get.to(() => MapScreen());
                    //   },
                    //   child: BorderedButton(
                    //     width: 1,
                    //     text: "Back to Services".toUpperCase(),
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 2.h,
                    // ),
                    GestureDetector(
                        onTap: () {
                          if(widget.data.status==1){
                           // Get.to(()=>StartService(id:widget.data.id!));
                            // controller.createServiceRequest(widget.data.id);
                          }else{
                            BaseOverlays().showSnackBar(message:"This service currently not available".tr,title: "Error".tr);
                          }
                        },
                        child: BorderedButton(
                          width: 1,
                          text: "Create Request".tr.toUpperCase(),
                          isReversed: true,
                        ))
                  ],
                ),
                SizedBox(
                  height: 2.h,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  String formatDateString(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    String formattedDate = DateFormat('MMM dd, yyyy').format(dateTime.toLocal());
    return formattedDate;
  }
}
