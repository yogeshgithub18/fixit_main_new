import 'package:fixit/Routes/app_routes.dart';
import 'package:fixit/ui_screens/home/home_controller.dart';
import 'package:fixit/ui_screens/profileSubPage/my_bookings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../common/bordered_button.dart';
import '../app_header.dart';

class CheckStatus extends StatefulWidget {
  const CheckStatus({super.key});

  @override
  State<CheckStatus> createState() => _CheckStatusState();
}

class _CheckStatusState extends State<CheckStatus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(7.h),
            child: const AppHeader(
              title: '',
              showBackIcon: true,
              isBackIcon: true,
            )),
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          SvgPicture.asset("assets/images/completed.svg"),
          Text(
            "Request Sent".tr,
            style: TextStyle(
              fontSize: 25,
              color: Theme.of(Get.context!).colorScheme.tertiary,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 1.h,
          ),
          Text(
            "Your service request has been sent \n successfully with us. Our team will \n get back to you soon with service \n provider.".tr,
            style: TextStyle(
                fontSize: 18,
                color: Theme.of(Get.context!).colorScheme.onTertiary),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 2.h,
          ),
          GestureDetector(
              onTap: () {
                Get.back();
                Get.back();
                Get.back();
                Get.find<HomeController>().currentIndex.value=1;
               //Get.offAllNamed(Routes.home);
              },
              // onTap: () => Get.dialog(
              //       AlertDialog(
              //         shape: RoundedRectangleBorder(
              //             borderRadius: BorderRadius.circular(10)),
              //         title: Center(child: Text('Request Status')),
              //         content: Text(
              //           'We are processing your request.\n Please revisit in a while.\n Thank you',
              //           textAlign: TextAlign.center,
              //           style: TextStyle(
              //               color:
              //                   Theme.of(Get.context!).colorScheme.onTertiary),
              //         ),
              //         actions: [
              //           TextButton(
              //             onPressed: () {
              //               // Close the dialog
              //               Get.back();
              //             },
              //             child: Text('OK'),
              //           ),
              //           TextButton(
              //             style: ButtonStyle(
              //               backgroundColor: MaterialStatePropertyAll(
              //                   ColorConstants.primaryColor),
              //               elevation: MaterialStatePropertyAll(1),
              //             ),
              //             onPressed: () {
              //               Get.back();
              //               Get.back();
              //               Get.to(ConfirmService());
              //             },
              //             child: Text(
              //               'Go to Service',
              //               style: TextStyle(color: ColorConstants.white),
              //             ),
              //           ),
              //         ],
              //       ),
              //     ),

              child: BorderedButton(
                width: 1,
                text: "Ok".tr.toUpperCase(),
                isReversed: true,
              ))
        ]));
  }
}
