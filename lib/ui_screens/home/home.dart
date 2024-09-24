import 'package:fixit/common/color_constants.dart';
import 'package:fixit/ui_screens/bottomSubPages/dashBoard.dart';
import 'package:fixit/ui_screens/bottomSubPages/my_profile.dart';
import 'package:fixit/ui_screens/bottomSubPages/notifications.dart';
import 'package:fixit/ui_screens/bottomSubPages/search_services.dart';
import 'package:fixit/ui_screens/bottomSubPages/settings.dart';
import 'package:fixit/ui_screens/home/home_controller.dart';
import 'package:fixit/ui_screens/profileSubPage/my_bookings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../bottomSubPages/controller/dashboardController.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // DashBoardController controller = Get.put(DashBoardController());
  HomeController controller=Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      body:  buildPages(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: controller.currentIndex.value,
        elevation: 0.0,
        selectedFontSize:1,
        unselectedFontSize:1,
        enableFeedback: true,
        onTap: (index) {
          controller.currentIndex.value=index;
        },
        backgroundColor:Theme.of(context).scaffoldBackgroundColor,
        type:BottomNavigationBarType.fixed,
        items: [
          createBottomNavItem(context,Icons.search, 0),
          createBottomNavItem(context,Icons.home_repair_service, 1),
          createBottomNavItem(context,Icons.home, 2),
          createBottomNavItem(context,Icons.notifications, 3),
          createBottomNavItem(context,Icons.person, 4),
        ],
      ),
    ));
  }

  BottomNavigationBarItem createBottomNavItem(BuildContext context,IconData iconData, int index) {
    return BottomNavigationBarItem(
      icon:Obx(() => Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          if(index==3)
          Stack(
            alignment: Alignment.topRight,
            children: [
              Icon(iconData, color:controller.currentIndex.value == index? ColorConstants.primaryColor:Theme.of(context).colorScheme.tertiary,size: 25.sp,),
              Visibility(
                visible: Get.find<DashBoardController>().notificationCount>0,
                 child: Container(
                    width:5.w,
                    height:2.h,
                    decoration:BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color:Theme.of(context).colorScheme.primaryContainer
                    ),
                    child: Center(child:Text(Get.find<DashBoardController>().notificationCount.toString(),style: TextStyle(color: Colors.red,fontSize: 14.sp,fontWeight: FontWeight.bold),))),
               ),
            ],
          ),
          if(index!=3)
            Icon(iconData, color:controller.currentIndex.value == index? ColorConstants.primaryColor:Theme.of(context).colorScheme.tertiary,size: 25.sp,),
           controller.currentIndex.value == index? Container(
                width: 1.w,
                height: 1.h,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: ColorConstants.primaryColor,
                ),
            ):const SizedBox.shrink(),
        ]
      ),
      ),
      label: '',
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    );
  }

  Widget buildPages() {
    switch (controller.currentIndex.value) {
      case 0:
        return const SearchServices();
      case 1:
        return const MyBookings();
      case 2:
        return const DashBoard();
        case 3:
        return const Notifications();
        case 4:
        return const MyProfile();
      default:
        return const DashBoard();
    }
  }
}
