import 'package:animated_svg/animated_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:video_player/video_player.dart';

import '../../NewScreen/NewHome.dart';
import '../../Routes/app_routes.dart';
import '../../backend/api_end_points.dart';
import '../../backend/base_api.dart';
import '../../backend/modal/location_data_model.dart';
import '../../change_language/choose_language.dart';
import '../../common/color_constants.dart';
import '../../storage/base_shared_preference.dart';
import '../../storage/sp_keys.dart';
import '../auth/login.dart';
import '../locations/manage_address.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>   {
  late VideoPlayerController _controller;
  @override
  void initState() {
    _controller = VideoPlayerController.asset('assets/videos/intro.mp4');
    _controller.initialize();
    _controller.addListener(() {
      setState(() {});
    });
    _controller.play();
    Future.delayed(const Duration(seconds:3), () async {
      if (await BaseSharedPreference().getBool(SpKeys().isLoggedIn) ?? false) {
        getUserLocations();
      } else {
        Get.offAll( const LoginScreen());
      }
    });
    super.initState();
    FocusScope.of(Get.context!).requestFocus(FocusNode());
  }

 Future <void> getUserLocations() async {
    Map<String, dynamic> params = {};
    await BaseAPI().get(url: ApiEndPoints().getLocations, queryParameters: params)
        .then((value) {
      if (value!=null && value.statusCode == 200) {
        List<LocationData> locationDataList=LocationDataModel.fromJson(value.data).data ?? [];
        if(locationDataList.isEmpty){
          Get.offAll( const ManageAddress(page:"Login"));
        }else{
          Get.offAll( const FixitHomeScreen());
        }
      }else{
        Get.offAll( const ManageAddress(page:"Login"));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ColorConstants.white,
      body: SizedBox.expand(
        child: FittedBox(
          fit: BoxFit.cover,
          child: SizedBox(
            width: _controller.value.size.width,
            height: _controller.value.size.height,
            child: VideoPlayer(_controller),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}