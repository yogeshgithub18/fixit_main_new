import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../common/base_image_network.dart';
import '../common/color_constants.dart';
import '../common/utils.dart';
import '../ui_screens/auth/controller/login_controller.dart';
import '../ui_screens/bottomSubPages/controller/search_services_controller.dart';
import 'AppTextFile.dart';
import 'SubService.dart';

class SearchForServices extends StatefulWidget {
  const SearchForServices({super.key});

  @override
  State<SearchForServices> createState() => _SearchForServicesState();
}

class _SearchForServicesState extends State<SearchForServices> {
  ServicesController controller = Get.put(ServicesController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getServiceProvider();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15,),
        child: Column(
          children: [
            SizedBox(height: 2.5.h,),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: getBorderRadius13(),
              ),
              child: Padding(
                padding: EdgeInsets.only(top:11.sp,bottom:8.sp),
                child: TextField(
                  cursorColor:Theme.of(context).colorScheme.tertiary,
                  textInputAction: TextInputAction.next,
                  onChanged: (text){
                    controller.searchObjects(text);
                  },
                  style: TextStyle(
                    fontSize: getNormalTextFontSIze() + 1,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                  decoration: InputDecoration(
                    hintText: "Search for any type of services".tr,
                    prefixIcon: Padding(
                      padding:  EdgeInsets.only(bottom:10.sp),
                      child: SizedBox(
                          width: 21,
                          height: 21,
                          child: SvgPicture.asset('assets/images/searchIcon.svg',fit: BoxFit.scaleDown,)),
                    ),
                    hintStyle: TextStyle(
                      color: ColorConstants.fixitAddress,
                      fontFamily: 'Helvetica Neue',
                      fontWeight: FontWeight.normal,
                      fontSize: getNormalTextFontSIze(),
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            SizedBox(height: 2.6.h,),
            Obx(()=> Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(bottom: 10),
                itemCount: controller.searchResults.length,
                itemBuilder: (context, index) {
                  return  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SubService(index:index,id:controller.searchResults[index].id??0,
                          name:controller.searchResults[index].name??''))
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 14.sp),
                      height: 14.h,
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        borderRadius: getBorderRadius13(),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right:8),
                                child:  Container(
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  height: 8.h,
                                  width: 10.w,
                                  padding: EdgeInsets.all(2.sp),
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    // color: ColorConstants.scaffoldDark,
                                  ),
                                  child: BaseImageNetwork(
                                    link:controller.searchResults[index].image ?? '',
                                    concatBaseUrl: false,
                                    fit: BoxFit.cover,
                                    errorWidget: Image.asset(
                                      "assets/images/profile.png",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width:50.w,
                                    child: AppTexts.helveticaText16W500(
                                      controller.searchResults[index].name??'',
                                      textColor:Theme.of(context).colorScheme.onTertiary,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 56.sp,
                                    height: 6.h,
                                    child: AppTexts.helveticaText16W400(
                                      controller.searchResults[index].description??"",
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      textColor: ColorConstants.fixitAddress,
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding:  EdgeInsets.only(top: 29.sp),
                                child:  Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppTexts.helveticaText16W500(
                                      'Order Price',
                                      textColor:Theme.of(context).colorScheme.onTertiary,
                                      fontSize: 12,
                                    ),
                                     AppTexts.helveticaText16W800(
                                       controller.searchResults[index].price==null?'0 IQD':'${controller.searchResults[index].price} IQD',
                                      fontSize: 12,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
               ),
             )
            )
          ],
        ),
      ),
    );
  }
}