import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/cache/prefs.dart';
import 'core/constants/cache_keys.dart';
import 'core/location/location_service.dart';
import 'core/network/network_info.dart';
import 'core/utils/api_endpoints.dart';
import 'core/utils/app_locales.dart';
import 'features/auth/data/datasources/auth_remote_datasource.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/domain/usecase/login_usecase.dart';
import 'features/auth/domain/usecase/logout_usecase.dart';
import 'features/auth/domain/usecase/register_usecase.dart';
import 'features/auth/domain/usecase/verify_phone_usecase.dart';
import 'features/auth/presentation/viewmodels/login_viewmodel/login_cubit.dart';
import 'features/auth/presentation/viewmodels/register_viewmodel/register_cubit.dart';
import 'features/auth/presentation/viewmodels/verify_phone_viewmodel/verify_phone_cubit.dart';
import 'features/legal/data/datasources/legal_local_datasource.dart';
import 'features/legal/data/datasources/legal_remote_datasource.dart';
import 'features/legal/data/models/legal_list_model.dart';
import 'features/legal/data/repositories/legal_repository_impl.dart';
import 'features/legal/domain/repositories/legal_repository.dart';
import 'features/legal/domain/usecases/get_privacy_policy_usecase.dart';
import 'features/legal/domain/usecases/get_terms_usecase.dart';
import 'features/legal/presentation/viewmodels/privacy_policy_viewmodel/privacy_policy_cubit.dart';
import 'features/legal/presentation/viewmodels/terms_viewmodel/terms_cubit.dart';
import 'features/location/data/datasources/places_remote_datasource.dart';
import 'features/location/data/repositories/location_repository_impl.dart';
import 'features/location/domain/repositories/location_repository.dart';
import 'features/delivery/domain/usecases/get_address_name_usecase.dart';
import 'features/location/domain/usecases/get_branch_usecase.dart';
import 'features/location/domain/usecases/get_device_location_usecase.dart';
import 'features/location/domain/usecases/get_place_coordinates_usecase.dart';
import 'features/location/domain/usecases/search_places_usecase.dart';
import 'features/location/viewmodels/select_location_viewmodel/select_location_cubit.dart';
import 'features/profile/presentation/viewmodel/profile_cubit.dart';
import 'features/root/data/datasources/categories_local_datasource.dart';
import 'features/root/data/datasources/categories_remote_datasource.dart';
import 'features/root/data/datasources/items_local_datasource.dart';
import 'features/root/data/datasources/items_remote_datasource.dart';
import 'features/root/data/models/category_model.dart';
import 'features/root/data/models/item_model.dart';
import 'features/root/data/repositories/categories_repository_impl.dart';
import 'features/root/data/repositories/items_repository_impl.dart';
import 'features/root/domain/repositories/categories_repository.dart';
import 'features/root/domain/repositories/items_repository.dart';
import 'features/root/domain/usecases/get_category_products_usecase.dart';
import 'features/root/presentation/viewmodels/category_items_viewmodel/category_items_cubit.dart';
import 'features/root/presentation/viewmodels/home_viewmodel/home_cubit.dart';
import 'language_controller.dart';
import 'theme_controller.dart';

final GetIt getIt = GetIt.instance;

