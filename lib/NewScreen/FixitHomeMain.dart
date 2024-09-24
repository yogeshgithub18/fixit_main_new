import 'package:fixit/NewScreen/SubBannerService.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../common/base_image_network.dart';
import '../common/color_constants.dart';
import '../common/utils.dart';
import '../ui_screens/bottomSubPages/controller/dashboardController.dart';
import 'AppTextFile.dart';
import 'SubService.dart';

class FixitHome extends StatefulWidget {
  const FixitHome({super.key});

  @override
  FixitHomeState createState() => FixitHomeState();
}

class FixitHomeState extends State<FixitHome> {
  int _current = 0;
  final CarouselController _controller = CarouselController();
  DashBoardController controller = Get.put(DashBoardController());

  @override
  void initState() {
    super.initState();
    controller.getServiceProvider();
    controller.getBanner();
    controller. getNotificationCount();
  }

  refresh(){
    controller.getServiceProvider();
    controller.getBanner();
    controller. getNotificationCount();
    controller.refreshController.loadComplete();
    controller.refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SmartRefresher(
        controller: controller.refreshController,
        enablePullDown: true,
        //enablePullUp: true,
        onLoading: (){
      refresh();
    },
    onRefresh: (){
    refresh();
    },
    child: SingleChildScrollView(
        child:Obx(()=>
            Column(
              children: [
            SizedBox(height: 2.h),
            Stack(
              children: [
                CarouselSlider(
                  items: controller.bannerList.map((item) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: ClipRRect(
                            borderRadius: getBorderRadius13(),
                            child: BaseImageNetwork(
                              width:Get.width,
                             // height:30.h,
                              link:item.image ?? '',
                              concatBaseUrl: false,
                              fit: BoxFit.fill,
                              errorWidget: Image.asset(
                                "assets/images/profile.png",
                                fit: BoxFit.cover,
                              ),
                            ),
                         ),
                      )).toList(),
                  carouselController: _controller,
                  options: CarouselOptions(
                    aspectRatio: 20 / 9,
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
                      //controller.currentIndex.value=index;
                      setState(() {
                        _current = index;
                      });
                    },
                  ),
                ),
                // Positioned(
                //   bottom: 20,
                //   left: 50,
                //   right: 100,
                //   child: AppTexts.aeonikText16W500(
                //     textList[_current],
                //     fontSize: 24,
                //     textColor: ColorConstants.headerTextDark,
                //     maxLines: 2,
                //     textAlign: TextAlign.left,
                //   ),
                // ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: controller.bannerList.asMap().entries.map((entry) {
                      return GestureDetector(
                        onTap: () => _controller.animateToPage(entry.key),
                        child: Container(
                          width: 8.0,
                          height: 8.0,
                          margin: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 4.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: (Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? ColorConstants.headerTextDark
                                    : Colors.black)
                                .withOpacity(_current == entry.key ? 0.9 : 0.4),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            SizedBox(height:.5.h,),
            controller.subBannerList.isEmpty?const SizedBox():Container(
              padding: EdgeInsets.only(left: 16.sp,right:16.sp,top: 10.sp),
              height: 110,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: controller.subBannerList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(left:3.0,right:3),
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SubBannerService(index:index,id:controller.subBannerList[index].id??0, name:''))
                        );
                      },
                      child: PromotionCard(
                        length:controller.subBannerList.length,
                        imageUrl: controller.subBannerList[index].image!,
                        text: controller.subBannerList[index].title??"",
                        subText: controller.subBannerList[index].subtitle??"",
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height:.5.h,),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15,vertical:10),
              child: GridView.builder(
                shrinkWrap: true,
                itemCount: controller.pList.length,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 18.sp,
                  mainAxisSpacing: 15.sp,
                  childAspectRatio: 48 / 50,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return   GestureDetector(
                    onTap: () async{
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SubService(index:index,id:controller.pList[index].id??0,
                           name:controller.pList[index].name??''))
                     );
                    },
                    child:ServiceCard(
                        text: controller.pList[index].name??"",
                        imagename: MediaQuery.of(context).platformBrightness==Brightness.light?controller.pList[index].image!:controller.pList[index].dark_image!),
                  );
                },
              ),
            ),
                      ],
                    )),
      ),
    ));
  }
}

class PromotionCard extends StatelessWidget {
  final String imageUrl;
  final String text;
  final String subText;
  final int length;

  const PromotionCard({super.key, required this.imageUrl, required this.text, required this.subText,required this.length});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 15.sp,right:15.sp,bottom: 12.sp,),
      width:length==1?92.sp:60.sp,
      decoration: BoxDecoration(
        borderRadius: getBorderRadius13(),
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           AppTexts.aeonikText16W500(
            text,
            fontSize: 20,
            textColor: ColorConstants.headerTextDark,
          ),
           SizedBox(
             width: 50.sp,
             child: AppTexts.aeonikText16W500(
               subText,
             fontSize: 16,
             maxLines: 2,
             overflow: TextOverflow.ellipsis,
             textColor: ColorConstants.headerTextDark,
             ),
           ),
        ],
      ),
    );
  }
}

class ServiceCard extends StatelessWidget {
  final String text;
  final String imagename;

  const ServiceCard({super.key, required this.text, required this.imagename});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10.sp, right: 10.sp, bottom: 5.sp, top: 15.sp),
      decoration: BoxDecoration(
        borderRadius: getBorderRadius13(),
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height:25.sp,
            width: 25.sp,
            child: Image.network(
              imagename,
              errorBuilder: (context, error, stackTrace) {
                return const Center(
                  child: Icon(
                    Icons.error,
                    color: Colors.blueGrey,
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 1.h),
          AppTexts.helveticaText16W400(
            text,
            fontSize: 14,
            maxLines: 2,
            textColor: Theme.of(context).colorScheme.tertiary,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
