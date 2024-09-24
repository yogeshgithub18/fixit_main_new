import 'package:fixit/backend/modal/service_provider_response.dart';
import 'package:fixit/backend/modal/sub_categories_response_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../common/base_image_network.dart';
import '../common/color_constants.dart';
import '../common/utils.dart';
import '../ui_screens/bottomSubPages/controller/dashboardController.dart';
import '../ui_screens/service/star_service.dart';
import 'AppTextFile.dart';
import 'NewAppBar.dart';

class SubService extends StatefulWidget {
  final String name;
  final int id;
  final int index;
   const SubService({super.key,required this.name,required this.id,required this.index});

  @override
  State<SubService> createState() => _SubServiceState();
}

class _SubServiceState extends State<SubService> {
  DashBoardController controller = Get.find<DashBoardController>();
  @override
  void initState() {
    // TODO: implement initState
     controller.getServiceSubProvider(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(7.h),
          child: const NewAppHeader(
            title: 'FIXIT',
            showBackIcon: true,
          )),
      body:Obx(()=>  Container(
        margin: const EdgeInsets.symmetric(horizontal: 15,),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 1.5.h,),
            Padding(
              padding:  EdgeInsets.only(left:10.sp),
              child: AppTexts.helveticaText16W500(
                 widget.name??'',
                textColor: Theme.of(context).colorScheme.tertiary,
                fontSize: 18,
                 ),
            ),
            SizedBox(height: 2.h,),
            Expanded(
              child: controller.subCatData.isEmpty?Center(
                child: Text(
                  'No Data'.tr,
                  style: TextStyle(
                      color: Theme.of(Get.context!).colorScheme.onTertiary,
                      fontSize: 18),
                ),
              ) :ListView.builder(
                itemCount: controller.subCatData.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: (){
                      Get.to(()=>StartService(id:widget.id,subId:controller.subCatData[index].id!,
                        catName:widget.name??"",subCatName: controller.subCatData[index].name??"",
                        image:controller.subCatData[index].image??"",
                        price:controller.subCatData[index].price??""
                      ));
                    },
                    child:SubServCard(
                      data:controller.subCatData[index],
                      isSubStarred:controller.subCatData[index].isFavourite==1,
                      onStarTap: () {
                         controller.subCatData[index].isFavourite=controller.subCatData[index].isFavourite==1?0:1;
                         controller.subCatData.refresh();
                         controller.addRemoveFav(widget.id,controller.subCatData[index].id!, index);
                      },),
                  );
                },

              ),
            )
          ],
        ),
      ),
    ));
  }
}

class SubServCard extends StatefulWidget {
  final VoidCallback onStarTap;
  final bool isSubStarred;
  final SubCatData data;
  const SubServCard({
    Key? key,
    required this.onStarTap, required this.isSubStarred,required this.data
  }) : super(key: key);

  @override
  State<SubServCard> createState() => _SubServCardState();
}

class _SubServCardState extends State<SubServCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 14.sp),
      height: 17.h,
      width: Get.width,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: getBorderRadius13(),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: widget.onStarTap,
                child: Icon(
                  widget.isSubStarred ? Icons.star : Icons.star_border,size: 28,
                  color: widget.isSubStarred ? ColorConstants.primaryColor :ColorConstants.fixitIcon,
                ),
              ),
              SizedBox(width: 5,),
              GestureDetector(
                onTap: (){
                  showInfoBottomSheet(context,widget.data.description??"");
                },
                child: Icon(
                   Icons.info,size: 28,
                  color:ColorConstants.primaryColor,
                ),
              ),
            ],
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
                    link:widget.data.image ?? '',
                    fit: BoxFit.cover,
                    concatBaseUrl: false,
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
                    widget.data.name??'',
                    textColor: Theme.of(context).colorScheme.tertiary,
                  ),
                  SizedBox(
                    width: 56.sp,
                    height: 6.h,
                    child:  AppTexts.helveticaText16W400(
                      widget.data.description??'',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      textColor: ColorConstants.fixitAddress,
                     ),
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
                       textColor: Theme.of(context).colorScheme.tertiary,
                      fontSize: 12,
                       ),
                   AppTexts.helveticaText16W800(
                    widget.data.price==null?'0 IQD':'${widget.data.price} IQD',
                   fontSize: 12,
                  )  ,
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void showInfoBottomSheet(BuildContext context,String text) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          width: Get.width,
          child: Column(
            mainAxisSize: MainAxisSize.min, // Makes the bottom sheet take only necessary space
            children: <Widget>[
              AppTexts.helveticaText16W500(
                'Description',
                textColor: Theme.of(context).colorScheme.tertiary,
                fontSize: 20,
              ),
              SizedBox(height: 10),
              AppTexts.helveticaText16W500(
                text,
                textColor: Theme.of(context).colorScheme.tertiary,
                fontSize: 16,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Closes the bottom sheet
                },
                child: Text('Close'),
              ),
            ],
          ),
        );
      },
    );
  }
}