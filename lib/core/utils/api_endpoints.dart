abstract interface class ApiEndpoints {
  static const String googlePlacesBaseUrl = "https://places.googleapis.com/v1/places",
  baseUrl = "http://192.168.1.10:5259/api/emenu/v1/",
  categories = "catalog/categories",
  item = "catalog/products",
  login = "auth/login",
  register = "auth/register",
  resendOtp = "auth/resend-otp",
  verifyOtp = "auth/verify-otp",
  logout = "auth/logout",
  privacyPolicy = "legal/privacy",
  termsAndConditions = "legal/terms",
  locationResolve = "location/resolve";
}