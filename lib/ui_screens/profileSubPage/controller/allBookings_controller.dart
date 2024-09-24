import 'package:fixit/backend/api_end_points.dart';
import 'package:fixit/backend/modal/all_bookings_data_model.dart';
import 'package:fixit/backend/modal/booking_detail_data_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../../../backend/base_api.dart';
import '../../../common/base_overlays.dart';
import '../../../main.dart';

class AllBookingsController extends GetxController {
  RxList<Data> allBookingdataList = <Data>[].obs;
  BookingDetailData? bookingDetailData;
  final ratingFormkey = GlobalKey<FormState>();
  var rating = 1.0;
  RxInt selectedIndex = 0.obs;
  late TextEditingController commentCtrl;
  RxInt page = 1.obs;
  final RefreshController refreshController = RefreshController(initialRefresh: false);
  getAllBookingsData({String ? refreshType})async {
    bool showLoader=false;
    if (refreshType == 'refresh' || refreshType == null) {
      allBookingdataList.clear();
      refreshController.loadComplete();
      page.value = 1;
      showLoader=true;
    } else if (refreshType == 'load') {
      showLoader=false;
      page.value++;
    }
    int status = selectedIndex.value == 0 ? 0 : selectedIndex.value == 1 ? 4 : selectedIndex.value == 2 ? 1 : selectedIndex.value == 3 ? 2 : 3;
    Map<String, dynamic> params = {'status': status,
      "limit":apiItemLimit,
      "page":page.value.toString(),};
    print('getAllBookingsData.... ');
    await BaseAPI()
        .get(url: ApiEndPoints().allBookings, queryParameters: params,showLoader: showLoader)
        .then((value) {
      if (value?.statusCode == 200) {
        AllBookingsDataModel allBookingsDataModel=AllBookingsDataModel.fromJson(value?.data);
        if (refreshType == 'refresh') {
          allBookingdataList.clear();
          refreshController.loadComplete();
          refreshController.refreshCompleted();
        } else if ((allBookingsDataModel.data ?? []).isEmpty &&
            refreshType == 'load') {
          refreshController.loadNoData();
        }
        else if (refreshType == 'load') {
          refreshController.loadComplete();
        }
        allBookingdataList.addAll(allBookingsDataModel.data ?? []);
      }
    });
    // update();
  }

  getActiveBookingsData(status) async {
    Map<String, dynamic> params = {'status': status};
    await BaseAPI()
        .get(url: ApiEndPoints().allBookings, queryParameters: params)
        .then((value) {
      if (value?.statusCode == 200) {
        allBookingdataList.clear();
        allBookingdataList
            .addAll(AllBookingsDataModel.fromJson(value?.data).data ?? []);
      }
    });
    update();
  }

  getBookingDetailData(id) async {
    bookingDetailData = BookingDetailData();
    Map<String, dynamic> params = {'service_request_id': id};
    print('Param... ${params}');
    await BaseAPI()
        .post(url: ApiEndPoints().bookingDetail, data: params)
        .then((value) {
      if (value?.statusCode == 200) {
        bookingDetailData = BookingDetailDataModel.fromJson(value?.data).data;
        print("Demo data--${bookingDetailData?.serviceProviderStatus}");
      }
    });
    update();
  }

  confirmBookingAPI(id) async {
    Map<String, dynamic> params = {'service_request_id': id};
    await BaseAPI()
        .post(url: ApiEndPoints().confirmBooking, data: params)
        .then((value) {
      if (value?.statusCode == 200) {
        bookingDetailData = BookingDetailDataModel.fromJson(value?.data).data;
      }
    });
    update();
  }

  cancelBookingAPI(id) async {
    Map<String, dynamic> params = {'service_request_id': id};
    await BaseAPI()
        .post(url: ApiEndPoints().cancelBooking, data: params)
        .then((value) {
      print("data---:${value?.data['status']}");
      if (value?.data['status']) {
        BaseOverlays().showSnackBar(message: value?.data['message'], title: "Success".tr);
      }
    });
    update();
  }

  giveRating(id) async {
    Map<String, dynamic> params = {
      'service_request_id': id,
      'rating': rating,
      'rating_comment': commentCtrl.text.trim().toString()
    };
    await BaseAPI().post(url: ApiEndPoints().giveRating, data: params).then((value) {
      if (value?.statusCode == 200) {
        Get.back();
         BaseOverlays().showSnackBar(
            message: value?.data['message'] ?? '', title: "Success");
      }
    });
    update();
  }

  String formatDateString(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    String formattedDate = DateFormat('dd-MM-yyyy').format(dateTime.toLocal());
    return formattedDate;
  }

  String formatTimeString(String timeString) {
    DateTime dateTime = DateTime.parse(timeString);
    String formattedTime = DateFormat('hh:mma').format(dateTime.toLocal());
    return formattedTime;
  }

  AllBookingsController() {
    commentCtrl = TextEditingController();
  }
}
