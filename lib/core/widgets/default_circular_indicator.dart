import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../utils/assets_manager.dart';

final class const DefaultCircularIndicator({super.key}) extends StatelessWidget {

  @override
  LottieBuilder build(BuildContext context)
  => Lottie.asset(
    AssetsManager.circleLoading,
    height: 100.0,
  );
}