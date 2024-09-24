import 'package:fixit/common/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../backend/modal/booking_detail_data_model.dart';
import '../common/base_image_network.dart';
import '../common/bordered_button.dart';
import '../common/utils.dart';
import '../ui_screens/profileSubPage/controller/allBookings_controller.dart';
import '../ui_screens/rating/rating.dart';
import '../ui_screens/service/chat_screen.dart';
import '../ui_screens/service/provider_profile.dart';
import 'AppTextFile.dart';
import 'NewAppBar.dart';

class OrderPending extends StatefulWidget {
 final int bookingId;
 final String type;
 final int index;
   const OrderPending({super.key ,required this.bookingId, required this.index,required this.type});

  @override
  State<OrderPending> createState() => _OrderPendingState();
}

class _OrderPendingState extends State<OrderPending> {

  AllBookingsController controller=Get.find<AllBookingsController>();
  @override
  void initState() {
    init();
    super.initState();
  }

  init() async {
    await controller.getBookingDetailData(widget.bookingId);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(7.h),
        child: const NewAppHeader(
          title: 'FIXIT',
          showBackIcon: true,
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async{
          await controller.getBookingDetailData(widget.bookingId);
          controller.update();
        },
        child:GetBuilder<AllBookingsController>(builder: (controller) {
          return controller.bookingDetailData != null ? SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 1.5.h),
                Padding(
                  padding: EdgeInsets.only(left: 15.sp,right: 15.sp),
                  child: AppTexts.helveticaText16W500(
                    'Service Detail'.tr, textColor: Theme
                      .of(context)
                      .colorScheme
                      .tertiary,),
                ),
                SizedBox(height: 2.h),
                widget.index != 0 ?OrderStatusCard(bookingDetailData: controller.bookingDetailData!,):SizedBox(),
               Container(
                width: double.infinity,
                padding:  EdgeInsets.only(top: 15.sp, left: 15.sp, right: 10.sp, bottom: 20.sp),
                margin:  EdgeInsets.only(left: 15.sp, right: 13.sp, bottom: 10.sp),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius:  getBorderRadius13(),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              height: 5.h,
                              width: 10.w,
                              padding: EdgeInsets.all(2.sp),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                // color: ColorConstants.scaffoldDark,
                              ),
                              child: BaseImageNetwork(
                                link: controller.bookingDetailData?.category?.image ??
                                    '',
                                concatBaseUrl: false,
                                errorWidget: Image.asset(
                                  "assets/images/profile.png",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                             SizedBox(height: 4.sp),
                            AppTexts.helveticaText16W500(
                              controller.bookingDetailData?.category
                                  ?.name ??
                                  '',
                              textColor: Theme.of(context).colorScheme.tertiary,
                              fontWeight: FontWeight.w700,
                            ),
                            AppTexts.helveticaText16W500(
                              controller.bookingDetailData?.subcategory
                                  ?.name ??
                                  '',
                              textColor: Theme.of(context).colorScheme.tertiary,
                            ),
                            SizedBox(height: 1.h),
                            SizedBox(
                              width: 50.w,
                              child:  AppTexts.helveticaText15W400(
                                controller.bookingDetailData?.category?.description ??
                                    '',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              width: 25.w,
                              height: 5.h,
                              decoration: BoxDecoration(
                                color: ColorConstants.fixitLightYellow,
                                borderRadius: getEdgyBorderRadius(),
                              ),
                              child:  Center(
                                child: AppTexts.aeonikText13W400(widget.type),
                              ),
                            ),
                            //const SizedBox(height: 4),
                            //AppTexts.aeonikText13W400('Order Number: ${'#02488'}', textColor: Theme.of(context).colorScheme.tertiary,)
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding:  EdgeInsets.symmetric(vertical: 15.sp),
                      child: Container(
                        width: double.infinity,
                        height: 1,
                        color: ColorConstants.fixitOtherBorder,
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 18,
                          width: 17,
                          child: SvgPicture.asset(
                            'assets/images/calender.svg',
                            fit: BoxFit.fill,
                          ),
                        ),
                        SizedBox(width: 10.sp),
                        AppTexts.helveticaText16W500(
                          controller.bookingDetailData?.date ?? '',
                          textColor: Theme.of(context).colorScheme.tertiary,
                          fontWeight: FontWeight.w400,
                        ),
                        SizedBox(width: 15.sp),
                        SizedBox(
                          height: 18,
                          width: 17,
                          child: SvgPicture.asset(
                            'assets/images/clock.svg',
                            fit: BoxFit.fill,
                          ),
                        ),
                        SizedBox(width: 10.sp),
                        AppTexts.helveticaText16W500(
                          "${controller.bookingDetailData?.fromTime ?? ''} - ${controller.bookingDetailData?.toTime ?? ''}",
                          textColor: Theme.of(context).colorScheme.tertiary,
                          fontWeight: FontWeight.w400,
                        ),
                      ],
                    ),
                    SizedBox(height: 2.h),
                    SizedBox(
                      height: 24,
                      width: 22,
                      child: SvgPicture.asset(
                        'assets/images/cardLocationLogo.svg',
                        fit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(height: 1.h),
                    SizedBox(
                      width: 90.w,
                      child:  AppTexts.helveticaText16W500(
                        "${controller.bookingDetailData?.userLocation?.streetNo ?? ''}, ${controller.bookingDetailData?.userLocation?.streetName ?? ''}, ${controller.bookingDetailData?.userLocation?.location ?? ''}",
                        textColor: Theme.of(context).colorScheme.tertiary,
                        fontWeight: FontWeight.w400,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Padding(
                      padding:  EdgeInsets.symmetric(vertical: 15),
                      child: Container(
                          width: double.infinity,
                          height: 1,
                          color: ColorConstants.fixitOtherBorder),
                    ),
                    AppTexts.aeonikText14W400(
                      'Price Specification:'.tr,
                      textColor: Theme.of(context).colorScheme.tertiary,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppTexts.aeonikText16W400('Price:'.tr, textColor: Theme.of(context).colorScheme.tertiary,),
                            if (controller.bookingDetailData?.addonPrice != null && controller.bookingDetailData!.addonPrice!.isNotEmpty) AppTexts.aeonikText16W400("Addon Service".tr, textColor: Theme.of(context).colorScheme.tertiary,),
                            if (controller.bookingDetailData?.grandtotal != null && controller.bookingDetailData!.grandtotal!.isNotEmpty)AppTexts.aeonikText16W400('Total Price:'.tr, textColor: Theme.of(context).colorScheme.tertiary,),
                          ],
                        ),
                        SizedBox(width: 14.w),
                         Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppTexts.helveticaText16W800("${controller.bookingDetailData?.subcategory?.price ?? "N/A"} IQD",
                            ),
                            if (controller.bookingDetailData?.addonPrice != null && controller.bookingDetailData!.addonPrice!.isNotEmpty)
                              AppTexts.helveticaText16W800("${controller.bookingDetailData?.addonPrice ?? ""} IQD",),
                            if (controller.bookingDetailData?.grandtotal != null && controller.bookingDetailData!.grandtotal!.isNotEmpty)
                              AppTexts.helveticaText16W800("${controller.bookingDetailData?.grandtotal ?? "N/A"} IQD",
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
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
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15, vertical: 10),
                  margin: const EdgeInsets.only(
                      left: 15, right: 15, bottom: 40),
                  decoration: BoxDecoration(
                    borderRadius: getBorderRadius13(),
                    color: ColorConstants.fixitNotes,
                  ),
                  child:  AppTexts.aeonikText13W400(
                      "${"Note".tr}:- ${controller.bookingDetailData?.text_description ?? ""}",
                  ),
                ),
              ],
            ),
          ) : SizedBox();
        }),
      ),
    );
  }

}

