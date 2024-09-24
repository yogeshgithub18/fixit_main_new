import 'package:fixit/common/base_image_network.dart';
import 'package:fixit/ui_screens/app_header.dart';
import 'package:fixit/ui_screens/profileSubPage/booking_details.dart';
import 'package:fixit/ui_screens/profileSubPage/controller/allBookings_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../common/color_constants.dart';
import '../base_pagination_footer.dart';

class MyBookings extends StatefulWidget {
  const MyBookings({super.key});

  @override
  State<MyBookings> createState() => _MyBookingsState();
}

class _MyBookingsState extends State<MyBookings> with SingleTickerProviderStateMixin {
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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(7.h),
        child: AppHeader(
          title: "My Bookings".tr,
          showBackIcon: false,
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 6.h,
            width: double.infinity,
            color: Theme.of(context).colorScheme.primaryContainer,
            child: TabBar(
              isScrollable: true,
              indicatorSize: TabBarIndicatorSize.label,
              onTap: (index) {
                // controller.allBookingdataList.clear();
                controller.selectedIndex.value = index;
              },
              labelPadding: EdgeInsets.all(2.sp),
              controller: _tabController,
              indicatorColor: ColorConstants.primaryColor,
              tabs: [
                _buildTab('Pending'.tr, 0),
                _buildTab('Accepted'.tr, 1),
                _buildTab('Active'.tr, 2),
                _buildTab('Completed'.tr, 3),
                _buildTab('Cancelled'.tr, 4),
              ],
            ),
          ),
          Flexible(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildTabContent('Pending'.tr, 0),
                _buildTabContent('Accepted'.tr, 1),
                _buildTabContent('Active'.tr, 2),
                _buildTabContent('Closed'.tr, 3),
                _buildTabContent('Cancelled'.tr, 4),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTab(String title, int index) {
    return Container(
      padding: EdgeInsets.all(1.sp),
      width: 30.w,
      child: Tab(
        child: Obx(() => Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: controller.selectedIndex.value == index
                    ? ColorConstants.primaryColor
                    : Theme.of(context).colorScheme.onTertiary,
              ),
            )),
      ),
    );
  }

  Widget _buildTabContent(String content, int tab) {
    return  Obx(() => SmartRefresher(
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
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        if (tab != 4) {
                          Get.to(BookingDetails(
                            bookingId: controller.allBookingdataList[index].id!,
                            index: tab,
                          ));
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                            left: 15.sp,
                            right: 15.sp,
                            bottom: 10.sp,
                            top: 10.sp),
                        padding: EdgeInsets.all(10.sp),
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primaryContainer,
                            borderRadius: BorderRadius.circular(5)),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              height: 4.h,
                              width: 8.w,
                              padding: EdgeInsets.all(6.sp),
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
                            SizedBox(
                              width: 2.w,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      controller.allBookingdataList[index].category
                                              ?.name ??
                                          '',
                                      style: TextStyle(
                                          color: Theme.of(Get.context!)
                                              .colorScheme
                                              .onTertiary,
                                          fontSize: 18),
                                    ),
                                    SizedBox(
                                      width: 2.w,
                                    ),
                                    Visibility(
                                     visible:controller.allBookingdataList[index].unread_message!>0&&tab==2,
                                      child: Stack(
                                        alignment: Alignment.topRight,
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(right: 5.0,bottom: 5.0,top: 5.0),
                                            child: Icon(Icons.chat,size: 20,),
                                          ),
                                          Container(
                                              height: 1.5.h,
                                              width: 3.5.w,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(20),
                                                  color: Colors.orangeAccent[200]
                                              ),
                                              child:Center(child: Text(controller.allBookingdataList[index].unread_message.toString(),style: const TextStyle(fontSize: 8, fontWeight: FontWeight.bold),))),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                Text(
                                  "${controller.formatDateString(controller.allBookingdataList[index].createdAt ?? '')}, ${controller.formatTimeString(controller.allBookingdataList[index].createdAt ?? '')}",
                                  style: const TextStyle(
                                      color: ColorConstants.hintColor,
                                      fontSize: 16),
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                SizedBox(
                                  width: 200,
                                  child: Text(
                                    "${controller.allBookingdataList[index].userLocation?.streetNo ?? ''}, ${controller.allBookingdataList[index].userLocation?.streetName ?? ''}, ${controller.allBookingdataList[index].userLocation?.location ?? ''} ",
                                    style: TextStyle(
                                        color: Theme.of(Get.context!)
                                            .colorScheme
                                            .onTertiary,
                                        fontSize: 16),
                                  ),
                                ),
                                // SizedBox(
                                //   height: 1.h,
                                // ),
                                // Row(
                                //   children: [
                                //     SvgPicture.asset(
                                //       "assets/images/locator.svg",
                                //       color: Theme.of(Get.context!)
                                //           .colorScheme
                                //           .onTertiary,
                                //     ),
                                //     SizedBox(
                                //       width: 1.w,
                                //     ),
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
                              ],
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "${controller.allBookingdataList[index].pricePerDay ?? 'N/A'} IQD",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(Get.context!)
                                            .colorScheme
                                            .onTertiary,
                                        fontSize: 20),
                                  ),
                                  SizedBox(
                                    height: 3.h,
                                  ),
                                  Container(
                                      padding: EdgeInsets.all(10.sp),
                                      decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onTertiary,
                                          borderRadius: BorderRadius.circular(20)),
                                      child: tab == 1 ?
                                      Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  height: 1.h,
                                                  width: 1.w,
                                                  decoration:
                                                      const BoxDecoration(
                                                          color:
                                                              ColorConstants
                                                                  .primaryColor,
                                                          shape:
                                                              BoxShape.circle),
                                                ),
                                                SizedBox(
                                                  width: 1.w,
                                                ),
                                                Center(
                                                    child: Text(
                                                  content.toUpperCase(),
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(color: Theme.of(context).colorScheme.errorContainer, fontSize: 10),
                                                )),
                                              ],
                                            )
                                          : Text(content.toUpperCase(),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .errorContainer,
                                                  fontSize: 14.0),
                                            )),
                                  SizedBox(height: 1.h,),
                                  if (tab == 0) //|| tab == 1
                                    Container(
                                      height: 3.5.h,
                                      width: 20.w,
                                      decoration: const BoxDecoration(
                                        borderRadius:
                                            BorderRadiusDirectional.all(
                                                Radius.circular(20)),
                                        color: Colors.red,
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(10.sp),
                                        child: InkWell(
                                          onTap: () {
                                            controller.cancelBookingAPI(controller.allBookingdataList[index].id);
                                          },
                                          child: Center(
                                            child: Text('CANCEL'.tr,
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14.0)),
                                          ),
                                        ),
                                      ),
                                    )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                )),
    );
  }
}
