import 'dart:convert';
import 'dart:developer';

import 'package:fixit/backend/api_end_points.dart';
import 'package:fixit/backend/base_api.dart';
import 'package:fixit/backend/modal/get_city_data_model.dart';
import 'package:fixit/backend/modal/get_country_data_model.dart';
import 'package:fixit/backend/modal/location_data_model.dart';
import 'package:fixit/common/base_overlays.dart';
import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class LocationController extends GetxController {
   TextEditingController streetNoCtrl= TextEditingController();
   TextEditingController streetNameCtrl= TextEditingController();
   TextEditingController areaPinCtrl= TextEditingController();
   TextEditingController cityCtrl=TextEditingController();
   Rx<TextEditingController> countryCtrl=TextEditingController().obs;
  RxList<LocationData>locationDataList =<LocationData> [].obs;
  List<CountryData> conutry = [];
  List<CityData> city = [];
  int selectedAddress = 0;
  int selectedValue = 1;

  bool isShowPredictionList = false;
  final markers = <Marker>{};

  List<Placemark> placemarks = [];


  TextEditingController addressCtrl = TextEditingController();

  getUserLocations() async {
    Map<String, dynamic> params = {};
    await BaseAPI().get(url: ApiEndPoints().getLocations, queryParameters: params).then((value) {
      if (value?.statusCode == 200) {
        locationDataList.clear();
        locationDataList.addAll(LocationDataModel.fromJson(value?.data).data ?? []);
      }
    });
    update();
  }

  getCountry() async {
    Map<String, dynamic> params = {};
    await BaseAPI().get(url: ApiEndPoints().getCountry, queryParameters: params)
        .then((value) {
      if (value?.statusCode == 200) {
        conutry.clear();
        conutry.addAll(GetCountryDataModel.fromJson(value?.data).data ?? []);
      }
    });
    update();
  }
  // getCityByCountry(countryId) async {
  //   Map<String, dynamic> params = {
  //     "country_id": countryId
  //   };
  //   log('Call Get City API......');
  //   await BaseAPI()
  //       .post(url: ApiEndPoints().getCityByCountry, data: params)
  //       .then((value) {
  //     if (value?.statusCode == 200) {
  //       city.clear();
  //       city.addAll(GetCityDataModel.fromJson(value?.data).data ?? []);
  //       cityCtrl.value.text = city[0].name.toString();
  //     }
  //   });
  //   update();
  // }

  addLocation(double lat,double long) async {
    Map<String, dynamic> params = {
      'street_no': streetNoCtrl.text.trim().toString(),
      'street_name': streetNameCtrl.text.trim().toString(),
      'location': addressCtrl.text,
      'city': cityCtrl.text.trim().toString(),
     // 'country': countryCtrl.value.text.trim().toString(),
      'pincode':"111111",
      'latitude':lat,
      'longitude': long,
    };
    await BaseAPI()
        .post(url: ApiEndPoints().addLocation, data: params)
        .then((value) {
      if (value?.statusCode == 200) {
        streetNoCtrl.clear();
        streetNameCtrl.clear();
        cityCtrl.clear();
        countryCtrl.value.clear();
        areaPinCtrl.clear();
        getUserLocations();
        locationDataList.refresh();
        Get.back();
        Get.back();
        BaseOverlays().showSnackBar(message: "Successfully".tr, title: "Success");
      }
    });
    update();
  }


  editLocation(id,double lat,double long) async {
    Map<String, dynamic> params = {
      'location_id': id,
      'street_no': streetNoCtrl.text.trim().toString(),
      'street_name': streetNameCtrl.text.trim().toString(),
      'location':addressCtrl.text,
      'city': cityCtrl.text.trim().toString(),
     // 'country': countryCtrl.value.text.trim().toString(),
      'pincode':"111111",
      'latitude':lat,
      'longitude': long,
    };
    await BaseAPI()
        .post(url: ApiEndPoints().editLocation, data: params)
        .then((value) {
      if (value?.statusCode == 200) {
        streetNoCtrl.clear();
        streetNameCtrl.clear();
        cityCtrl.clear();
        countryCtrl.value.clear();
        areaPinCtrl.clear();
        getUserLocations();
        Get.back();
        Get.back();
        BaseOverlays().showSnackBar(message: "Successfully".tr, title: "Success");
      }
    });
    update();
  }

  deleteLocations(id) async {
    Map<String, dynamic> params = {'location_id': id};
    await BaseAPI()
        .post(url: ApiEndPoints().deleteLocation, data: params)
        .then((value) {
      if (value?.statusCode == 200) {
        var index = locationDataList.indexWhere((element) => element.id == id);
        locationDataList.removeAt(index);
        BaseOverlays().showSnackBar(message: "Successfully".tr, title: "Success");
      }
    });
    update();
  }

  activateLocations(id) async {
    Map<String, dynamic> params = {'location_id': id};
    await BaseAPI()
        .post(url: ApiEndPoints().activateLocation, data: params)
        .then((value) {
      if (value?.statusCode == 200) {
        // var index = locationDataList.indexWhere((element) => element.id == id);

        getUserLocations();
      }
    });
    update();
  }

   String apiKey="AIzaSyAj56AD3gkd8uqpD77eeFEAYANu3e5JA18";
   Future<String> getPlaceName(double lat, double lng) async {
     final url = Uri.parse("https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$apiKey");

     final response = await http.get(url);
     print("response------------${response.body}");
     if (response.statusCode == 200) {
       final data = json.decode(response.body);
       if (data["status"] == "OK") {
         print("response------------${data["results"][0]["formatted_address"]}");
         List <String> names=data["results"][0]["formatted_address"].toString().split(',');
         if(names.length==1){
           return names[0];
         }else if(names.length==2){
           return "${names[0]},${names[1]}";
         }else{
           return "${names[0]},${names[1]},${names[2]}";
         }
       }
     }
     return "Place name not found";
   }

}
