import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'config/routing/on_generate_route.dart';
import 'config/routing/routes.dart';
import 'config/theming/light_theme.dart';
import 'core/utils/app_locales.dart';
import 'di.dart';
import 'features/cart/presentation/viewmodel/cart_cubit.dart';
import 'l10n/app_localizations.dart';
import 'language_controller.dart';
import 'theme_controller.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  await Hive.initFlutter();
  await setupDependencyInjection();
  await SystemChrome.setPreferredOrientations(const <DeviceOrientation>[
    .portraitUp,
    .portraitDown,
  ]);
  
  runApp(const MyApp());
}

final class const MyApp({super.key}) extends StatelessWidget {

  @override
  BlocProvider<CartCubit> build(BuildContext context)
  => BlocProvider<CartCubit>(
    create: (BuildContext context) => getIt<CartCubit>()..init(),
    child: ValueListenableBuilder<String>(
      valueListenable: getIt<LanguageController>(),
      builder: (BuildContext context, String langCode, Widget? _)
      => ValueListenableBuilder<ThemeMode>(
        valueListenable: getIt<ThemeController>(),
        builder: (BuildContext context, ThemeMode themeMode, Widget? _)
        => MaterialApp(
          theme: lightTheme,
          darkTheme: .dark(),
          themeMode: themeMode,
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
          initialRoute: Routes.splash
        )
      )
    ),
  );
}