import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../NewScreen/NewAppBar.dart';

import '../../common/color_constants.dart';
import '../common/base_overlays.dart';
import '../common/bordered_button.dart';
import '../common/utils.dart';
import '../ui_screens/locations/controller/location_controller.dart';
import 'AppTextFile.dart';

class AddAddress extends StatefulWidget {
  final String page;
  final bool? isEditLocation;
  final int? locationId;
  final LatLng? location;

  const AddAddress({
    Key? key,
    required this.page,
    required this.location,
    this.isEditLocation = false,
    this.locationId,
  }) : super(key: key);

  @override
  State<AddAddress> createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  LocationController controller = Get.find<LocationController>();
  LatLng ? selectedPosition;

  @override
  Widget build(BuildContext context) {
    selectedPosition=widget.location;
    return Scaffold(
      backgroundColor: ColorConstants.headerTextDark,
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(7.h),
        child: NewAppHeader(
          title: 'FIXIT',
          showBackIcon: widget.page != "Login",
        ),
      ),
      body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 15,vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppTexts.helveticaText16W600(
            'Add New Address',
                ),
              const SizedBox(height: 10),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                padding: EdgeInsets.symmetric(vertical: 11.sp),
                decoration: BoxDecoration(
                  color: ColorConstants.fixitText,
                  borderRadius: getBorderRadius13(),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.sp),
                  child: TextFormField(
                    controller: controller.streetNoCtrl,
                    style: TextStyle(
                      fontSize: getNormalTextFontSIze() + 1,
                      color: ColorConstants.black,),
                    decoration: InputDecoration(
                      hintText: "Apartment / House number".tr,
                      border: InputBorder.none,
                      hintStyle:  hintStyleTextField(),
                    ),
                    keyboardType: TextInputType.multiline,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric( vertical: 5),
                padding: EdgeInsets.symmetric(vertical: 11.sp),

                decoration: BoxDecoration(
                  color:ColorConstants.fixitText,
                  borderRadius: getBorderRadius13() ,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.sp),
                  child: TextFormField(
                    controller: controller.streetNameCtrl,
                    style: TextStyle(
                      fontSize: getNormalTextFontSIze() + 1,
                      color: ColorConstants.black,),
                    decoration: InputDecoration(
                      hintText: "Street / Province".tr,
                      border: InputBorder.none,
                      hintStyle:  hintStyleTextField(),
                    ),
                    keyboardType: TextInputType.multiline,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                padding: EdgeInsets.symmetric(vertical: 11.sp),

                decoration: BoxDecoration(
                  color:ColorConstants.fixitText,
                  borderRadius: getBorderRadius13() ,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.sp),
                  child: TextFormField(
                    controller: controller.cityCtrl,
                    style: TextStyle(
                      fontSize: getNormalTextFontSIze() + 1,
                      color: ColorConstants.black,),
                    decoration: InputDecoration(
                      hintText: "City".tr,
                      border: InputBorder.none,
                      hintStyle:  hintStyleTextField(),
                    ),
                   // keyboardType: TextInputType.number,
                  ),
                ),
              ),
              SizedBox(height: 2.h),
              GestureDetector(
                onTap: () {
                  if (controller.streetNoCtrl.text.isEmpty ||
                      controller.streetNameCtrl.text.isEmpty ||
                      controller.cityCtrl.text.isEmpty) {
                    BaseOverlays().showSnackBar(
                      message: "All fields are mandatory".tr,
                      title: "Error".tr,
                    );
                  } else {
                    if (widget.isEditLocation == true) {
                      controller.editLocation(
                        widget.locationId,
                        selectedPosition!.latitude,
                        selectedPosition!.longitude,
                      );
                    } else {
                      controller.addLocation(
                        selectedPosition!.latitude,
                        selectedPosition!.longitude,
                      );
                    }
                  }
                },
                child: BorderedButton(
                  width: 1,

                  text: "Add".tr,
                  isReversed: true,
                ),
              ),
            ],
          ),
        ),
    );
  }
}
