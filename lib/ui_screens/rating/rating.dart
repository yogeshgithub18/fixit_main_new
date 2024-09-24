import 'package:fixit/common/color_constants.dart';
import 'package:fixit/ui_screens/profileSubPage/controller/allBookings_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../NewScreen/NewAppBar.dart';
import '../../common/bordered_button.dart';
import '../app_header.dart';

// ignore: must_be_immutable
class RatingScreen extends StatefulWidget {
  int serviceRequestId;
  RatingScreen({super.key, required this.serviceRequestId});

  @override
  _RatingScreenState createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  AllBookingsController controller = Get.find<AllBookingsController>();
  @override
  void initState() {
    print("SERVICE PROVIDER ID:- ${widget.serviceRequestId}");
    super.initState();
    controller.commentCtrl.clear();
  }


  @override
  Widget build(BuildContext context) {
    return GetBuilder<AllBookingsController>(builder: (controller) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(7.h),
            child: const NewAppHeader(
              title: 'Rating',
              showBackIcon: true,
             // isBackIcon: true,
            )),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Give Rating".tr,
                style: TextStyle(
                  fontSize: 25,
                  color: Theme.of(Get.context!).colorScheme.tertiary,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 5.h),
              RatingBar.builder(
                initialRating: controller.rating,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: false,
                itemCount: 5,
                itemSize: 40.0,
                unratedColor: ColorConstants.hintColor,
                itemBuilder: (context, _) => const Padding(
                  padding: EdgeInsets.all(1.0),
                  child: Icon(
                    Icons.star_rounded,
                    size: 25,
                    color: ColorConstants.primaryColor,
                  ),
                ),
                onRatingUpdate: (rating) {
                  controller.rating = rating;
                  controller.update();
                },
              ),
              SizedBox(height: 5.h),
              Container(
                height: 20.h,
                width: 80.w,
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    // validator: (value) {
                    //   if (value!.isEmpty) {
                    //     return 'Please enter review'.tr;
                    //   }
                    //   return null;
                    // },
                    controller: controller.commentCtrl,
                    decoration: InputDecoration(
                      hintText: 'Write your review here'.tr,
                      hintStyle: TextStyle(
                          color: Theme.of(Get.context!).colorScheme.error),
                      border: InputBorder.none,
                    ),
                    maxLines: 5,
                    onChanged: (value) {},
                  ),
                ),
              ),
              const Spacer(),
              GestureDetector(
                  onTap: () {
                    controller.giveRating(widget.serviceRequestId);
                    // if (controller.commentCtrl.text.isEmpty) {
                    //   BaseOverlays()
                    //       .showSnackBar(message: 'Please enter review'.tr);
                    // } else {
                    //   controller.giveRating(widget.serviceProviderId);
                    // }
                  },
                  child: BorderedButton(
                      width: 1,
                      isReversed: true,
                      text: "Submit".tr.toUpperCase())),
            ],
          ),
        ),
      );
    });
  }
}
