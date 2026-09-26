import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../di.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/otp_verification_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/coupons/presentation/pages/coupons_and_offers_page.dart';
import '../../features/delivery/presentation/pages/saved_addresses_page.dart';
import '../../features/location/presentation/pages/select_location_page.dart';
import '../../features/location/viewmodels/select_location_viewmodel/select_location_cubit.dart';
import '../../features/favorites/presentation/pages/favorites_page.dart';
import '../../features/legal/presentation/pages/privacy_policy_page.dart';
import '../../features/legal/presentation/pages/terms_and_conditions_page.dart';
import '../../features/orders/presentation/pages/new_order_page.dart';
import '../../features/payment/presentation/pages/payment_methods_page.dart';
import '../../features/payment/presentation/pages/payment_page.dart';
import '../../features/root/domain/entities/item_entity.dart';
import '../../features/root/presentation/pages/main_page.dart';
import '../../features/settings/presentation/pages/notification_settings_page.dart';
import '../../features/settings/presentation/pages/settings_page.dart';
import '../../features/support/presentation/pages/support_page.dart';
import '../../test_page.dart';
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
      case Routes.selectLocation:
        final bool? isInitial = route.arguments as bool?;
        return _materialPageRoute(
          BlocProvider<SelectLocationCubit>(
            create: (BuildContext context) => getIt<SelectLocationCubit>()..getDeviceLocation(),
            child: SelectLocationPage(
              isInitial ?? true
            )
          )
        );
      case Routes.payment:
        return _materialPageRoute(const PaymentPage());
      case Routes.login:
        return _materialPageRoute(const LoginPage());
      case Routes.register:
        return _materialPageRoute(const RegisterPage());
      case Routes.otpVerification:
        final Map<String, String> arguments = route.arguments as Map<String, String>;
        return _materialPageRoute(
          OtpVerificationPage(
            logoUrl: arguments["logo_url"]!,
            phoneNumber: arguments["phone_number"]!
          )
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
      case Routes.paymentMethods:
        return _materialPageRoute(const PaymentMethodsPage());
      case Routes.termsAndConditions:
        return _materialPageRoute(const TermsAndConditionsPage());
      case Routes.privacyPolicy:
        return _materialPageRoute(const PrivacyPolicyPage());
      case Routes.support:
        return _materialPageRoute(const SupportPage());
      case Routes.TEST:
        return _materialPageRoute(const TestPage());
    }
    return _materialPageRoute(const HomePage());
  }

  static MaterialPageRoute<T> _materialPageRoute<T>(Widget view)
  => MaterialPageRoute<T>(builder: (BuildContext _) => view);
}
