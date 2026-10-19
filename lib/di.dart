import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signalr_netcore/signalr_client.dart';
import 'package:uuid/uuid.dart';

import 'auth_controller.dart';
import 'core/cache/prefs.dart';
import 'core/constants/cache_keys.dart';
import 'core/location/location_service.dart';
import 'core/network/auth_interceptor.dart';
import 'core/services/network_info.dart';
import 'core/services/signalr_service.dart';
import 'core/utils/api_endpoints.dart';
import 'core/utils/app_locales.dart';
import 'core/uuid_generator/uuid_generator.dart';
import 'features/auth/data/datasources/auth_remote_datasource.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/domain/usecase/login_usecase.dart';
import 'features/auth/domain/usecase/logout_usecase.dart';
import 'features/auth/domain/usecase/register_usecase.dart';
import 'features/auth/domain/usecase/resend_otp_usecase.dart';
import 'features/auth/domain/usecase/verify_phone_usecase.dart';
import 'features/auth/presentation/viewmodels/login_viewmodel/login_cubit.dart';
import 'features/auth/presentation/viewmodels/register_viewmodel/register_cubit.dart';
import 'features/auth/presentation/viewmodels/verify_phone_viewmodel/verify_phone_cubit.dart';
import 'features/cart/data/datasources/cart_local_datasource.dart';
import 'features/cart/data/repositories/cart_repository_impl.dart';
import 'features/cart/domain/repositories/cart_repository.dart';
import 'features/cart/domain/usecases/add_to_cart_usecase.dart';
import 'features/cart/domain/usecases/clear_cart_usecase.dart';
import 'features/cart/domain/usecases/get_cart_usecase.dart';
import 'features/cart/domain/usecases/remove_from_cart_usecase.dart';
import 'features/cart/domain/usecases/update_cart_item_quantity_usecase.dart';
import 'features/cart/presentation/viewmodel/cart_cubit.dart';
import 'features/coupons/data/datasources/coupons_remote_datasource.dart';
import 'features/coupons/data/repositories/coupons_repository_impl.dart';
import 'features/coupons/domain/repositories/coupons_repository.dart';
import 'features/coupons/domain/usecases/apply_coupon_usecase.dart';
import 'features/coupons/domain/usecases/get_coupons_usecase.dart';
import 'features/coupons/presentation/viewmodels/apply_coupon_viewmodel/apply_coupon_cubit.dart';
import 'features/coupons/presentation/viewmodels/coupons_viewmodel/coupons_cubit.dart';
import 'features/delivery/domain/usecases/delete_address_usecase.dart';
import 'features/favorites/data/datasources/favorites_remote_datasource.dart';
import 'features/favorites/data/repositories/favorites_repository_impl.dart';
import 'features/favorites/domain/repositories/favorites_repository.dart';
import 'features/favorites/domain/usecases/get_favorites_usecase.dart';
import 'features/favorites/domain/usecases/toggle_favorite_usecase.dart';
import 'features/favorites/presentation/viewmodel/favorite_toggle_viewmodel/favorite_toggle_cubit.dart';
import 'features/favorites/presentation/viewmodel/favorites_viewmodel/favorites_cubit.dart';
import 'features/location/data/datasources/places_remote_datasource.dart';
import 'features/location/data/repositories/location_repository_impl.dart';
import 'features/location/domain/repositories/location_repository.dart';
import 'features/delivery/data/datasources/saved_addresses_remote_datasource.dart';
import 'features/delivery/data/repositories/saved_addresses_repository_impl.dart';
import 'features/delivery/domain/repositories/saved_addresses_repository.dart';
import 'features/delivery/domain/usecases/get_address_name_usecase.dart';
import 'features/delivery/domain/usecases/get_saved_addresses_usecase.dart';
import 'features/delivery/domain/usecases/set_as_default_address_usecase.dart';
import 'features/delivery/presentation/viewmodels/saved_address_model/saved_addresses_cubit.dart';
import 'features/location/domain/usecases/add_address_usecase.dart';
import 'features/location/domain/usecases/get_branch_usecase.dart';
import 'features/location/domain/usecases/get_device_location_usecase.dart';
import 'features/location/domain/usecases/get_place_coordinates_usecase.dart';
import 'features/location/domain/usecases/search_places_usecase.dart';
import 'features/location/presentation/viewmodels/address_details_viewmodel/address_details_cubit.dart';
import 'features/location/presentation/viewmodels/request_location_permession_viewmodel/request_location_permession_cubit.dart';
import 'features/location/presentation/viewmodels/select_location_viewmodel/select_location_cubit.dart';
import 'features/notifications/data/datasources/fcm_service.dart';
import 'features/notifications/data/datasources/notifications_remote_datasource.dart';
import 'features/notifications/data/repositories/notifications_repository_impl.dart';
import 'features/notifications/domain/repositories/notifications_repository.dart';
import 'features/notifications/domain/usecases/enable_notifications_usecase.dart';
import 'features/orders/data/datasources/orders_remote_datasource.dart';
import 'features/orders/data/repositories/orders_repository_impl.dart';
import 'features/orders/domain/repositories/orders_repository.dart';
import 'features/orders/domain/usecases/get_current_orders_usecase.dart';
import 'features/orders/domain/usecases/get_previous_orders_usecase.dart';
import 'features/orders/presentation/viewmodels/current_orders_view/current_orders_cubit.dart';
import 'features/orders/presentation/viewmodels/previous_orders_viewmodel/previous_orders_cubit.dart';
import 'features/payment/data/datasources/checkout_local_datasource.dart';
import 'features/payment/data/datasources/checkout_remote_datasource.dart';
import 'features/payment/data/repositories/checkout_repository_impl.dart';
import 'features/payment/domain/repositories/checkout_repository.dart';
import 'features/payment/domain/usecases/checkout_usecase.dart';
import 'features/payment/domain/usecases/get_payment_methods_usecase.dart';
import 'features/payment/presentation/viewmodels/checkout_viewmodel/checkout_cubit.dart';
import 'features/payment/presentation/viewmodels/payment_methods_viewmodel/payment_methods_cubit.dart';
import 'features/profile/data/datasources/profile_remote_datasource.dart';
import 'features/profile/data/repositories/profile_repository_impl.dart';
import 'features/profile/domain/repositories/profile_repository.dart';
import 'features/profile/domain/usecases/get_profile_usecase.dart';
import 'features/profile/domain/usecases/request_phone_update_usecase.dart';
import 'features/profile/domain/usecases/update_profile_usecase.dart';
import 'features/profile/presentation/viewmodel/edit_phone_viewmodel/edit_phone_cubit.dart';
import 'features/profile/presentation/viewmodel/edit_profile_viewmodel/edit_profile_cubit.dart';
import 'features/profile/presentation/viewmodel/profile_viewmodel/profile_cubit.dart';
import 'features/root/data/datasources/banners_remote_datasource.dart';
import 'features/root/data/datasources/categories_remote_datasource.dart';
import 'features/root/data/datasources/items_remote_datasource.dart';
import 'features/root/data/repositories/banners_repository_impl.dart';
import 'features/root/data/repositories/categories_repository_impl.dart';
import 'features/root/data/repositories/items_repository_impl.dart';
import 'features/root/domain/repositories/banners_repository.dart';
import 'features/root/domain/repositories/categories_repository.dart';
import 'features/root/domain/repositories/items_repository.dart';
import 'features/root/domain/usecases/get_category_products_usecase.dart';
import 'features/root/domain/usecases/get_popular_products_usecase.dart';
import 'features/root/domain/usecases/search_products_usecase.dart';
import 'features/root/presentation/viewmodels/category_items_viewmodel/category_items_cubit.dart';
import 'features/root/presentation/viewmodels/home_viewmodel/home_cubit.dart';
import 'features/root/presentation/viewmodels/search_viewmodel/search_cubit.dart';
import 'features/wallet/data/datasources/wallet_remote_datasource.dart';
import 'features/wallet/data/repositories/wallet_repository_impl.dart';
import 'features/wallet/domain/repositories/wallet_repository.dart';
import 'features/wallet/domain/usecases/get_balance_usecase.dart';
import 'features/wallet/domain/usecases/get_wallet_transactions.dart';
import 'features/wallet/presentation/viewmodels/balance_viewmodel/balance_cubit.dart';
import 'features/wallet/presentation/viewmodels/wallet_viewmodel/wallet_cubit.dart';
import 'language_controller.dart';

