import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../NewScreen/NewAppBar.dart';
import '../../common/base_image_network.dart';
import '../app_header.dart';

// ignore: must_be_immutable
class ProviderProfile extends StatefulWidget {
  String image;
  String name;
  String category;
  String description;
  ProviderProfile(
      {super.key,
      required this.image,
      required this.name,
      required this.category,
      required this.description});

  @override
  State<ProviderProfile> createState() => _ProviderProfileState();
}

class _ProviderProfileState extends State<ProviderProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(7.h),
            child: const NewAppHeader(
              title: 'Provider',
              showBackIcon: true,
              //isBackIcon: true,
            )),
        body: Padding(
          padding: EdgeInsets.only(top: 30.sp, left: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                clipBehavior:
                Clip.antiAliasWithSaveLayer,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle),
                // height: 10.h,
                width: 25.w,
                child: BaseImageNetwork(
                  fit: BoxFit.fill,
                  link: widget.image ??
                      '',
                  concatBaseUrl: false,
                  errorWidget: Image.asset(
                    "assets/images/profile.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // CircleAvatar(
              //   radius: 50,
              //   // backgroundImage: NetworkImage(widget.image),
              //   child: BaseImageNetwork(
              //     fit: BoxFit.cover,
              //     link: widget.image ??
              //         '',
              //     concatBaseUrl: false,
              //     errorWidget: Image.asset(
              //       "assets/images/profile.png",
              //       fit: BoxFit.cover,
              //     ),
              //   ),
              // ),
              // SizedBox(
              //   height: 2.h,
              // ),
              Text(
                widget.name,
                style: TextStyle(
                    fontSize: 20,
                    color: Theme.of(context).colorScheme.tertiary),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 1.h,
              ),
              Text(
                widget.category,
                style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(Get.context!).colorScheme.onTertiary),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 2.h,
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(5)),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Info'.tr,
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.tertiary,
                            fontSize: 16),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Text(
                          style: TextStyle(
                              color:
                                  Theme.of(context).colorScheme.onTertiary,
                              fontSize: 16),
                            widget.description),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
