abstract interface class ApiEndpoints {
  static const String googlePlacesBaseUrl = "https://places.googleapis.com/v1/places",
  baseUrl = "http://192.168.1.10:5259/api/",
  categories = "emenu/v1/catalog/categories",
  item = "emenu/v1/catalog/products",
  login = "emenu/v1/auth/login",
  register = "emenu/v1/auth/register",
  resendOtp = "emenu/v1/auth/resend-otp",
  verifyOtp = "emenu/v1/auth/verify-otp",
  logout = "emenu/v1/auth/logout",
  privacyPolicy = "emenu/v1/legal/privacy",
  termsAndConditions = "emenu/v1/legal/terms",
  locationResolve = "emenu/v1/location/resolve",
  availableAddresses = "CustomerAddress";
}