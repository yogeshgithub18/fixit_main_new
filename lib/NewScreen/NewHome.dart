import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../common/color_constants.dart';
import '../common/utils.dart';
import '../ui_screens/bottomSubPages/controller/profile_controller.dart';
import '../ui_screens/bottomSubPages/notifications.dart';
import 'DrawerFixit.dart';
import 'Favorites.dart';
import 'FixitHomeMain.dart';
import 'MyBookings.dart';
import 'NewAppBar.dart';
import 'SearchForServices.dart';

class FixitHomeScreen extends StatefulWidget {
  const FixitHomeScreen({Key? key}) : super(key: key);

  @override
  FixitHomeScreenState createState() => FixitHomeScreenState();
}

class FixitHomeScreenState extends State<FixitHomeScreen> {
  ProfileController controller = Get.put(ProfileController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getProfile();
  }
  int currentIndex = 0;

  final List<Widget> children =  [
    const FixitHome(),
    const SearchForServices(),
    const MyBookingsFixit(),
    const FavoritesTabBarScreen(),
  ];

  void onTabTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  BottomNavigationBarItem buildBottomNavigationBarItem(String assetName, String label, int index) {
    return BottomNavigationBarItem(
      icon: Container(
        padding: const EdgeInsets.only(bottom: 8),
        child: SizedBox(
          height: 25,
          width: 25,
          child: SvgPicture.asset(
            assetName,
            color: currentIndex == index ? ColorConstants.fixitGreenDark : Theme.of(context).colorScheme.tertiary,
            fit: BoxFit.scaleDown,
          ),
        ),
      ),
      label: label.toUpperCase(),
    );
  }

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  Widget drawerIcon = SvgPicture.asset(
    'assets/images/drawerIcon.svg',
    height: 15,
    width: 28,
    fit: BoxFit.fill,
  );

  void toggleDrawer() {
    scaffoldKey.currentState!.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: ColorConstants.primaryColor,
        leading: IconButton(
          icon: drawerIcon,
          onPressed: toggleDrawer,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: IconButton(
              icon: SvgPicture.asset(
                'assets/images/noti.svg',
                height: 25,
                width: 18,
                fit: BoxFit.fill,
              ),
              onPressed: () {
                Get.to(()=>const Notifications());
              },
            ),
          ),
        ],
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'FIXIT',
              style: TextStyle(
                fontSize: getHeadingTextFontSIze() + 3,
                color: ColorConstants.headerTextDark,
                fontWeight: FontWeight.w600,
                fontFamily: 'Aeonik',
                letterSpacing: 1,
              ),
            ),
          ],
        ),
      ),
      drawer: const DrawerFixitScreen(),
      backgroundColor: ColorConstants.fixitWhite,
      body: children[currentIndex],
      bottomNavigationBar: Container(
        decoration:  BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Theme.of(context).colorScheme.tertiary,
              width: .3,
            ),
          ),
        ),
        height: 80,
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          unselectedItemColor: Theme.of(context).colorScheme.tertiary,
          selectedItemColor: ColorConstants.fixitGreenDark,
          onTap: onTabTapped,
          currentIndex: currentIndex,
          items: [
            buildBottomNavigationBarItem('assets/images/HomeBottomIcon.svg', 'Home'.tr, 0),
            buildBottomNavigationBarItem('assets/images/SearchBottomIcon.svg', 'Search'.tr, 1),
            buildBottomNavigationBarItem('assets/images/BookingBottomIcon.svg', 'Bookings'.tr, 2),
            buildBottomNavigationBarItem('assets/images/FavoritesBottomIcon.svg', 'Favorites'.tr, 3),
          ],
          selectedLabelStyle: const TextStyle(
            fontFamily: 'Aeonik',
            fontSize: 13,
          ),
          unselectedLabelStyle: const TextStyle(
            fontFamily: 'Aeonik',
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}