class OrderStatusCard extends StatefulWidget {
  final  BookingDetailData bookingDetailData;
  const OrderStatusCard({super.key,required this.bookingDetailData});

  @override
  State<OrderStatusCard> createState() => _OrderStatusCardState();
}

class _OrderStatusCardState extends State<OrderStatusCard> {
  AllBookingsController controller=Get.find<AllBookingsController>();
  @override
  Widget build(BuildContext context) {
    List<StatusStep> steps = [
      StatusStep(label: 'On the Way', isComplete: (controller.bookingDetailData?.serviceProviderStatus == 1 ||
          controller
              .bookingDetailData
              ?.serviceProviderStatus ==
              2 ||
          controller
              .bookingDetailData
              ?.serviceProviderStatus ==
              4), isActive: false),
      StatusStep(label: 'Arrived', isComplete: (controller
          .bookingDetailData
          ?.serviceProviderStatus ==
          2 ||
          controller
              .bookingDetailData
              ?.serviceProviderStatus ==
              4), isActive: false),
      StatusStep(label: 'Completed', isComplete: controller
          .bookingDetailData
          ?.serviceProviderStatus ==
          4, isActive: false),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 15),
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius:  getBorderRadius13(),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  children: [
                    Container(
                      clipBehavior:
                      Clip.antiAliasWithSaveLayer,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle),
                      height: 8.h,
                      width: 13.w,
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
                      width: 4.w,
                    ),
                     AppTexts.helveticaText16W600(
                       controller
                           .bookingDetailData
                           ?.serviceProvider
                           ?.name ??
                           '',
                      textColor: Theme.of(context).colorScheme.tertiary,
                      fontSize: 20,
                    )
                  ],
                ),
              ),

              /// remove use api according
               Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.star, color: Colors.green, size: 12),
                      Icon(Icons.star, color: Colors.green, size: 12),
                      Icon(Icons.star, color: Colors.green, size: 12),
                      Icon(Icons.star, color: Colors.green, size: 12),
                      Icon(Icons.star, color: Colors.green, size: 12),
                    ],
                  ),
                  Text(
                    '${controller.bookingDetailData != null && controller.bookingDetailData!.totalRatingSp != null && controller.bookingDetailData!.totalRatingSp!.length >= 3 ? controller.bookingDetailData?.totalRatingSp?.substring(0, 3) : controller.bookingDetailData?.totalRatingSp ?? '0.0'}/5 RATING',
                    style: TextStyle(
                      fontSize: 12,
                     color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 2.h),
        const Padding(
          padding: EdgeInsets.only(left: 15,right: 15),
          child: AppTexts.helveticaText16W400(
            'Order Status:',
            textColor: ColorConstants.fixitAddress,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              left: 18.sp, right: 18.sp, top: 10.sp, bottom: 20.sp),
          child: OrderStatusIndicator(steps: steps),
        ),
      ],
    );
  }
}

