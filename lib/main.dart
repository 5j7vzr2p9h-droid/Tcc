import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'auth_controller.dart';
import 'config/routing/on_generate_route.dart';
import 'config/routing/routes.dart';
import 'config/theming/light_theme.dart';
import 'core/utils/app_locales.dart';
import 'di.dart';
import 'features/cart/presentation/viewmodel/cart_cubit.dart';
import 'l10n/app_localizations.dart';
import 'language_controller.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load();
  await Hive.initFlutter();
  final String? token = await setupDependencyInjection();
  await SystemChrome.setPreferredOrientations(const <DeviceOrientation>[
    .portraitUp,
    .portraitDown,
  ]);
  runApp(
    MyApp(
      token is String
        ? Routes.main
        : Routes.login
    )
  );
}

final class const MyApp(final String _initialRoute, {super.key}) extends StatelessWidget {
  static final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();


  @override
  MultiBlocProvider build(BuildContext context)
  => MultiBlocProvider(
    providers: <BlocProvider>[
      BlocProvider<CartCubit>(
        create: (BuildContext _) => getIt<CartCubit>()..init()
      ),
      BlocProvider<AuthCubit>(
        create: (BuildContext _) => getIt<AuthCubit>(),
      )
    ],
    child: BlocListener<AuthCubit, AuthState>(
      listener: (BuildContext context, AuthState state){
        if(state is UnauthenticateSuccessState)
          _navigatorKey.currentState!.pushNamedAndRemoveUntil(
            Routes.login,
            (Route<dynamic> route) => false
          );
      },
      child: ValueListenableBuilder<String>(
        valueListenable: getIt<LanguageController>(),
        builder: (BuildContext context, String langCode, Widget? _)
        => MaterialApp(
          navigatorKey: _navigatorKey,
          theme: lightTheme,
          onGenerateRoute: AppRoutes.onGenerateRoute,
          localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
            AppLocalizations.delegate,
            ...GlobalMaterialLocalizations.delegates,
          ],
          locale: Locale(langCode),
          supportedLocales: const <Locale>[
            Locale(AppLocales.ar),
            Locale(AppLocales.en)
          ],
          initialRoute: _initialRoute
        )
      ),
    ),
  );
}