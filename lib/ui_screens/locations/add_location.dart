import 'dart:convert';

import 'package:fixit/common/bordered_button.dart';
import 'package:fixit/ui_screens/locations/controller/location_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../NewScreen/NewAddAddress.dart';
import '../../NewScreen/NewAppBar.dart';
import '../../common/base_overlays.dart';
import '../../common/color_constants.dart';
import '../../common/utils.dart';
import '../app_header.dart';
import 'package:http/http.dart'as http;
class AddLocation extends StatefulWidget {
  final bool? isEditLocation;
  final String? streetNo;
  final String? streetName;
   String? latitude;
   String? longitude;
   String? location;
  final String? pincode;
  final String? city;
  final String? country;
  final int? locationId;
   AddLocation(
      {super.key,
      this.isEditLocation = false,
      this.streetName,
      this.latitude,
      this.longitude,
      this.location,
      this.locationId,
      this.pincode,
      this.city,
      this.country,
      this.streetNo});

  @override
  State<AddLocation> createState() => _AddLocationState();
}

class _AddLocationState extends State<AddLocation> {
  LocationController controller = Get.find<LocationController>();

   GoogleMapController ? mapController;
  LatLng ? selectedPosition;
  TextEditingController searchController = TextEditingController();
  Set<Marker> markers = {};
  List<Location> _locations = [];

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (widget.isEditLocation == true) {
        selectedPosition=LatLng(double.parse(widget.latitude!),double.parse(widget.longitude!)) ;
        setState(() {

        });
        Future.delayed(Duration(seconds: 1),(){
          markers.clear();
          markers.add(
            Marker(
              markerId: const MarkerId('selected_location'),
              position: selectedPosition!,
            ),
          );
          mapController?.animateCamera(CameraUpdate.newLatLng(selectedPosition!));
          setState(() {});
          controller.update();
        });
        setData();
      } else {
        controller.selectedValue = 1;
        controller.streetNoCtrl.clear();
        controller.streetNameCtrl.clear();
        controller.cityCtrl.clear();
        controller.countryCtrl.value.clear();
        controller.areaPinCtrl.clear();
        getLocation();
       }
     }
    );

   // init();
    super.initState();
  }

  void getLocation() async {
    await determinePosition().then((value) async {
      print("print---$value");//Latitude: 26.8506002, Longitude: 75.7616506
      setState(() {
        selectedPosition = LatLng(
          value.latitude,
          value.longitude,
        );
        markers.clear();
        markers.add(
          Marker(
            markerId: const MarkerId('selected_location'),
            position: selectedPosition!,
          ),
        );
        mapController?.animateCamera(CameraUpdate.newLatLng(selectedPosition!));
      });
      _handleMapTap(LatLng(value.latitude, value.longitude));
      //controller.addressCtrl.text =await controller.getPlaceName(value.latitude,value.longitude,);
    });
  }

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      permission = await Geolocator.requestPermission();
    }

    permission = await Geolocator.checkPermission();
    print("permission--$permission");
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        serviceEnabled = await Geolocator.isLocationServiceEnabled();
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
  }


  void _searchLocations(String input) async {
    final response = await http.get(Uri.parse(
        'https://maps.googleapis.com/maps/api/place/textsearch/json?query=$input&key=AIzaSyDgfrj84TSGdkHOwkjMr6aWd4QIY8UhpGI'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      debugPrint("----${data}");
      setState(() {
        _locations = (data['results'] as List).map((result) => Location.fromJson(result)).toList();
      });
    }
  }

  Future<void> _handleMapTap(LatLng location) async {
    print("Location----${location.latitude}");
    print("Location----${location.longitude}");
    String formattedLatitude = location.latitude.toStringAsFixed(7);
    String formattedLongitude = location.longitude.toStringAsFixed(7);
    double latitude = double.parse(formattedLatitude);
    double longitude = double.parse(formattedLongitude);
    setState(() {
      selectedPosition = LatLng(
        latitude,
        longitude,
      );
      markers.clear();
      markers.add(
        Marker(
          markerId: const MarkerId('selected_location'),
          position: selectedPosition!,
        ),
      );
      mapController?.animateCamera(CameraUpdate.newLatLng(selectedPosition!));
    });
    try{
      List<Placemark> ? placemarks = await placemarkFromCoordinates(latitude!, longitude!,);
      String address="";
      if (placemarks != null && placemarks.isNotEmpty) {
        Placemark placemark = placemarks[0];
        if (placemark.name != null && placemark.name!.isNotEmpty) {
          print("place--1-${placemark.name}");
          // address += placemark.name! + ', ';
        }
        if (placemark.subThoroughfare != null &&
            placemark.subThoroughfare!.isNotEmpty) {
          print("place--2-${placemark.subThoroughfare}");
          address += placemark.subThoroughfare! + ', ';
        }
        if (placemark.thoroughfare != null &&
            placemark.thoroughfare!.isNotEmpty) {
          print("place--3-${placemark.thoroughfare}");
          address += placemark.thoroughfare! + ', ';
        }
        if (placemark.subLocality != null &&
            placemark.subLocality!.isNotEmpty) {
          print("place-4--${placemark.subLocality}");
          address += placemark.subLocality! + ', ';
        }
        if (placemark.locality != null && placemark.locality!.isNotEmpty) {
          print("place-5--${placemark.locality}");
          address += placemark.locality! + ', ';
        }
        if (placemark.administrativeArea != null &&
            placemark.administrativeArea!.isNotEmpty) {
          address += placemark.administrativeArea! + ' ';
        }
        if (placemark.postalCode != null && placemark.postalCode!.isNotEmpty) {
          print("code---${placemark.postalCode}");
           address += placemark.postalCode! + ', ';
        }
        if (placemark.country != null && placemark.country!.isNotEmpty) {
          print("country---${placemark.country}");
           address += placemark.country!;
        }
        // Remove trailing comma if present
        if (address.isNotEmpty && address.endsWith(', ')) {
          address = address.substring(0, address.length - 2);
        }
        controller.addressCtrl.text =address;
      }else{
        controller.addressCtrl.text =await controller.getPlaceName(latitude,longitude);
      }
    }catch(e){
      controller.addressCtrl.text =await controller.getPlaceName(latitude,longitude);
    }
    print("print- address--${controller.addressCtrl.text}");
  }

  void setData() async {
    controller.streetNoCtrl.text = widget.streetNo ?? '';
    controller.streetNameCtrl.text = widget.streetName ?? '';
    controller.areaPinCtrl.text = widget.pincode ?? '';
    controller.cityCtrl.text = widget.city ?? '';
    controller.countryCtrl.value.text = widget.country ?? '';
    controller.addressCtrl.text = widget.location ?? '';
    print("--${widget.latitude!}");
    print("--${widget.longitude!}");
  }

  @override
  void dispose() {
    controller.placemarks = [];
    controller.addressCtrl.clear();
    mapController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(7.h),
          child:  NewAppHeader(
            title: "Add Location".tr,
            showBackIcon: true,
          )),
      resizeToAvoidBottomInset: false,
      body: GetBuilder<LocationController>(builder: (controller) {
        return Padding(
          padding: EdgeInsets.only(top: 10.sp),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 10, right: 10, bottom: 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context)
                        .colorScheme
                        .primaryContainer,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding:
                    const EdgeInsets.only(left: 10, right: 15),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      controller: controller.addressCtrl,
                      style: TextStyle(
                          color: Theme.of(Get.context!)
                              .colorScheme
                              .onTertiary),
                      onChanged: (value) async {
                        _searchLocations(value);
                      },
                      decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.search,
                            color: ColorConstants.primaryColor,
                          ),
                          border: InputBorder.none,
                          hintText: 'Search Location'.tr,
                          hintStyle: TextStyle(
                            color:
                            Theme.of(context).colorScheme.error,
                          )),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Stack(
                  children:[
                    selectedPosition!=null?GoogleMap(
                      onMapCreated: _onMapCreated,
                      markers: markers,
                      onTap: _handleMapTap,
                      initialCameraPosition: CameraPosition(
                        target: LatLng(selectedPosition!.latitude, selectedPosition!.longitude),
                        zoom: 14.0,
                      ),
                    ):const Center(child: CircularProgressIndicator()),
                    Visibility(
                      visible:_locations.isNotEmpty ,
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          height: 300.h,
                          color: Theme.of(context).colorScheme.primaryContainer,
                          child: ListView.builder(
                            itemCount: _locations.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  ListTile(
                                    title: Text(_locations[index].name??'', style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w400)),
                                    subtitle: Text(_locations[index].address??''),
                                    onTap: () {
                                      if (FocusManager.instance.primaryFocus!.hasFocus) {
                                        FocusManager.instance.primaryFocus!.unfocus();
                                      }
                                      if (_locations[index].name?.isNotEmpty??false) {
                                        setState(() {
                                          selectedPosition = LatLng(
                                            _locations[index].lat!,
                                            _locations[index].long!,
                                          );
                                          controller.addressCtrl.text=_locations[index].name!;
                                          markers.clear();
                                          markers.add(
                                            Marker(
                                              markerId: const MarkerId('selected_location'),
                                              position: selectedPosition!,
                                            ),
                                          );
                                          mapController!.animateCamera(CameraUpdate.newLatLng(selectedPosition!));
                                        });
                                      }
                                      _locations.clear();
                                    },
                                  ),
                                  const Divider(color: Colors.black26,)
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 120,
                      right: 20,
                      left: 20,
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Center(
                              child: GestureDetector(
                                onTap: () {
                                  getLocation();
                                },
                                child: Container(
                                  height: 5.h,
                                  width: 55.w,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primaryContainer,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        "assets/images/currntLoc.svg",
                                        color: ColorConstants.primaryColor,
                                      ),
                                      SizedBox(
                                        width: 2.w,
                                      ),
                                      Text(
                                        "Current Location".tr,
                                        style: const TextStyle(
                                            color:
                                            ColorConstants.primaryColor),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )]),
                    ),
                    Positioned(
                      bottom: 30,
                      right: 20,
                      left: 20,
                      child: Container(
                        alignment: Alignment.center,
                        height: 60,
                        child: GestureDetector(
                            onTap: () {
                               controller.city.clear();
                              //_showBottomSheet(context);
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>AddAddress(page: '',location: selectedPosition,)));
                            },
                            child: BorderedButton(
                              width: 1,
                              text: "CONFIRM LOCATION".tr.toUpperCase(),
                              isReversed: true,
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
  // getUserLocation(LatLng myLocation) async {
  //   try {
  //     log("In Location Method");
  //     controller.coordinates = await Geocoder2.getDataFromCoordinates(
  //         latitude: myLocation.latitude ?? 0.0,
  //         longitude: myLocation.longitude ?? 0.0,
  //         googleMapApiKey: "AIzaSyAj56AD3gkd8uqpD77eeFEAYANu3e5JA18");
  //     controller.placemarks = await placemarkFromCoordinates(myLocation.latitude ?? 0.00, myLocation.longitude ?? 0.00);
  //     controller.addressCtrl.text = controller.coordinates?.address ?? "";
  //     controller.markers.clear();
  //     controller.markers.add(
  //       Marker(
  //         markerId: const MarkerId("0"),
  //         position: LatLng(
  //             double.parse("${controller.coordinates?.latitude ?? "0.0"}"),
  //             double.parse("${controller.coordinates?.longitude ?? "0.0"}")),
  //       ),
  //     );
  //     controller.update();
  //   } catch (_) {}
  // }
  //
  // void getUserCurrentLocations() {
  //   checkLocationPermission().then((value) {
  //     if (value != null) {
  //       mapController.animateCamera(CameraUpdate.newCameraPosition(
  //         CameraPosition(
  //           target: LatLng(value.latitude ?? 0.0, value.longitude ?? 0.0),
  //           zoom: 13.0,
  //         ),
  //       ));
  //       getUserLocation(LatLng(value.latitude ?? 0.0, value.longitude ?? 0.0));
  //     }
  //   });
  // }
  //
  // Future<void> changeLocation(String address) async {
  //   controller.coordinates = await Geocoder2.getDataFromAddress(
  //     address: address,
  //     googleMapApiKey: "AIzaSyAj56AD3gkd8uqpD77eeFEAYANu3e5JA18",
  //   );
  //   controller.placemarks = await placemarkFromCoordinates(
  //       controller.coordinates?.latitude ?? 0.00,
  //       controller.coordinates?.longitude ?? 0.00);
  //   // PrintLog('${controller.coordinates?.address}, ${controller.coordinates?.countryCode},'
  //   //     '${controller.coordinates?.country}, ${controller.coordinates?.state},'
  //   //     '${controller.coordinates?.city}, ${controller.coordinates?.postalCode},${controller.coordinates?.streetNumber}');
  //   controller.addressCtrl.text = controller.coordinates?.address ?? "";
  //   mapController.animateCamera(CameraUpdate.newCameraPosition(
  //     CameraPosition(
  //       target: LatLng(controller.coordinates?.latitude ?? 0.0,
  //           controller.coordinates?.longitude ?? 0.0),
  //       zoom: 15.0,
  //     ),
  //   ));
  //   controller.markers.clear();
  //   controller.markers.add(
  //     Marker(
  //       markerId: const MarkerId("0"),
  //       position: LatLng(
  //           double.parse("${controller.coordinates?.latitude ?? "0.0"}"),
  //           double.parse("${controller.coordinates?.longitude ?? "0.0"}")),
  //     ),
  //   );
  //   controller.update();
  // }

  // Future<void> init() async {
  //   await controller.getCountry();
  // }
  ///**************************************************///
  void _showBottomSheet(BuildContext context) {
      showModalBottomSheet<void>(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
          ),
        isScrollControlled: true,
          context: context,
          builder: (BuildContext context) {
            return StatefulBuilder(
              builder: (context, setState) =>
              SizedBox(

                  height: 80.h,
                  // Add your BottomSheet content here
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.location_pin),
                              SizedBox(
                                width: 80.w,
                                child: Text(
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.start,
                                  maxLines: 2,
                                  controller.addressCtrl.text,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15.0,
                                      color: Theme.of(Get.context!).colorScheme.tertiary),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              //color: Colors.amber.shade50,
                              border: Border.all(color: Colors.amber),
                              borderRadius: const BorderRadiusDirectional.all(
                                  Radius.circular(10)),
                            ),
                            child:  Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                  'A detailed address will help our Provider reach your doorstep easily'.tr),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 5),
                              decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primaryContainer,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: EdgeInsets.only(left: 20.sp,right: 20.sp),
                                child: addEditText2(
                                    controller.streetNoCtrl, "House/Flat/BlockNo.".tr,
                                    inputType: TextInputType.multiline),
                              )),
                          Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 5),
                              decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primaryContainer,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: EdgeInsets.only(left: 20.sp,right: 20.sp),
                                child: addEditText2(
                                    controller.streetNameCtrl, "Apartment/Road/Area".tr,
                                    inputType: TextInputType.multiline),
                              )),
                          Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 5),
                              decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primaryContainer,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: EdgeInsets.only(left: 20.sp,right: 20.sp),
                                child: addEditText2(
                                    controller.areaPinCtrl,
                                    "Area PinCode".tr,
                                    inputType: TextInputType.number),
                              )),
                          SizedBox(
                            height: 2.h,
                          ),
                          GestureDetector(
                              onTap: () {
                                if(controller.streetNoCtrl.text.isEmpty||controller.streetNameCtrl.text.isEmpty||controller.areaPinCtrl.text.isEmpty){
                                  BaseOverlays().showSnackBar(message:"All fields are mandatory".tr, title: "Error".tr);
                                }else {
                                  if (widget.isEditLocation == true) {
                                    controller.editLocation(widget.locationId,
                                        selectedPosition!.latitude,
                                        selectedPosition!.longitude);
                                  } else {
                                    controller.addLocation(
                                        selectedPosition!.latitude,
                                        selectedPosition!.longitude);
                                  }
                                }
                              },
                              child: BorderedButton(
                                width: 1,
                                text: "SAVE".tr,
                                isReversed: true,
                              )),
                        ]),
                  )),
            );
          });
    }
  }

class Location {
  final String ? name;
  final String ?address;
  final double ? lat;
  final double ?long;

  Location({this.name,this.address,this.lat,this.long});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      name: json['name']??"Jaipur,india",
      address: json['formatted_address']??"Jaipur,india",
      lat: json['geometry']['location']['lat']??25.8979508,
      long: json['geometry']['location']['lng']??84.4877291,
    );
  }
}
