import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../common/base_image_network.dart';
import '../common/color_constants.dart';
import '../common/utils.dart';
import '../ui_screens/base_pagination_footer.dart';
import '../ui_screens/profileSubPage/booking_details.dart';
import '../ui_screens/profileSubPage/controller/allBookings_controller.dart';
import 'AppTextFile.dart';
import 'NewAppBar.dart';
import 'OrderPending.dart';

class MyBookingsFixit extends StatefulWidget {
  const MyBookingsFixit({super.key});

  @override
  State<MyBookingsFixit> createState() => _MyBookingsFixitState();
}

class _MyBookingsFixitState extends State<MyBookingsFixit> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  AllBookingsController controller = Get.put(AllBookingsController());
  @override
  void initState() {
    controller.getAllBookingsData();
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    _tabController.addListener(() async {
      if (!(_tabController.indexIsChanging)) {
        controller.allBookingdataList.clear();
        controller.selectedIndex.value = _tabController.index;
        print("_tabController.index--${_tabController.index}");
        await controller.getAllBookingsData();
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
          length: 5,
          child: Column(
            children: [
              Container(
                width: Get.width,
                color: Theme.of(context).colorScheme.primaryContainer,
                child:  TabBar(
                  controller:  _tabController,
                  onTap: (index) {
                    controller.selectedIndex.value = index;
                  },
                  tabAlignment: TabAlignment.center,
                  isScrollable: true,
                  indicatorWeight: 3.5,
                  dividerColor: Colors.transparent,
                  indicatorColor: ColorConstants.primaryColor,
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelPadding: EdgeInsets.only(right:2.w,left: 2.w),
                  physics: const NeverScrollableScrollPhysics(),
                  labelColor: Theme.of(context).colorScheme.tertiary,
                  labelStyle: lableStyleTextField(),
                  unselectedLabelColor: Theme.of(context).colorScheme.tertiary,
                  unselectedLabelStyle: lableStyleTextField(),
                  tabs:  [
                    Tab(text: 'Pending'.tr),
                    Tab(text: 'Accepted'.tr),
                    Tab(text: 'Active'.tr),
                    Tab(text: 'Completed'.tr),
                    Tab(text: 'Cancelled'.tr),
                  ],
                ),
              ),const SizedBox(height:10,),
              Expanded(
                child: TabBarView(
                  controller:  _tabController,
                  children: [
                    buildTaskCard('Pending'.tr, 0),
                    buildTaskCard('Accepted'.tr, 1),
                    buildTaskCard('Active'.tr, 2),
                    buildTaskCard('Closed'.tr, 3),
                    buildTaskCard('Cancelled'.tr, 4),
                  ],
                ),
              ),
            ],
          )),
    );
  }

  Widget buildTaskCard(String content, int tab) {
    return Obx(() => SmartRefresher(
      footer: const BasePaginationFooter(),
      controller: controller.refreshController,
      enablePullDown: true,
      enablePullUp: true,
      onLoading: (){
        controller.getAllBookingsData(refreshType: "load");
      },
      onRefresh: (){
        controller.getAllBookingsData(refreshType: "refresh");
      },
      child: controller.allBookingdataList.isEmpty
          ? Center(
        child: Text(
          'NO BOOKINGS'.tr,
          style: TextStyle(
              color: Theme.of(Get.context!).colorScheme.onTertiary,
              fontSize: 18),
        ),
      )
          : ListView.builder(
          itemCount: controller.allBookingdataList.length,
          physics: const ScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
           return GestureDetector(
             onTap: (){
               if (tab != 4) {
                 Get.to(OrderPending(
                   bookingId: controller.allBookingdataList[index].id!,
                   index: tab,
                   type:content
                 ));
               }
             },
             child: Container(
                       width: double.infinity,
                       padding: const EdgeInsets.only(top: 10,left: 8,right:8,bottom: 10),
                       margin: const EdgeInsets.only(left: 15, right: 15,bottom: 10),
                       decoration: BoxDecoration(
                         color: Theme.of(context).colorScheme.primaryContainer,
                          borderRadius: getBorderRadius13(),
                       ),
                       child: Row(
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
                        link: controller.allBookingdataList[index]
                            .category?.image ??
                            '',
                        concatBaseUrl: false,
                        errorWidget: Image.asset(
                          "assets/images/profile.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                     AppTexts.helveticaText16W600(
                         controller.allBookingdataList[index].category
                             ?.name ??
                             '',
                      textColor: Theme.of(context).colorScheme.tertiary,
                    ),
                    AppTexts.helveticaText16W400(
                         controller.allBookingdataList[index].subcategory
                             ?.name ??
                             '',
                      textColor: Theme.of(context).colorScheme.tertiary,
                    ),
                    SizedBox(height: 1.h),
                     AppTexts.helveticaText16W400(
                       controller.allBookingdataList[index].date ?? '',
                       textColor: Theme.of(context).colorScheme.tertiary,
                      fontSize: 14,
                    ),
                    SizedBox(height: 1.5.h),// Added space for better layout
                    SizedBox(
                      width: 52.sp,
                      child:  AppTexts.helveticaText16W400(
                        "${controller.allBookingdataList[index].userLocation?.streetNo ?? ''}, ${controller.allBookingdataList[index].userLocation?.streetName ?? ''}, ${controller.allBookingdataList[index].userLocation?.location ?? ''} ",
                        textColor: Theme.of(context).colorScheme.tertiary,
                        fontSize: 14,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                     Padding(
                       padding: const EdgeInsets.only(right: 8.0),
                       child: Container(
                        width: 114,
                        height: 30,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: ColorConstants.fixitLightYellow,
                          borderRadius: getEdgyBorderRadius()
                        ),
                        child:  tab == 1 ?  Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 1.h,
                              width: 1.w,
                              decoration:
                              const BoxDecoration(
                                  color:
                                  ColorConstants.primaryColor,
                                  shape: BoxShape.circle),
                            ),
                            SizedBox(
                              width: 1.w,
                            ),
                            Center(
                                child: AppTexts.aeonikText13W400(
                                  content.toUpperCase(),
                                  textColor:  Colors.black,
                                  textAlign: TextAlign.center,
                                ),
                            ),
                          ],
                        ):AppTexts.aeonikText13W400(
                          content.toUpperCase(),
                          textColor: Colors.black,
                          textAlign: TextAlign.center,
                        ),
                                           ),
                     ),
                     SizedBox(height: 4.h,),
                     Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppTexts.helveticaText16W500(
                          tab !=3 ?'Order Price':'Total Price',
                          textColor: Theme.of(context).colorScheme.tertiary,
                          fontSize: 13,
                        ),
                        AppTexts.helveticaText16W800("${controller.allBookingdataList[index].subcategory?.price ?? 'N/A'} IQD",)
                      ],
                    ),
                    if (tab == 0)
                      Container(
                      margin: const EdgeInsets.only(left: 20),
                      child: TextButton.icon(
                        onPressed: () {
                          controller.cancelBookingAPI(controller.allBookingdataList[index].id);
                        },
                        icon: Container(
                          width: 18,
                          height: 18,
                          decoration: BoxDecoration(
                            color: ColorConstants.fixitRed,
                            borderRadius: BorderRadius.circular(50)
                          ),
                          child: const Center(child: Icon(Icons.close_rounded,color: ColorConstants.headerTextDark,size: 15,)),
                        ), // Smaller icon
                        label: const
                        AppTexts.aeonikText16W400(
                          'CANCEL',
                          textColor:ColorConstants.fixitRed ,
                            fontWeight: FontWeight.w700
                        )
                      ),
                    ),
                  ],
                ),
              ],
                       ),
                     ),
           );}),
    ));
    }
  }

