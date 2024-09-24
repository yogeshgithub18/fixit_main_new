import 'package:carousel_slider/carousel_slider.dart';
import 'package:fixit/backend/modal/service_provider_response.dart';
import 'package:fixit/ui_screens/bottomSubPages/controller/dashboardController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../common/color_constants.dart';
import '../service/provider_intro.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  final PageController _pageController = PageController();
  DashBoardController controller = Get.put(DashBoardController());
  // int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    controller.getServiceProvider();
    controller.getBanner();
    controller. getNotificationCount();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers:[
          SliverAppBar(
            expandedHeight:45.h,
            automaticallyImplyLeading: false,
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Obx(() =>
                  Column(
                  children: [
                    controller.bannerList.isEmpty? Container(
                     height: 340,
                     width: double.infinity,
                     margin: const EdgeInsets.symmetric(vertical: 0),
                     decoration: BoxDecoration(
                       color: Colors.white,
                       borderRadius: BorderRadius.circular(16),
                     ),
                     child: Image.asset(
                       'assets/images/logo.jpeg',
                       fit: BoxFit.fill,
                     ),
                    ) :CarouselSlider(
                        items: controller.bannerList.map((item) {
                          return Container(
                            height: 260,
                            margin: const EdgeInsets.symmetric(vertical: 0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Image.network(
                              '${item.image}',
                              fit: BoxFit.fill,
                            ),
                          );
                        }).toList(),
                        options: CarouselOptions(
                          height: 45.h,
                          aspectRatio: 16 / 9,
                          viewportFraction: 1,
                          initialPage: 0,
                          enableInfiniteScroll: true,
                          reverse: false,
                          autoPlay: controller.bannerInfo.value.bannerSlideStatus??false,
                          autoPlayInterval:Duration(seconds: controller.bannerInfo.value.bannerDuration??4),
                          autoPlayCurve: Curves.easeInToLinear,
                          enlargeCenterPage: true,
                          enlargeFactor: 0.0,
                          onPageChanged:(index,reason){
                            controller.currentIndex.value=index;
                            // setState(() {
                            //   _currentPage=index;
                            // });
                          },
                          scrollDirection: Axis.horizontal,
                        )),
                    SizedBox(
                        height: 2.h,
                        child: Padding(
                          padding: EdgeInsets.only(top: 10.sp),
                          child: buildBullets(),
                        )),
                  ],
                ),
              ),
            ),
          ),
          Obx(() => SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // Number of columns
                  mainAxisSpacing:20.sp,
                  crossAxisSpacing:2.sp,
                  childAspectRatio:1.3, // Width / Height ratio for each grid item
                ),
                delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
                    return serviceBox(controller.pList[index],index);
                  },
                  childCount: controller.pList.length, // Number of grid items
                ),
              )),
        ],
      ),
    );
  }

  Widget serviceBox(ServiceProvider item,index) {
    return GestureDetector(
      onTap: () {
        Get.to(ProviderIntro(data: item));
      },
      child: Container(
        margin: EdgeInsets.only(left: 16.sp,right:16.sp),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(MediaQuery.of(context).platformBrightness==Brightness.light?item.image!:item.dark_image!,
              fit: BoxFit.fill,
              height: 7.h,
              width: 18.w,
            ),
          //  SizedBox(height: 1.h),
            SizedBox(
              width: 30.w,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(item.name??'',
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 12.0,
                      color: Theme.of(context).colorScheme.onTertiary),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBullets() {
    return Obx(() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          controller.bannerList.length,
          (index) => buildBullet(index),
        ),
      );
    });
  }

  Widget buildBullet(int index) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.sp),
      width: 2.w,
      height: 1.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: index == controller.currentIndex.value
            ? ColorConstants.primaryColor
            : Theme.of(context).colorScheme.primaryContainer,
      ),
    );
  }
}
