import 'package:fixit/backend/modal/service_provider_response.dart';
import 'package:fixit/common/base_image_network.dart';
import 'package:fixit/ui_screens/service/provider_intro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../common/color_constants.dart';
import '../../storage/base_shared_preference.dart';
import '../../storage/sp_keys.dart';
import 'controller/search_services_controller.dart';

class SearchServices extends StatefulWidget {
  const SearchServices({super.key});

  @override
  State<SearchServices> createState() => _SearchServicesState();
}

class _SearchServicesState extends State<SearchServices> {
  ServicesController controller = Get.put(ServicesController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getServiceProvider();
    init();
  }

  init() async {
    final String token = await BaseSharedPreference().getString(SpKeys().apiToken) ?? "";
    print("token--$token");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [
          SliverAppBar(
            floating: false,
            pinned: true,
            primary: true,
            elevation: 0.0,
            title: Padding(
              padding: EdgeInsets.only(bottom: 10.sp, top: 10.sp),
              child: Container(
                margin: EdgeInsets.all(5.sp),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  style: TextStyle(color: Theme.of(context).colorScheme.onTertiary),
                  onChanged: (text) {
                    controller.searchObjects(text);
                  },
                  decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.search,
                        color: ColorConstants.primaryColor,
                      ),
                      border: InputBorder.none,
                      hintText: 'Search Services'.tr,
                      hintStyle: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                      )),
                ),
              ),
            ),
          )
        ];
      },
      body: Obx(() {
        List<ServiceProvider> displayList = controller.searchResults.isNotEmpty ? controller.searchResults : [];
        return displayList.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                child: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(25)),
                  child: ListView.builder(
                    shrinkWrap: true,
                    padding:
                        EdgeInsets.symmetric(vertical: 3.h, horizontal: 1.w),
                    itemCount: displayList.length,
                    itemBuilder: (context, index) {
                      ServiceProvider object = displayList[index];
                      return GestureDetector(
                        onTap: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          Get.to(ProviderIntro(
                            data: object,
                          ));
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: ListTile(
                            leading: BaseImageNetwork(
                              link: object.image,
                              fit: BoxFit.fill,
                              height: 7.h,
                              width: 18.w,
                            ),
                            title: Text(object.name ?? '',
                                maxLines: 2,overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onTertiary,
                                )),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              )
            : Padding(
                padding: EdgeInsets.only(top: 60.sp),
                child: SizedBox(
                  width: 90.w,
                  height: 35.h,
                  child: Padding(
                    padding: EdgeInsets.all(20.sp),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          "assets/images/search.svg",
                          width: 8.w,
                          height: 8.h,
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Text(
                          "No Search Result".tr,
                          style: TextStyle(
                              fontSize: 22,
                              color: Theme.of(context).colorScheme.onTertiary),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        // Text(
                        //   "Lorem Ipsum is simply dummy text of the printing and typesetting. Lorem Ipsum is simply.",
                        //   textAlign: TextAlign.center,
                        //   style: TextStyle(
                        //       fontSize: 16,
                        //       color: Theme.of(context)
                        //           .colorScheme
                        //           .onTertiary),
                        // )
                      ],
                    ),
                  ),
                ),
              );
      }),
    ));
  }
}
