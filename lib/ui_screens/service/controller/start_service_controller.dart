import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../backend/api_end_points.dart';
import '../../../backend/base_api.dart';
import '../../../backend/modal/location_data_model.dart';
import '../service_status_check.dart';

class StartServiceController extends GetxController{
  late TextEditingController dateCtrl;
  late TextEditingController fromTimeCtrl;
  late TextEditingController toTimeCtrl;
  late TextEditingController descriptionCtrl;
  List<String> bookingList = ['Book Now', 'Schedule'];
  RxBool selectedBooking = false.obs;
  RxInt bookingType = 1.obs;
  RxBool selectedOption = true.obs;
  RxBool isFillDescription = true.obs;
  RxString activeAddress=''.obs;
  RxDouble lat=0.0.obs;
  RxDouble long=0.0.obs;
  RxList<LocationData> locationDataList = <LocationData>[].obs;
  StartServiceController(){
    dateCtrl = TextEditingController();
    toTimeCtrl = TextEditingController();
    fromTimeCtrl = TextEditingController();
    descriptionCtrl = TextEditingController();
  }
  DateTime dateCheck = DateTime.now();


  createServiceRequest(id,subId) async {
    Map<String, dynamic> params = {
      'service_category_id': id,
      'service_subcategory_id':subId,
      'type': bookingType.value,
      'time_slot': "${fromTimeCtrl.text.trim().toString()}-${toTimeCtrl.text.trim().toString()}",
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

 Future<void> getUserLocations() async {
    Map<String, dynamic> params = {};
    await BaseAPI()
        .get(url: ApiEndPoints().getLocations, queryParameters: params)
        .then((value) {
      if (value?.statusCode == 200) {
        locationDataList.clear();
        locationDataList.addAll(LocationDataModel.fromJson(value?.data).data ?? []);
        print("--->>${locationDataList.length}");
      }
    });
    update();
  }
}