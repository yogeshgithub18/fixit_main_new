import 'package:fixit/backend/modal/page_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../NewScreen/NewAppBar.dart';
import '../../backend/api_end_points.dart';
import '../../backend/base_api.dart';
import '../../common/base_overlays.dart';
import '../app_header.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({
    Key? key,
  }) : super(key: key);

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  PageData data = PageData();
  bool isLoader=true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:PreferredSize(
          preferredSize: Size.fromHeight(6.9.h),
          child: NewAppHeader(
            title: 'About Us'.tr,
            showBackIcon: true,
          )
      ),
      body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: isLoader?const Center(child: CircularProgressIndicator()):data.aboutUs == null
              ? const SizedBox.shrink()
              : SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    Html(
                      data: data.aboutUs,
                      style: {
                        "h2": Style(
                          color: Theme.of(context)
                              .colorScheme
                              .tertiary, // Customize the text color for <p> tag
                          fontSize: FontSize
                              .large, // Customize the font size for <p> tag
                        ),
                        "p": Style(
                          color: Theme.of(context)
                              .colorScheme
                              .onTertiary, // Customize the text color for <p> tag
                          fontSize: FontSize
                              .large, // Customize the font size for <p> tag
                        ),
                        "strong": Style(
                          fontWeight:
                          FontWeight.bold, // Make <strong> text bold
                        ),
                      },
                    ),
                  ],
                ),
              ))),
    );
  }

  getData() async {
    await BaseAPI()
        .get(url: ApiEndPoints().aboutUs, showLoader: false)
        .then((value) {
      isLoader=false;
      if (value?.statusCode == 200) {
        data = PageResponse.fromJson(value?.data).data ?? PageData();
        setState(() {});
      } else {
        BaseOverlays()
            .showSnackBar(message: "Something Went Wrong!!".tr, title: "Error".tr);
      }
    });
  }
}