Future<void> setupDependencyInjection() async{
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  const FlutterSecureStorage secureStorage = FlutterSecureStorage();
  final String? token = await secureStorage.read(key: "token");

  getIt.registerSingleton<Prefs>(PrefsImpl(prefs));
  getIt.registerSingleton(
    LanguageController(
      getIt<Prefs>().getString(CacheKeys.language) ?? AppLocales.ar
    )
  );
  getIt.registerSingleton(
    ThemeController(
      ThemeMode.values.asNameMap()[getIt<Prefs>().getString(CacheKeys.theme)] ?? .light
    )
  );
  getIt.registerLazySingleton<FlutterSecureStorage>(() => secureStorage);
  getIt.registerLazySingleton<Geocoding>(() => Geocoding());
  getIt.registerLazySingleton<Dio>(() => Dio(
    BaseOptions(
      baseUrl: ApiEndpoints.baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: <String, dynamic>{
        "token": ?token,
        "Accept-Language": getIt<LanguageController>().value
      }
    )
  ));
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
  getIt.registerLazySingleton<LegalRemoteDatasource>(() => LegalRemoteDatasourceImpl(getIt<Dio>()));

  final Box<CategoryModel> categoriesBox = await Hive.openBox<CategoryModel>("categories");
  getIt.registerLazySingleton<CategoriesLocalDatasource>(() => CategoriesLocalDatasourceImpl(categoriesBox));

  final Box<ItemModel> itemsBox = await Hive.openBox<ItemModel>("items");
  getIt.registerLazySingleton<ItemsLocalDatasource>(() => ItemsLocalDatasourceImpl(itemsBox));

  final Box<LegalListModel> legalBox = await Hive.openBox<LegalListModel>("legal");
  getIt.registerLazySingleton<LegalLocalDatasource>(() => LegalLocalDatasourceImpl(legalBox));

  getIt.registerLazySingleton<LocationRepository>(() => LocationRepositoryImpl(
    prefs: getIt<Prefs>(),
    locationService: getIt<LocationService>(),
    placesRemoteDatasource: getIt<PlacesRemoteDatasource>()  
  ));
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      networkInfo: getIt<NetworkInfo>(),
      remoteDatasource: getIt<AuthRemoteDatasource>()
    )
  );
  getIt.registerLazySingleton<CategoriesRepository>(
    () => CategoriesRepositoryImpl(
      prefs: getIt<Prefs>(),
      networkInfo: getIt<NetworkInfo>(),
      remoteDatasource: getIt<CategoriesRemoteDatasource>(),
      localDatasource: getIt<CategoriesLocalDatasource>()
    )
  );
  getIt.registerLazySingleton<ItemsRepository>(
    () => ItemsRepositoryImpl(
      prefs: getIt<Prefs>(),
      networkInfo: getIt<NetworkInfo>(),
      remoteDatasource: getIt<ItemsRemoteDatasource>(),
      localDatasource: getIt<ItemsLocalDatasource>()
    )
  );
  getIt.registerLazySingleton<LegalRepository>(() => LegalRepositoryImpl(
    networkInfo: getIt<NetworkInfo>(),
    remoteDatasource: getIt<LegalRemoteDatasource>(),
    localDatasource: getIt<LegalLocalDatasource>()
  ));

  getIt.registerLazySingleton<GetAddressNameUsecase>(() => GetAddressNameUsecase(getIt<LocationRepository>()));
  getIt.registerLazySingleton<GetDeviceLocationUsecase>(() => GetDeviceLocationUsecase(getIt<LocationRepository>()));
  getIt.registerLazySingleton<SearchPlacesUsecase>(() => SearchPlacesUsecase(getIt<LocationRepository>()));
  getIt.registerLazySingleton<GetPlaceCoordinatesUsecase>(() => GetPlaceCoordinatesUsecase(getIt<LocationRepository>()));
  getIt.registerLazySingleton<LoginUsecase>(() => LoginUsecase(getIt<AuthRepository>()));
  getIt.registerLazySingleton<LogoutUsecase>(() => LogoutUsecase(getIt<AuthRepository>()));
  getIt.registerLazySingleton<RegisterUsecase>(() => RegisterUsecase(getIt<AuthRepository>()));
  getIt.registerLazySingleton<VerifyPhoneUsecase>(() => VerifyPhoneUsecase(getIt<AuthRepository>()));
  getIt.registerLazySingleton<GetCategoryProductsUsecase>(() => GetCategoryProductsUsecase(getIt<ItemsRepository>()));
  getIt.registerLazySingleton<GetBranchUsecase>(() => GetBranchUsecase(getIt<LocationRepository>()));
  getIt.registerLazySingleton<GetPrivacyPolicyUsecase>(() => GetPrivacyPolicyUsecase(getIt<LegalRepository>()));
  getIt.registerLazySingleton<GetTermsUsecase>(() => GetTermsUsecase(getIt<LegalRepository>()));

  getIt.registerFactory<ProfileCubit>(() => ProfileCubit(getIt<LogoutUsecase>()));
  getIt.registerFactory<RegisterCubit>(() => RegisterCubit(getIt<RegisterUsecase>()));
  getIt.registerFactory<LoginCubit>(() => LoginCubit(getIt<LoginUsecase>()));
  getIt.registerFactory<SelectLocationCubit>(() => SelectLocationCubit(
    getDeviceLocationUsecase: getIt<GetDeviceLocationUsecase>(),
    searchPlacesUsecasse: getIt<SearchPlacesUsecase>(),
    getPlaceCoordinatesUsecase: getIt<GetPlaceCoordinatesUsecase>(),
    getBranchUsecase: getIt<GetBranchUsecase>()
  ));
  getIt.registerFactory<HomeCubit>(() => HomeCubit(getIt<CategoriesRepository>()));
  getIt.registerFactory<VerifyPhoneCubit>(() => VerifyPhoneCubit(getIt<VerifyPhoneUsecase>()));
  getIt.registerFactory<CategoryProductsCubit>(() => CategoryProductsCubit(getIt<GetCategoryProductsUsecase>()));
  getIt.registerFactory<PrivacyPolicyCubit>(() => PrivacyPolicyCubit(getIt<GetPrivacyPolicyUsecase>()));
  getIt.registerFactory<TermsCubit>(() => TermsCubit(getIt<GetTermsUsecase>()));
}