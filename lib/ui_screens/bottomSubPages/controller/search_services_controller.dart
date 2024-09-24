import 'package:get/get.dart';

import '../../../backend/api_end_points.dart';
import '../../../backend/base_api.dart';
import '../../../backend/modal/service_provider_response.dart';

class ServicesController extends GetxController{
  RxList<ServiceProvider> pList=<ServiceProvider>[].obs;

  getServiceProvider()async{
    await BaseAPI().get(url:ApiEndPoints().serviceProviders,showLoader: false).then((value){
      if(value?.statusCode==200){
        pList.value=ServiceProviderResponse.fromJson(value?.data).data??[];
      }
    });
  }

  RxList<ServiceProvider> searchResults=<ServiceProvider>[].obs;
  RxString searchText=''.obs;

  void searchObjects(String query) {
    searchResults.clear();
    searchResults.value = pList.where(
          (object) => object.name!.toLowerCase().contains(query.toLowerCase()),
    ).toList();
  }

}
