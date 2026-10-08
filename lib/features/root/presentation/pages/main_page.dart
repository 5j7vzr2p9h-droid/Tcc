import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/routing/routes.dart';
import '../../../../core/constants/numerical_values.dart';
import '../../../../core/widgets/rounded_bottom_navigation_bar.dart';
import '../../../../di.dart';
import '../../../cart/presentation/viewmodel/cart_cubit.dart';
import '../../../cart/presentation/viewmodel/cart_state.dart';
import '../../../cart/presentation/widgets/cart_summary_bar.dart';
import '../../../notifications/presentation/pages/notifications_page.dart';
import '../../../orders/presentation/pages/my_orders_page.dart';
import '../../../profile/presentation/widgets/profile_tab.dart';
import '../viewmodels/home_viewmodel/home_cubit.dart';
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
            0 => BlocProvider<HomeCubit>(
              create: (BuildContext context) => getIt<HomeCubit>()..init(),
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
          child: Column(
            mainAxisSize: .min,
            children: <Widget>[
              BlocBuilder<CartCubit, CartState>(
                builder: (BuildContext context, CartState state)
                => state.isEmpty
                ? const SizedBox.shrink()
                : Padding(
                  padding: const .only(
                    right: pageContentPadding,
                    left: pageContentPadding,
                    bottom: 4.0
                  ),
                  child: CartSummaryBar(
                    onTap: () => Navigator.pushNamed(context, Routes.payment)
                  ),
                ),
              ),
              RoundedBottomNavigationBar(
                indexController: _currentPageIndex,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
