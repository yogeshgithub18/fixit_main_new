import 'package:fixit/backend/api_end_points.dart';
import 'package:fixit/backend/base_api.dart';
import 'package:fixit/backend/modal/fav_list_response.dart';
import 'package:fixit/backend/modal/get_banner_data_model.dart';
import 'package:fixit/backend/modal/notification_model.dart';
import 'package:fixit/backend/modal/sub_categories_response_modal.dart';
import 'package:fixit/ui_screens/service/service_status_check.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../../../backend/modal/service_provider_response.dart';

class DashBoardController extends GetxController {
  RxInt currentIndex = 0.obs;
  RxList<ServiceProvider> pList = <ServiceProvider>[].obs;
  RxList<SubCatData> subCatData = <SubCatData>[].obs;
  RxList<SubCatData> subBanner = <SubCatData>[].obs;
  RxList<FavData> favList = <FavData>[].obs;
  late TextEditingController dateCtrl;
  RxInt notificationCount = 0.obs;
  late TextEditingController fromTimeCtrl;
  late TextEditingController toTimeCtrl;
  late TextEditingController descriptionCtrl;
  List<String> bookingList = ['Book Now', 'Schedule'];
  RxList<BannerData> bannerList = <BannerData>[].obs;
  RxList<SubbannerData> subBannerList = <SubbannerData>[].obs;
  Rx<BannerInformation> bannerInfo = BannerInformation().obs;
  bool selectedBooking = false;
  int bookingType = 1;
  bool selectedOption = false;
  final RefreshController refreshController = RefreshController(initialRefresh: false);
  final RefreshController refreshFavController = RefreshController(initialRefresh: false);

  getServiceProvider() async {
    bool loader=false;
    if(pList.isEmpty){
      loader=true;
    }
    await BaseAPI().get(url: ApiEndPoints().serviceProviders,showLoader: loader).then((value) {
      if (value?.statusCode == 200) {
        pList.value = ServiceProviderResponse.fromJson(value?.data).data ?? [];
      }
    });
  }

  getServiceSubProvider(int id) async {
    bool loader=true;
    subCatData.clear();
    Map<String, dynamic> params = {
      'category_id': id,
    };
    await BaseAPI().post(url: ApiEndPoints().serviceSubProviders,showLoader: loader,data: params).then((value) {
      if (value?.statusCode == 200) {
         subCatData.value = SubCategoriesResponse.fromJson(value?.data).data ?? [];
      }
    });
  }

  getSubBannerProvider(int id) async {
    bool loader=true;
    subBanner.clear();
    Map<String, dynamic> params = {
      'subbanner_id': id,
    };
    await BaseAPI().post(url: ApiEndPoints().serviceSubBannerCategory,showLoader: loader,data: params).then((value) {
      if (value?.statusCode == 200) {
        subBanner.value = SubCategoriesResponse.fromJson(value?.data).data ?? [];
      }
    });
  }

  getFavList() async {
    favList.value=[];
    await BaseAPI().get(url: ApiEndPoints().favList,showLoader:true).then((value) {
      if (value?.statusCode == 200) {
        refreshFavController.loadComplete();
        favList.value = FavListResponse.fromJson(value?.data).data ?? [];
      }
    });
  }

  getBanner() async {
    await BaseAPI().get(url: ApiEndPoints().getBanner,showLoader: false).then((value) {
      if (value?.statusCode == 200) {
        bannerList.value = GetBannerDataModel.fromJson(value?.data).data ?? [];
        subBannerList.value = GetBannerDataModel.fromJson(value?.data).subbannerData ?? [];
        bannerInfo.value = GetBannerDataModel.fromJson(value?.data).bannerInformation ??BannerInformation();
      }
    });
  }
  getNotificationCount() async {
    await BaseAPI().get(url: ApiEndPoints().notificationCount,showLoader: false).then((value) {
      if (value?.statusCode == 200) {
        notificationCount.value= Notification_count.fromJson(value?.data).data?[0].count??0;
      }
    });
  }
  createServiceRequest(id) async {
    Map<String, dynamic> params = {
      'service_category_id': id,
      'type': bookingType,
      'time_slot':
          "${fromTimeCtrl.text.trim().toString()}-${toTimeCtrl.text.trim().toString()}",
      'date': dateCtrl.text.trim().toString(),
      'description': descriptionCtrl.text.trim().toString()
    };
    await BaseAPI()
        .post(url: ApiEndPoints().createServiceRequest, data: params)
        .then((value) {
      if (value?.statusCode == 200) {
        descriptionCtrl.clear();
        Get.to(const CheckStatus());
        // pList.value = ServiceProviderResponse.fromJson(value?.data).data ?? [];
      }
    });
  }

  addRemoveFav(int catId,int subId,int index) async {
    Map<String, dynamic> params = {
      'categories_id': catId,
      'subcategories_id': subId,
    };
    await BaseAPI()
        .post(url: ApiEndPoints().setFav, data: params)
        .then((value) {
      if (value?.statusCode == 200) {
         pList.refresh();
      }
    });
  }

  DashBoardController() {
    dateCtrl = TextEditingController();
    toTimeCtrl = TextEditingController();
    fromTimeCtrl = TextEditingController();
    descriptionCtrl = TextEditingController();
  }
}