final GetIt getIt = GetIt.instance;

Future<String?> setupDependencyInjection() async{
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  const FlutterSecureStorage secureStorage = FlutterSecureStorage();
  final String? accessToken = await secureStorage.read(key: CacheKeys.accessToken);
  final Box<Map> cartBox = await Hive.openBox<Map>("cart");

  getIt.registerLazySingleton<UuidGenerator>(() => const UuidGeneratorImpl(Uuid()));
  getIt.registerSingleton<Prefs>(PrefsImpl(prefs));
  getIt.registerSingleton(
    LanguageController(
      getIt<Prefs>().getString(CacheKeys.language) ?? AppLocales.ar
    )
  );
  getIt.registerLazySingleton<FlutterSecureStorage>(() => secureStorage);
  getIt.registerLazySingleton<Geocoding>(() => Geocoding());

  final Dio emenuDio = Dio(
    BaseOptions(
      baseUrl: ApiEndpoints.baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: <String, dynamic>{
        "accept": "text/plain",
        "Authorization": ?(accessToken is String? "Bearer $accessToken": null),
        "Accept-Language": getIt<LanguageController>().value
      }
    )
  );
  
  emenuDio.interceptors.addAll(
    <Interceptor>[
      LogInterceptor(
        requestBody: true,
        responseBody: true,
      ),
      AuthInterceptor(
        onSessionExpired: () => getIt<AuthCubit>().unauthenticate(),
        secureStorage: getIt<FlutterSecureStorage>(),
        emenuDio: emenuDio,
        refreshDio: Dio(
          BaseOptions(
            baseUrl: ApiEndpoints.baseUrl,
            connectTimeout: const Duration(seconds: 30),
            sendTimeout: const Duration(seconds: 30),
            receiveTimeout: const Duration(seconds: 30),
            transformTimeout: const Duration(seconds: 30)
          )
        )
      )
    ]
  );

  getIt.registerLazySingleton<Dio>(() => emenuDio);

  getIt.registerLazySingleton<Dio>(
    () => Dio(
      BaseOptions(
        baseUrl: ApiEndpoints.googlePlacesBaseUrl,
        connectTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        transformTimeout: const Duration(seconds: 30),
        headers: <String, dynamic>{
          "X-Goog-Api-Key": dotenv.get("MAPS_API_KEY"),
          "Accept-Language": getIt<LanguageController>().value
        }
      )
    ),
    instanceName: "google_places_dio"
  );
  getIt.registerLazySingleton<Connectivity>(() => Connectivity());

  getIt.registerLazySingleton<LocationService>(() => LocationServiceImpl(getIt<Geocoding>()));
  getIt.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(getIt<Connectivity>())
  );

  final HubConnection hubConnection = HubConnectionBuilder().withUrl(ApiEndpoints.baseUrl).withAutomaticReconnect().build();
  getIt.registerLazySingleton<SignalrService>(() => SignalrServiceImpl(hubConnection));

  getIt.registerLazySingleton<FcmService>(() => FcmServiceImpl(FirebaseMessaging.instance));

  getIt.registerLazySingleton<AuthRemoteDatasource>(
    () => AuthRemoteDatasourceImpl(
      dio: getIt<Dio>(),
      secureStorage: getIt<FlutterSecureStorage>()
    )
  );
  getIt.registerLazySingleton<CategoriesRemoteDatasource>(
    () => CategoriesRemoteDatasourceImpl(getIt<Dio>())
  );
  getIt.registerLazySingleton<ItemsRemoteDatasource>(
    () => ItemsRemoteDatasourceImpl(getIt<Dio>())
  );
  getIt.registerLazySingleton<PlacesRemoteDatasource>(() => PlacesRemoteDatasourceImpl(
    eMenuDio: getIt<Dio>(),
    googlePlacesDio: getIt<Dio>(instanceName: "google_places_dio")
  ));
  getIt.registerLazySingleton<OrdersRemoteDatasource>(() => OrdersRemoteDatasourceImpl(getIt<Dio>()));
  getIt.registerLazySingleton<FavoritesRemoteDatasource>(() => FavoritesRemoteDatasourceImpl(getIt<Dio>()));
  getIt.registerLazySingleton<CouponsRemoteDatasource>(() => CouponsRemoteDatasourceImpl(getIt<Dio>()));
  getIt.registerLazySingleton<CartLocalDatasource>(() => CartLocalDatasourceImpl(cartBox));
  getIt.registerLazySingleton<CheckoutRemoteDatasource>(() => CheckoutRemoteDatasourceImpl(getIt<Dio>()));
  getIt.registerLazySingleton<CheckoutLocalDatasource>(() => CheckoutLocalDatasourceImpl(getIt<Prefs>()));
  getIt.registerLazySingleton<WalletRemoteDatasource>(() => WalletRemoteDatasourceImpl(getIt<Dio>()));
  getIt.registerLazySingleton<ProfileRemoteDatasource>(() => ProfileRemoteDatasourceImpl(getIt<Dio>()));
  getIt.registerLazySingleton<BannersRemoteDatasource>(() => BannersRemoteDatasourceImpl(getIt<Dio>()));
  getIt.registerLazySingleton<SavedAddressesRemoteDatasource>(() => SavedAddressesRemoteDatasourceImpl(getIt<Dio>()));
  getIt.registerLazySingleton<NotificationsRemoteDatasource>(() => NotificationsRemoteDatasourceImpl(getIt<Dio>()));

  getIt.registerLazySingleton<LocationRepository>(() => LocationRepositoryImpl(
    prefs: getIt<Prefs>(),
    locationService: getIt<LocationService>(),
    placesRemoteDatasource: getIt<PlacesRemoteDatasource>(),
    networkInfo: getIt<NetworkInfo>()
  ));
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      prefs: getIt<Prefs>(),
      networkInfo: getIt<NetworkInfo>(),
      remoteDatasource: getIt<AuthRemoteDatasource>()
    )
  );
  getIt.registerLazySingleton<CategoriesRepository>(
    () => CategoriesRepositoryImpl(
      prefs: getIt<Prefs>(),
      networkInfo: getIt<NetworkInfo>(),
      remoteDatasource: getIt<CategoriesRemoteDatasource>()
    )
  );
  getIt.registerLazySingleton<ItemsRepository>(
    () => ItemsRepositoryImpl(
      prefs: getIt<Prefs>(),
      networkInfo: getIt<NetworkInfo>(),
      remoteDatasource: getIt<ItemsRemoteDatasource>()
    )
  );
  getIt.registerLazySingleton<OrdersRepository>(() => OrdersRepositoryImpl(
    networkInfo: getIt<NetworkInfo>(),
    remoteDatasource: getIt<OrdersRemoteDatasource>()
  ));
  getIt.registerLazySingleton<FavoritesRepository>(() => FavoritesRepositoryImpl(
    prefs: getIt<Prefs>(),
    networkInfo: getIt<NetworkInfo>(),
    remoteDatasource: getIt<FavoritesRemoteDatasource>()
  ));
  getIt.registerLazySingleton<CouponsRepository>(() => CouponsRepositoryImpl(
    prefs: getIt<Prefs>(),
    networkInfo: getIt<NetworkInfo>(),
    remoteDatasource: getIt<CouponsRemoteDatasource>()
  ));
  getIt.registerLazySingleton<CartRepository>(() => CartRepositoryImpl(getIt<CartLocalDatasource>()));
  getIt.registerLazySingleton<CheckoutRepository>(() => CheckoutRepositoryImpl(
    networkInfo: getIt<NetworkInfo>(),
    prefs: getIt<Prefs>(),
    uuidGenerator: getIt<UuidGenerator>(),
    remoteDatasource: getIt<CheckoutRemoteDatasource>(),
    localDatasource: getIt<CheckoutLocalDatasource>()
  ));
  getIt.registerLazySingleton<WalletRepository>(() => WalletRepositoryImpl(
    uuidGenerator: getIt<UuidGenerator>(),
    networkInfo: getIt<NetworkInfo>(),
    remoteDatasource: getIt<WalletRemoteDatasource>()
  ));
  getIt.registerLazySingleton<ProfileRepository>(() => ProfileRepositoryImpl(
    networkInfo: getIt<NetworkInfo>(),
    remoteDatasource: getIt<ProfileRemoteDatasource>()
  ));
  getIt.registerLazySingleton<SavedAddressesRepository>(() => SavedAddressesRepositoryImpl(
    networkInfo: getIt<NetworkInfo>(),
    remoteDatasource: getIt<SavedAddressesRemoteDatasource>()
  ));
  getIt.registerLazySingleton<BannersRepository>(() => BannersRepositoryImpl(
    networkInfo: getIt<NetworkInfo>(),
    remoteDatasource: getIt<BannersRemoteDatasource>()
  ));
  getIt.registerLazySingleton<NotificationsRepository>(() => NotificationsRepositoryImpl(
    networkInfo: getIt<NetworkInfo>(),
    fcmService: getIt<FcmService>(),
    remoteDatasource: getIt<NotificationsRemoteDatasource>()
  ));

  getIt.registerLazySingleton<GetAddressNameUsecase>(() => GetAddressNameUsecase(getIt<LocationRepository>()));
  getIt.registerLazySingleton<GetDeviceLocationUsecase>(() => GetDeviceLocationUsecase(getIt<LocationRepository>()));
  getIt.registerLazySingleton<SearchPlacesUsecase>(() => SearchPlacesUsecase(getIt<LocationRepository>()));
  getIt.registerLazySingleton<GetPlaceCoordinatesUsecase>(() => GetPlaceCoordinatesUsecase(getIt<LocationRepository>()));
  getIt.registerLazySingleton<LoginUsecase>(() => LoginUsecase(getIt<AuthRepository>()));
  getIt.registerLazySingleton<LogoutUsecase>(() => LogoutUsecase(getIt<AuthRepository>()));
  getIt.registerLazySingleton<RegisterUsecase>(() => RegisterUsecase(getIt<AuthRepository>()));
  getIt.registerLazySingleton<VerifyPhoneUsecase>(() => VerifyPhoneUsecase(getIt<AuthRepository>()));
  getIt.registerLazySingleton<ResendOtpUsecase>(() => ResendOtpUsecase(getIt<AuthRepository>()));
  getIt.registerLazySingleton<GetCategoryProductsUsecase>(() => GetCategoryProductsUsecase(getIt<ItemsRepository>()));
  getIt.registerLazySingleton<GetBranchUsecase>(() => GetBranchUsecase(getIt<LocationRepository>()));
  getIt.registerLazySingleton<GetPopularProductsUsecase>(() => GetPopularProductsUsecase(getIt<ItemsRepository>()));
  getIt.registerLazySingleton<SearchProductsUsecase>(() => SearchProductsUsecase(getIt<ItemsRepository>()));
  getIt.registerLazySingleton<GetCurrentOrdersUsecase>(() => GetCurrentOrdersUsecase(getIt<OrdersRepository>()));
  getIt.registerLazySingleton<GetPreviousOrdersUsecase>(() => GetPreviousOrdersUsecase(getIt<OrdersRepository>()));
  getIt.registerLazySingleton<GetFavoritesUsecase>(() => GetFavoritesUsecase(getIt<FavoritesRepository>()));
  getIt.registerLazySingleton<ToggleFavoriteUsecase>(() => ToggleFavoriteUsecase(getIt<FavoritesRepository>()));
  getIt.registerLazySingleton<GetCouponsUsecase>(() => GetCouponsUsecase(getIt<CouponsRepository>()));
  getIt.registerLazySingleton<ApplyCouponUsecase>(() => ApplyCouponUsecase(getIt<CouponsRepository>()));
  getIt.registerLazySingleton<GetCartUsecase>(() => GetCartUsecase(getIt<CartRepository>()));
  getIt.registerLazySingleton<AddToCartUsecase>(() => AddToCartUsecase(getIt<CartRepository>()));
  getIt.registerLazySingleton<UpdateCartItemQuantityUsecase>(() => UpdateCartItemQuantityUsecase(getIt<CartRepository>()));
  getIt.registerLazySingleton<RemoveFromCartUsecase>(() => RemoveFromCartUsecase(getIt<CartRepository>()));
  getIt.registerLazySingleton<ClearCartUsecase>(() => ClearCartUsecase(getIt<CartRepository>()));
  getIt.registerLazySingleton<CheckoutUsecase>(() => CheckoutUsecase(getIt<CheckoutRepository>()));
  getIt.registerLazySingleton<GetPaymentMethodsUsecase>(() => GetPaymentMethodsUsecase(getIt<CheckoutRepository>()));
  getIt.registerLazySingleton<GetBalanceUsecase>(() => GetBalanceUsecase(getIt<WalletRepository>()));
  getIt.registerLazySingleton<AddAddressUsecase>(() => AddAddressUsecase(getIt<LocationRepository>()));
  getIt.registerLazySingleton<GetSavedAddressesUsecase>(() => GetSavedAddressesUsecase(getIt<SavedAddressesRepository>()));
  getIt.registerLazySingleton<SetAsDefaultAddressUsecase>(() => SetAsDefaultAddressUsecase(getIt<SavedAddressesRepository>()));
  getIt.registerLazySingleton<GetProfileUsecase>(() => GetProfileUsecase(getIt<ProfileRepository>()));
  getIt.registerLazySingleton<UpdateProfileUsecase>(() => UpdateProfileUsecase(getIt<ProfileRepository>()));
  getIt.registerLazySingleton<RequestPhoneUpdateUsecase>(() => RequestPhoneUpdateUsecase(getIt<ProfileRepository>()));
  getIt.registerLazySingleton<GetWalletTransactionsUsecase>(() => GetWalletTransactionsUsecase(getIt<WalletRepository>()));
  getIt.registerLazySingleton<DeleteAddressUsecase>(() => DeleteAddressUsecase(getIt<SavedAddressesRepository>()));
  getIt.registerLazySingleton<EnableNotificationsUsecase>(() => EnableNotificationsUsecase(getIt<NotificationsRepository>()));

  getIt.registerLazySingleton<AuthCubit>(() => AuthCubit(
    logoutUsecase: getIt<LogoutUsecase>(),
    clearCartUsecase: getIt<ClearCartUsecase>()
  ));
  getIt.registerFactory<ProfileCubit>(() => ProfileCubit(
    getProfileUsecase: getIt<GetProfileUsecase>(),
  ));
  getIt.registerFactory<RegisterCubit>(() => RegisterCubit(getIt<RegisterUsecase>()));
  getIt.registerFactory<LoginCubit>(() => LoginCubit(getIt<LoginUsecase>()));
  getIt.registerFactory<SelectLocationCubit>(() => SelectLocationCubit(
    getDeviceLocationUsecase: getIt<GetDeviceLocationUsecase>(),
    searchPlacesUsecasse: getIt<SearchPlacesUsecase>(),
    getPlaceCoordinatesUsecase: getIt<GetPlaceCoordinatesUsecase>(),
    getBranchUsecase: getIt<GetBranchUsecase>()
  ));
  getIt.registerFactory<HomeCubit>(() => HomeCubit(
    bannersRepository: getIt<BannersRepository>(),
    categoriesRepository: getIt<CategoriesRepository>(),
    getPopularProductsUsecase: getIt<GetPopularProductsUsecase>(),
    enableNotificationsUsecase: getIt<EnableNotificationsUsecase>()
  ));
  getIt.registerFactory<VerifyPhoneCubit>(() => VerifyPhoneCubit(
    verifyPhoneUsecase: getIt<VerifyPhoneUsecase>(),
    resendOtpUsecase: getIt<ResendOtpUsecase>()
  ));
  getIt.registerFactory<CategoryProductsCubit>(() => CategoryProductsCubit(getIt<GetCategoryProductsUsecase>()));
  getIt.registerFactory<AddressDetailsCubit>(() => AddressDetailsCubit(getIt<AddAddressUsecase>()));
  getIt.registerFactory<SearchCubit>(() => SearchCubit(getIt<SearchProductsUsecase>()));
  getIt.registerFactory<CurrentOrdersCubit>(() => CurrentOrdersCubit(getIt<GetCurrentOrdersUsecase>()));
  getIt.registerFactory<PreviousOrdersCubit>(() => PreviousOrdersCubit(getIt<GetPreviousOrdersUsecase>()));
  getIt.registerFactory<FavoritesCubit>(() => FavoritesCubit(getIt<GetFavoritesUsecase>()));
  getIt.registerFactoryParam<FavoriteToggleCubit, int, bool>(
    (int productId, bool isFavorite) => FavoriteToggleCubit(
      toggleFavoriteUsecase: getIt<ToggleFavoriteUsecase>(),
      productId: productId,
      isFavorite: isFavorite
    )
  );
  getIt.registerFactory<CouponsCubit>(() => CouponsCubit(getIt<GetCouponsUsecase>()));
  getIt.registerFactory<ApplyCouponCubit>(() => ApplyCouponCubit(
    getCartUsecase: getIt<GetCartUsecase>(),
    applyCouponUsecase: getIt<ApplyCouponUsecase>()
  ));
  getIt.registerFactory<CartCubit>(() => CartCubit(
    getCartUsecase: getIt<GetCartUsecase>(),
    addToCartUsecase: getIt<AddToCartUsecase>(),
    updateCartItemQuantityUsecase: getIt<UpdateCartItemQuantityUsecase>(),
    removeFromCartUsecase: getIt<RemoveFromCartUsecase>(),
    clearCartUsecase: getIt<ClearCartUsecase>()
  ));
  getIt.registerFactory<CheckoutCubit>(() => CheckoutCubit(getIt<CheckoutUsecase>()));
  getIt.registerFactory<PaymentMethodsCubit>(() => PaymentMethodsCubit(getIt<GetPaymentMethodsUsecase>()));
  getIt.registerFactory<SavedAddressesCubit>(() => SavedAddressesCubit(
    getSavedAddressesUsecase: getIt<GetSavedAddressesUsecase>(),
    setAsDefaultAddressUsecase: getIt<SetAsDefaultAddressUsecase>(),
    deleteAddressUsecase: getIt<DeleteAddressUsecase>()
  ));
  getIt.registerFactory<BalanceCubit>(() => BalanceCubit(getIt<GetBalanceUsecase>()));
  getIt.registerFactory<WalletCubit>(() => WalletCubit(
    getBalanceUsecase: getIt<GetBalanceUsecase>(),
    getWalletTransactionsUsecase: getIt<GetWalletTransactionsUsecase>()
  ));
  getIt.registerFactory<EditProfileCubit>(() => EditProfileCubit(getIt<UpdateProfileUsecase>()));
  getIt.registerFactory<EditPhoneCubit>(() => EditPhoneCubit(getIt<RequestPhoneUpdateUsecase>()));
  getIt.registerFactory<RequestLocationPermessionCubit>(() => RequestLocationPermessionCubit(getIt<GetBranchUsecase>()));

  return accessToken;
}