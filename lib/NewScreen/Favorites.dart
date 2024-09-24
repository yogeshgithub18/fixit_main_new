import 'package:fixit/backend/modal/service_provider_response.dart';
import 'package:fixit/ui_screens/bottomSubPages/controller/dashboardController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../backend/modal/fav_list_response.dart';
import '../common/base_image_network.dart';
import '../common/color_constants.dart';
import '../common/utils.dart';
import '../ui_screens/service/star_service.dart';
import 'AppTextFile.dart';
class FavoritesTabBarScreen extends StatefulWidget {
  const FavoritesTabBarScreen({super.key});

  @override
  State<FavoritesTabBarScreen> createState() => _FavoritesTabBarScreenState();
}

class _FavoritesTabBarScreenState extends State<FavoritesTabBarScreen> {
  DashBoardController controller=Get.find<DashBoardController>();
  bool isStarred = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getFavList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Obx(()=>
        //   SmartRefresher(
        // controller: controller.refreshFavController,
        // enablePullDown: true,
        // onLoading: (){
        //   controller.getFavList();
        // },
        // onRefresh: (){
        //   controller.getFavList();
        // },
        // child:
        controller.favList.isEmpty?Center(
          child: Text(
            'No Data'.tr,
            style: TextStyle(
                color: Theme.of(Get.context!).colorScheme.onTertiary,
                fontSize: 18),
          ),
        ) :ListView.builder(
        itemCount: controller.favList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: (){
              Get.to(()=>StartService(id:int.parse(controller.favList[index].categoriesId!),subId:controller.favList[index].id!,
                catName:controller.favList[index].category?.name??"",subCatName: controller.favList[index].subcategory?.name??"",
                image:controller.favList[index].subcategory?.image??"", price: controller.favList[index].subcategory?.price??"",
              ));
            },
            child: FavoritesCard(
              isStarred: true,
              data:controller.favList[index].subcategory!,
              onStarTap: ()async {
                await controller.addRemoveFav(int.parse(controller.favList[index].categoriesId!),int.parse(controller.favList[index].subcategoriesId!),0);
                controller.getFavList();
               },
            ),
          );
        })),
    //)
    );
  }
}

class FavoritesCard extends StatelessWidget {
  final bool isStarred;
  final Subcategory data;
  final VoidCallback onStarTap;

  const FavoritesCard({
    Key? key,
    required this.isStarred,
    required this.data,
    required this.onStarTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom:5.sp,left: 15.sp,right: 15.sp,top:15.sp),
      height: 17.h,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical:9),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: getBorderRadius13(),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: onStarTap,
            child: Icon(
              isStarred ? Icons.star : Icons.star_border,size: 28,
              color: isStarred ? ColorConstants.primaryColor :ColorConstants.fixitIcon,
            ),
          ),
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
                    link:data.image ?? '',
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
                   AppTexts.helveticaText16W500(
                     data.name??'',
                    textColor:Theme.of(context).colorScheme.onTertiary,
                  ),
                  SizedBox(
                    width: 56.sp,
                    height: 6.h,
                    child: AppTexts.helveticaText16W400(
                      data.description??'',
                      textColor: ColorConstants.fixitAddress,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    )
                  ),
                ],
              ),
              SizedBox(width:2.w,),
              Padding(
                padding:  EdgeInsets.only(top: 29.sp,left: 1.sp,right: 1.sp,bottom: 5.sp),
                child:  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  AppTexts.helveticaText16W500(
                    'Order Price',
                    textColor:Theme.of(context).colorScheme.onTertiary,
                    fontSize: 12,
                  ),
                 AppTexts.helveticaText16W800(
                  data.price==null?'0 IQD':'${data.price} IQD',
                  fontSize: 12,
                  )
                   ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
