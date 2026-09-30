import 'dart:async';

import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../core/widgets/handled_network_image.dart';

final class const BannersSlider(this._banners, {super.key}) extends StatefulWidget {
  final List<String> _banners;

  @override
  State<BannersSlider> createState() => _BannersSliderState();
}

final class _BannersSliderState extends State<BannersSlider> {
  final PageController _pageController = PageController();
  late final Timer _t;

  @override
  void initState(){
    super.initState();
    _t = Timer.periodic(
      const Duration(seconds: 3),
      (Timer t){
        print(_pageController.page);
        _pageController.page!.toInt() == widget._banners.length -1
          ? _pageController.animateToPage(
            0,
            duration: const Duration(milliseconds: 400),
            curve: Curves.fastOutSlowIn
          )
          : _pageController.nextPage(
            duration: const Duration(milliseconds: 400),
            curve: Curves.fastOutSlowIn
          );
      }
    );
  }

  @override
  void dispose(){
    _pageController.dispose();
    _t.cancel();
    super.dispose();
  }

  @override
  Stack build(BuildContext context)
  => Stack(
    alignment: .bottomCenter,
    children: [
      PageView.builder(
        controller: _pageController,
        itemCount: widget._banners.length,
        itemBuilder: (BuildContext context , int i) => HandledNetworkImage(
          imageUrl: widget._banners[i],
        )
      ),
      Padding(
        padding: const .only(bottom: 12.0),
        child: SmoothPageIndicator(
          controller: _pageController,
          count: 3,
          effect: ExpandingDotsEffect(
            dotWidth: 12.0,
            dotHeight: 12.0,
            activeDotColor: Theme.of(context).colorScheme.primary,
          ),
      ),
      )
    ]
  );
}