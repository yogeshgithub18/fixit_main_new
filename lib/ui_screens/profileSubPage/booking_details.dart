import 'package:fixit/NewScreen/NewAppBar.dart';
import 'package:fixit/common/base_image_network.dart';
import 'package:fixit/common/color_constants.dart';
import 'package:fixit/ui_screens/app_header.dart';
import 'package:fixit/ui_screens/profileSubPage/controller/allBookings_controller.dart';
import 'package:fixit/ui_screens/rating/rating.dart';
import 'package:fixit/ui_screens/service/provider_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../common/bordered_button.dart';
import '../service/chat_screen.dart';

// ignore: must_be_immutable
class BookingDetails extends StatefulWidget {
  int bookingId;
  int index;

  BookingDetails({super.key, required this.bookingId, required this.index});

  @override
  State<BookingDetails> createState() => _BookingDetailsState();
}

class _BookingDetailsState extends State<BookingDetails> {
  AllBookingsController controller = Get.put(AllBookingsController());

  @override
  void initState() {
    init();
    super.initState();
  }

  init() async {
    print('Tab... ${widget.index}');
    print("BOOKING ID:- ${widget.bookingId}");
    await controller.getBookingDetailData(widget.bookingId);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await controller.getBookingDetailData(widget.bookingId);
        controller.update();
      },
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(7.h),
            child: const NewAppHeader(
              title: 'Service Detail',
              showBackIcon: true,
            )),
        body: GetBuilder<AllBookingsController>(builder: (controller) {
          return controller.bookingDetailData != null
              ? SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(height: 4.h,),
                      Padding(
                        padding: EdgeInsets.all(10.sp),
                        child: Container(
                          width: 92.w,
                          decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
                              borderRadius: BorderRadius.circular(5)),
                          child: Container(
                            padding: EdgeInsets.only(
                                left: 20.sp, top: 15.sp, right: 10.sp),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Service Detail".tr,
                                  style: TextStyle(
                                      color: Theme.of(Get.context!)
                                          .colorScheme
                                          .tertiary,
                                      fontSize: 18),
                                ),
                                SizedBox(height: 1.h),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SvgPicture.asset(
                                      "assets/images/plumber.svg",
                                      width: 2.w,
                                      height: 2.h,
                                      color: Theme.of(Get.context!)
                                          .colorScheme
                                          .onTertiary,
                                    ),
                                    SizedBox(width: 5.w),
                                    Text(
                                      controller.bookingDetailData?.category
                                              ?.name ??
                                          '',
                                      style: TextStyle(
                                          color: Theme.of(Get.context!)
                                              .colorScheme
                                              .onTertiary,
                                          fontSize: 16),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 2.h),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.watch_later_outlined,
                                      size: 18.sp,
                                    ),
                                    SizedBox(width: 5.w),
                                    Flexible(
                                      child: Text(
                                        "${controller.bookingDetailData?.fromTime ?? ''} - ${controller.bookingDetailData?.toTime ?? ''}",
                                        style: TextStyle(
                                            color: Theme.of(Get.context!)
                                                .colorScheme
                                                .onTertiary,
                                            fontSize: 16),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 3.h),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SvgPicture.asset(
                                      "assets/images/locPin.svg",
                                      color: Theme.of(Get.context!)
                                          .colorScheme
                                          .onTertiary,
                                    ),
                                    SizedBox(width: 5.w),
                                    Flexible(
                                      child: Text(
                                        "${controller.bookingDetailData?.userLocation?.streetNo ?? ''}, ${controller.bookingDetailData?.userLocation?.streetName ?? ''}, ${controller.bookingDetailData?.userLocation?.location ?? ''}",
                                        style: TextStyle(
                                            color: Theme.of(Get.context!)
                                                .colorScheme
                                                .onTertiary,
                                            fontSize: 16.0),
                                      ),
                                    ),
                                  ],
                                ),
                                // SizedBox(height: 2.h),
                                // Row(
                                //   mainAxisAlignment: MainAxisAlignment.start,
                                //   children: [
                                //     SvgPicture.asset(
                                //       "assets/images/locator.svg",
                                //       color: Theme.of(Get.context!)
                                //           .colorScheme
                                //           .onTertiary,
                                //     ),
                                //     SizedBox(width: 5.w),
                                //     Text(
                                //       "3.5 km",
                                //       style: TextStyle(
                                //           color: Theme.of(Get.context!)
                                //               .colorScheme
                                //               .onTertiary,
                                //           fontSize: 16),
                                //     ),
                                //   ],
                                // ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 12.sp,
                                      right: 12.sp,
                                      top: 12.sp,
                                      bottom: 12.sp),
                                  child: Divider(
                                    height: 2.h,
                                    color: ColorConstants.divderColor,
                                  ),
                                ),
                                Text(
                                  "Price Specification".tr,
                                  style: TextStyle(
                                      color: Theme.of(Get.context!)
                                          .colorScheme
                                          .tertiary,
                                      fontSize: 18),
                                ),
                                SizedBox(height: 1.h),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Price".tr,
                                          style: TextStyle(
                                              color: Theme.of(Get.context!)
                                                  .colorScheme
                                                  .onTertiary,
                                              fontSize: 16),
                                        ),
                                        SizedBox(
                                          height: 1.h,
                                        ),
                                        if (controller.bookingDetailData
                                                    ?.addonPrice !=
                                                null &&
                                            controller.bookingDetailData!
                                                .addonPrice!.isNotEmpty)
                                          Text(
                                            "Addon Service".tr,
                                            style: TextStyle(
                                                color: Theme.of(Get.context!)
                                                    .colorScheme
                                                    .onTertiary,
                                                fontSize: 16.0),
                                          ),
                                        SizedBox(
                                          height: 1.h,
                                        ),
                                        if (controller.bookingDetailData
                                                    ?.grandtotal !=
                                                null &&
                                            controller.bookingDetailData!
                                                .grandtotal!.isNotEmpty)
                                          Text(
                                            "Total Price".tr,
                                            style: TextStyle(
                                                color: Theme.of(Get.context!)
                                                    .colorScheme
                                                    .onTertiary,
                                                fontSize: 16.0),
                                          ),
                                        SizedBox(
                                          height: 1.h,
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${controller.bookingDetailData?.pricePerDay ?? "N/A"} IQD",
                                          style: TextStyle(
                                              color: Theme.of(Get.context!)
                                                  .colorScheme
                                                  .onTertiary,
                                              fontSize: 16.0),
                                        ),
                                        SizedBox(
                                          height: 1.h,
                                        ),
                                        if (controller.bookingDetailData
                                                    ?.addonPrice !=
                                                null &&
                                            controller.bookingDetailData!
                                                .addonPrice!.isNotEmpty)
                                          Text(
                                            "${controller.bookingDetailData?.addonPrice ?? ""} IQD",
                                            style: TextStyle(
                                                color: Theme.of(Get.context!)
                                                    .colorScheme
                                                    .onTertiary,
                                                fontSize: 17.0),
                                          ),
                                        SizedBox(
                                          height: 1.h,
                                        ),
                                        if (controller.bookingDetailData
                                                    ?.grandtotal !=
                                                null &&
                                            controller.bookingDetailData!
                                                .grandtotal!.isNotEmpty)
                                          Text(
                                            "${controller.bookingDetailData?.grandtotal ?? "N/A"} IQD",
                                            style: TextStyle(
                                                color: Theme.of(Get.context!)
                                                    .colorScheme
                                                    .onTertiary,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                         SizedBox(
                                          height: 1.h,
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 15.sp, right: 15.sp, top: 10.sp),
                        child: Text(
                          "${"Note".tr}:- ${controller.bookingDetailData?.text_description ?? ""}",
                          style: TextStyle(
                              color:
                                  Theme.of(Get.context!).colorScheme.onTertiary,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      widget.index != 0
                          ? Padding(
                              padding: EdgeInsets.all(15.sp),
                              child: Container(
                                height: 8.h,
                                decoration: BoxDecoration(
                                  color: Theme.of(Get.context!)
                                      .colorScheme
                                      .primaryContainer,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(left: 15.sp),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                        onTap: () => Get.to(ProviderProfile(
                                          image: controller.bookingDetailData
                                                  ?.serviceProvider?.image ??
                                              '',
                                          name: controller.bookingDetailData
                                                  ?.serviceProvider?.name ??
                                              '',
                                          category: controller.bookingDetailData
                                                  ?.category?.name ??
                                              '',
                                          description: controller
                                                  .bookingDetailData
                                                  ?.serviceProvider
                                                  ?.description ??
                                              '',
                                        )),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              clipBehavior:
                                              Clip.antiAliasWithSaveLayer,
                                              decoration: const BoxDecoration(
                                                  shape: BoxShape.circle),
                                              height: 6.h,
                                              width: 12.w,
                                              child: BaseImageNetwork(
                                                fit: BoxFit.fill,
                                                link: controller
                                                        .bookingDetailData
                                                        ?.serviceProvider
                                                        ?.image ??
                                                    '',
                                                concatBaseUrl: false,
                                                errorWidget: Image.asset(
                                                  "assets/images/profile.png",
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 2.w,
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  controller
                                                          .bookingDetailData
                                                          ?.serviceProvider
                                                          ?.name ??
                                                      '',
                                                  style: TextStyle(
                                                      color:
                                                          Theme.of(Get.context!)
                                                              .colorScheme
                                                              .onTertiary,
                                                      fontSize: 16),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              const Icon(Icons.star,
                                                  color: Colors.orangeAccent,
                                                  size: 18),
                                              Text(
                                                '${controller.bookingDetailData != null && controller.bookingDetailData!.totalRatingSp != null && controller.bookingDetailData!.totalRatingSp!.length >= 3 ? controller.bookingDetailData?.totalRatingSp?.substring(0, 3) : controller.bookingDetailData?.totalRatingSp ?? '0.0'}',
                                                // " ${controller.bookingDetailData?.totalRatingSp?.length >= 2 ? controller.bookingDetailData?.totalRatingSp?.substring(0,4) ?? "0.0"}",
                                                style: TextStyle(
                                                    color:
                                                        Theme.of(Get.context!)
                                                            .colorScheme
                                                            .onTertiary,
                                                    fontSize: 16),
                                              ),
                                              SizedBox(
                                                width: 4.w,
                                              )
                                            ],
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                          : const SizedBox.shrink(),
                      widget.index != 0
                          ?
                      Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: ClipRRect(
                                borderRadius: const BorderRadiusDirectional.all(
                                    Radius.circular(15)),
                                child: Align(
                                    alignment: Alignment.center,
                                    child: SizedBox(
                                      height: 30,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Expanded(
                                              flex: 33,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    // border: Border.all(
                                                    //   color: ColorConstants.borderColor, // Choose the color of the border
                                                    //   width: 1.0,           // Choose the width of the border
                                                    // ),
                                                    color: (controller.bookingDetailData?.serviceProviderStatus == 1 ||
                                                            controller
                                                                    .bookingDetailData
                                                                    ?.serviceProviderStatus ==
                                                                2 ||
                                                            controller
                                                                    .bookingDetailData
                                                                    ?.serviceProviderStatus ==
                                                                4)
                                                        ? ColorConstants
                                                            .primaryColor
                                                        : ColorConstants
                                                            .containerTextLight
                                                            .withOpacity(.5)),
                                                child: Align(
                                                  alignment: Alignment.center,
                                                  child: Text('On the Way'.tr,
                                                      style: const TextStyle(
                                                          color: ColorConstants
                                                              .white,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ),
                                              )),
                                          const VerticalDivider(
                                            width: 1,
                                            color: Colors.white,
                                          ),
                                          Expanded(
                                              flex: 33,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    // border: Border.all(
                                                    //   color: ColorConstants.borderColor, // Choose the color of the border
                                                    //   width: 1.0,           // Choose the width of the border
                                                    // ),
                                                    color: (controller
                                                                    .bookingDetailData
                                                                    ?.serviceProviderStatus ==
                                                                2 ||
                                                            controller
                                                                    .bookingDetailData
                                                                    ?.serviceProviderStatus ==
                                                                4)
                                                        ? ColorConstants
                                                            .primaryColor
                                                        : ColorConstants
                                                            .containerTextLight
                                                            .withOpacity(.5)),
                                                child: Align(
                                                  alignment: Alignment.center,
                                                  child: Text('Reached'.tr,
                                                      style: const TextStyle(
                                                          color: ColorConstants
                                                              .white,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ),
                                              )),
                                          const VerticalDivider(
                                            width: 1,
                                            color: Colors.white,
                                          ),
                                          Expanded(
                                              flex: 33,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    // border: Border.all(
                                                    //   color: ColorConstants.borderColor, // Choose the color of the border
                                                    //   width: 1.0,           // Choose the width of the border
                                                    // ),
                                                    color: controller
                                                                .bookingDetailData
                                                                ?.serviceProviderStatus ==
                                                            4
                                                        ? ColorConstants
                                                            .primaryColor
                                                        : ColorConstants
                                                            .containerTextLight
                                                            .withOpacity(.5)),
                                                child: Align(
                                                  alignment: Alignment.center,
                                                  child: Text('Complete'.tr,
                                                      style: const TextStyle(
                                                          color: ColorConstants
                                                              .white,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ),
                                              )),
                                        ],
                                      ),
                                    )),
                              ),
                            )
                          : const SizedBox.shrink(),
                      Column(
                        children: [
                          SizedBox(
                            height: 2.h,
                          ),
                          if (controller.bookingDetailData?.isComplete == 1)
                            GestureDetector(
                                onTap: () {
                                  Get.to(RatingScreen(
                                    serviceRequestId:
                                        controller.bookingDetailData?.id ?? 0,
                                  ));
                                },
                                child: BorderedButton(
                                    width: 1,
                                    isReversed: true,
                                    text: "Give rating".tr.toUpperCase())),
                          SizedBox(
                            height: 2.h,
                          ),
                          // Visibility(
                          //   visible: controller.bookingDetailData!.status == 1 && controller.bookingDetailData!.isClientConfirm == 0,
                          //   child: GestureDetector(
                          //       onTap: () {
                          //         controller.confirmBookingAPI(controller.bookingDetailData!.id);
                          //       },
                          //       child: BorderedButton(
                          //         width: 1,
                          //         text: "Confirm".toUpperCase(),
                          //         isReversed: true,
                          //         // icon: "assets/images/chat_icon.svg",
                          //       )),
                          // ),
                          // SizedBox(
                          //   height: 2.h,
                          // ),
                          Visibility(
                            visible: controller.bookingDetailData!.status ==
                                    1 &&
                                controller.bookingDetailData!.isClientConfirm ==
                                    0,
                            child: GestureDetector(
                                onTap: () {
                                  // controller.cancelBookingAPI(controller.bookingDetailData!.id);
                                },
                                child: BorderedButton(
                                  width: 1,
                                  text: "Cancel".tr.toUpperCase(),
                                  isReversed: true,
                                  // icon: "assets/images/chat_icon.svg",
                                )),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Visibility(
                            // visible: controller.bookingDetailData!.status != 0 && controller.bookingDetailData!.status != 2 && widget.index != 3,
                            visible: controller.bookingDetailData!.status !=
                                    0 &&
                                controller.bookingDetailData!.status != 2 &&
                                controller.bookingDetailData?.isComplete != 1 &&
                                widget.index != 1,
                            child: GestureDetector(
                              onTap: () {
                                Get.to(ChatScreen(
                                  name: controller
                                      .bookingDetailData?.serviceProvider?.name,
                                  image: controller.bookingDetailData
                                      ?.serviceProvider?.image,
                                  id: controller
                                      .bookingDetailData?.serviceProvider?.id,
                                ));
                              },
                              child: BorderedButton(
                                width: 1,
                                text: "Chat".tr.toUpperCase(),
                                isReversed: true,
                                icon: "assets/images/chat_icon.svg",
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                        ],
                      )
                    ],
                  ),
                )
              : const Center();
        }),
      ),
    );
  }
}