class OrderStatusIndicator extends StatelessWidget {
  final List<StatusStep> steps;

  const OrderStatusIndicator({super.key, required this.steps});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: List.generate(steps.length * 2 - 1, (index) {
        final isCircle = index.isEven;
        final stepIndex = index ~/ 2;
        if (isCircle) {
          return StatusStepWidget(step: steps[stepIndex]);
        } else {
          return Expanded(
            child: Container(
              margin: const EdgeInsets.only(bottom: 18),
              height: 1,
              color: steps[stepIndex].isComplete
                  ? ColorConstants.primaryColor
                  :  Theme.of(context).colorScheme.primaryContainer,
            ),
          );
        }
      }),
    );
  }
}

class StatusStep {
  final String label;
  final bool isComplete;
  final bool isActive;

  StatusStep(
      {required this.label, required this.isComplete, required this.isActive});
}

class StatusStepWidget extends StatelessWidget {
  final StatusStep step;

  const StatusStepWidget({super.key, required this.step});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 12,
          backgroundColor: step.isComplete
              ? ColorConstants.primaryColor
              : step.isActive
                  ? ColorConstants.fixitText
                  : ColorConstants.fixitText,
          child: step.isComplete
              ? const Icon(Icons.check,
                  size: 16, color: ColorConstants.headerTextDark)
              : null,
        ),
        const SizedBox(height: 4),
        AppTexts.helveticaText16W500(
          step.label,
          textColor: Theme.of(context).colorScheme.tertiary,
          fontSize: 13,
        )
      ],
    );
  }
}
