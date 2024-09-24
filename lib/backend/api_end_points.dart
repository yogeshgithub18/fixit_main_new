class ApiEndPoints {
  /// OnBoarding EndPoints
  final String imageBaseUrl = "https://fixitservice.co/";
  final String login = "login";
  final String otpVerify = "verify-user";
  final String register = "register";
  final String profile = "user/profile";
  final String setFav = "user/wishlist/toggle";
  final String favList = "user/wishlist";
  final String updateProfile = "user/update_profile";
  final String changePassword = "user/change-password";
  final String updateForgotPassword = "update-forget-password";
  final String notificationSetting = "user/notification-update";
  final String serviceProviders = "user/service-category";
  final String serviceSubProviders = "user/service-subcategory";
  final String serviceSubBannerCategory = "user/getSubcategoriesBySubbanner";
  final String createServiceRequest = "user/create-service-request";
  final String aboutUs = "user/about-us";
  final String termConditions = "term-condition";
  final String privacyPolicy = "user/privacy-policy";
  final String allBookings = "user/all-booking";
  final String sendChatData="user/send-document-chat";

  final String bookingDetail = "user/booking-detail";
  final String confirmBooking = "/user/confirm-accept-request-by-client";
  final String cancelBooking = "/user/cancel-service-request";

  final String giveRating = "user/give-rating";

  final String getNotifications = "user/notification";
  final String deleteNotifications = "user/delete-notification";
  final String markNotifications = "user/mark-notification";
  final String getLocations = "user/all-location";
  final String addLocation = "user/add-location";
  final String editLocation = "user/edit-location";
  final String deleteLocation = "user/delete-location";
  final String activateLocation = "user/active-location";

  final String getCountry = "user/country";
  final String getBanner = "user/banner-list";
  final String getCityByCountry = "user/city-by-country";
  final String forgetPassword = "forget-password";
  final String updateLanguage = "user/update_lang";
  final String notificationCount = "user/unmark-notification-count";
  final String googleLogin = "sociallogin";
}
