import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../di.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/otp_verification_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/coupons/presentation/pages/coupons_and_offers_page.dart';
import '../../features/delivery/presentation/pages/saved_addresses_page.dart';
import '../../features/delivery/presentation/viewmodels/saved_address_model/saved_addresses_cubit.dart';
import '../../features/location/presentation/pages/select_location_page.dart';
import '../../features/location/presentation/viewmodels/select_location_viewmodel/select_location_cubit.dart';
import '../../features/favorites/presentation/pages/favorites_page.dart';
import '../../features/legal/presentation/pages/privacy_policy_page.dart';
import '../../features/legal/presentation/pages/terms_and_conditions_page.dart';
import '../../features/orders/presentation/pages/new_order_page.dart';
import '../../features/payment/presentation/pages/payment_page.dart';
import '../../features/payment/presentation/viewmodels/checkout_viewmodel/checkout_cubit.dart';
import '../../features/payment/presentation/viewmodels/payment_methods_viewmodel/payment_methods_cubit.dart';
import '../../features/profile/domain/entities/profile_entity.dart';
import '../../features/profile/presentation/pages/edit_phone_page.dart';
import '../../features/profile/presentation/pages/edit_profile_page.dart';
import '../../features/root/domain/entities/category_entity.dart';
import '../../features/root/domain/entities/item_entity.dart';
import '../../features/root/presentation/pages/category_products_page.dart';
import '../../features/root/presentation/pages/main_page.dart';
import '../../features/root/presentation/viewmodels/search_viewmodel/search_cubit.dart';
import '../../features/settings/presentation/pages/notification_settings_page.dart';
import '../../features/settings/presentation/pages/settings_page.dart';
import '../../features/support/presentation/pages/support_page.dart';
import '../../features/wallet/presentation/viewmodels/balance_viewmodel/balance_cubit.dart';
import '../../features/wallet/presentation/pages/topup_page.dart';
import '../../features/wallet/domain/entities/wallet_transaction_entity.dart';
import '../../features/wallet/presentation/pages/wallet_page.dart';
import '../../features/wallet/presentation/pages/wallet_transactions_page.dart';
import '../../splash_page.dart';
import 'routes.dart';

abstract final class AppRoutes{
  static Route<Object?> onGenerateRoute(RouteSettings route){
    switch(route.name){
      case Routes.main:
        return _materialPageRoute(const HomePage());
      case Routes.newOrder:
        return _materialPageRoute<bool>(
          NewOrderPage(route.arguments as ItemEntity)
        );
      case Routes.categoryProducts:
        final (List<CategoryEntity> categories, int initialCategoryIndex) = route.arguments as (List<CategoryEntity>, int);
        return _materialPageRoute(
          BlocProvider<SearchCubit>(
            create: (BuildContext context) => getIt<SearchCubit>(),
            child: CategoryProductsPage(
              categories: categories,
              initialCategoryIndex: initialCategoryIndex,
            ),
          )
        );
      case Routes.selectLocation:
        final bool? isInitial = route.arguments as bool?;
        return _materialPageRoute<bool>(
          BlocProvider<SelectLocationCubit>(
            create: (BuildContext context) => getIt<SelectLocationCubit>()..getDeviceLocation(),
            child: SelectLocationPage(
              isInitial ?? true
            )
          )
        );
      case Routes.payment:
        return _materialPageRoute(
          MultiBlocProvider(
            providers: <BlocProvider>[
              BlocProvider<CheckoutCubit>(
                create: (BuildContext context) => getIt<CheckoutCubit>()
              ),
              BlocProvider<BalanceCubit>(
                create: (BuildContext context) => getIt<BalanceCubit>()..init()
              ),
              BlocProvider<SavedAddressesCubit>(
                create: (BuildContext context) => getIt<SavedAddressesCubit>()..init()
              )
            ],
            child: const PaymentPage()
          )
        );
      case Routes.login:
        return _materialPageRoute(const LoginPage());
      case Routes.register:
        return _materialPageRoute(const RegisterPage());
      case Routes.otpVerification:
        return _materialPageRoute(
          OtpVerificationPage(route.arguments as String)
        );
      case Routes.couponsAndOffers:
        return _materialPageRoute(const CouponsAndOffersPage());
      case Routes.favorites:
        return _materialPageRoute(const FavoritesPage());
      case Routes.settings:
        return _materialPageRoute(const SettingsPage());
      case Routes.notificationSettings:
        return _materialPageRoute(const NotificationSettingsPage());
      case Routes.savedAddresses:
        return _materialPageRoute(const SavedAddressesPage());
      case Routes.termsAndConditions:
        return _materialPageRoute(const TermsAndConditionsPage());
      case Routes.privacyPolicy:
        return _materialPageRoute(const PrivacyPolicyPage());
      case Routes.support:
        return _materialPageRoute(const SupportPage());
      case Routes.editProfile:
        final ProfileEntity profile = route.arguments as ProfileEntity;
        return _materialPageRoute<ProfileEntity>(EditProfilePage(profile));
      case Routes.editPhone:
        return _materialPageRoute(const EditPhonePage());
      case Routes.splash:
        return _materialPageRoute(const SplashPage());
      case Routes.wallet:
        return _materialPageRoute(const WalletPage());
      case Routes.topup:
        return _materialPageRoute(
          BlocProvider<PaymentMethodsCubit>(
            create: (BuildContext context) => getIt<PaymentMethodsCubit>()..init(),
            child: const TopupPage()
          )
        );
      case Routes.walletTransactions:
        return _materialPageRoute(
          WalletTransactionsPage(route.arguments as List<WalletTransactionEntity>)
        );
    }
    return _materialPageRoute(const HomePage());
  }

  static MaterialPageRoute<T> _materialPageRoute<T>(Widget view)
  => MaterialPageRoute<T>(builder: (BuildContext _) => view);
}