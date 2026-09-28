import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/rounded_bottom_navigation_bar.dart';
import '../../../../di.dart';
import '../../../notifications/presentation/pages/notifications_page.dart';
import '../../../orders/presentation/pages/my_orders_page.dart';
import '../../../profile/presentation/widgets/profile_tab.dart';
import '../viewmodels/home_viewmodel/home_cubit.dart';
import '../viewmodels/search_viewmodel/search_cubit.dart';
import '../widgets/home_tab.dart';

final class HomePage extends StatefulWidget {

  const new({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

final class _HomePageState extends State<HomePage> {
  final ValueNotifier<int> _currentPageIndex = ValueNotifier<int>(0);

  @override
  Scaffold build(BuildContext context)
  => Scaffold(
    resizeToAvoidBottomInset: false,
    body: Stack(
      children: <Widget>[
        ValueListenableBuilder(
          valueListenable: _currentPageIndex,
          builder: (BuildContext context, int i, Widget? child) => switch(i){
            0 => MultiBlocProvider(
              providers: [
                BlocProvider<HomeCubit>(
                  create: (BuildContext context) => getIt<HomeCubit>()..init()
                ),
                BlocProvider<SearchCubit>(
                  create: (BuildContext context) => getIt<SearchCubit>()
                ),
              ],
              child: const HomeTab()
            ),
            1 => const MyOrdersTab(),
            2 => NotificationsTab(
              onOrdersPressed: () => _currentPageIndex.value = 1,
            ),
            3 => ProfileTab(() => _currentPageIndex.value = 1),
            _ => const SizedBox()
          },
        ),
        Align(
          alignment: .bottomCenter,
          child: RoundedBottomNavigationBar(
            indexController: _currentPageIndex,
          ),
        ),
      ],
    ),
  );
}
