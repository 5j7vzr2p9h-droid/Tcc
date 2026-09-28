import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'config/routing/routes.dart';
import 'di.dart';

final class const SplashPage({super.key}) extends StatefulWidget {

  @override
  State<SplashPage> createState() => _SplashPageState();
}

final class _SplashPageState extends State<SplashPage> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 3)
  );

  @override
  void initState() {
    super.initState();
    _controller.forward();
    WidgetsBinding.instance.addPostFrameCallback((Duration _) async{
      await Future.delayed(const Duration(seconds: 5));
      final String? token = await getIt<FlutterSecureStorage>().read(key: "token");
      if(mounted)
        Navigator.pushReplacementNamed(
          context,
          token is String
            ? Routes.main
            : Routes.selectLocation
        );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Scaffold build(BuildContext context)
  => Scaffold(
    backgroundColor: Colors.white,
    body: Center(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (BuildContext _, Widget? _)
        => _AnimatedLogo(_controller.value)
      )
    )
  );
}

/// The animated logo at [_progress] (0 → 1) of its timeline.
///
/// Sizes are fractions of the ring's outer diameter and intervals are fractions
/// of the 3s timeline, both measured from the original GIF frames.
final class const _AnimatedLogo(final double _progress) extends StatelessWidget {
  static const Interval _circleInterval = Interval(0.04, 0.213, curve: Cubic(0.175, 0.885, 0.32, 1.2)),
    _ringInterval = Interval(0.233, 0.5, curve: Curves.easeInOut),
    _bannerInterval = Interval(0.533, 0.678),
    _theInterval = Interval(0.707, 0.76),
    _nameInterval = Interval(0.783, 0.89),
    _sloganInterval = Interval(0.917, 0.99);

  /// The banner and its texts are tilted ~5.9° counterclockwise.
  static const double _tilt = -0.1025;

  static const TextStyle _textStyle = TextStyle(
    color: Colors.black,
    fontWeight: .w900,
    fontFamily: "Coopbl"
  );

  @override
  Directionality build(BuildContext context) {
    final double size = MediaQuery.sizeOf(context).shortestSide * 0.65,
      ring = _ringInterval.transform(_progress),
      banner = _bannerInterval.transform(_progress),
      bannerHeight = size * 0.324,
      line = size * 0.0245,
      labelHeight = size * 0.14;

    return Directionality(
      // The logo never mirrors, whatever the app's language.
      textDirection: .ltr,
      child: SizedBox(
        width: size * 1.2,
        height: size,
        child: Stack(
          alignment: .center,
          clipBehavior: .none,
          children: <Widget>[
            // Not a CircleAvatar: it animates radius changes over 200ms internally,
            // which lags behind the controller and flattens the overshoot.
            Transform.scale(
              scale: _circleInterval.transform(_progress),
              child: SizedBox.square(
                dimension: size * 0.856,
                child: const DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: .circle
                  )
                )
              )
            ),
            _RingStroke(
              diameter: size,
              strokeWidth: size * 0.072,
              color: Colors.black,
              value: ring
            ),
            _RingStroke(
              diameter: size * 0.959,
              strokeWidth: size * 0.041,
              color: Theme.of(context).colorScheme.primary,
              value: ring
            ),
            Transform.translate(
              offset: Offset(0.0, size * -0.025),
              child: Transform.rotate(
                angle: _tilt,
                child: SizedBox(
                  width: size * 1.15,
                  height: bannerHeight,
                  child: Stack(
                    fit: .expand,
                    clipBehavior: .none,
                    children: <Widget>[
                      ClipRect(
                        clipper: _WipeClipper(banner),
                        child: Column(
                          crossAxisAlignment: .stretch,
                          children: <Widget>[
                            // Room for the top line, drawn below around "The".
                            SizedBox(height: line),
                            Expanded(
                              child: ColoredBox(
                                color: Colors.white,
                                child: Padding(
                                  padding: .symmetric(horizontal: size * 0.03),
                                  child: FittedBox(
                                    fit: .scaleDown,
                                    child: ClipRect(
                                      clipper: _WipeClipper(_nameInterval.transform(_progress)),
                                      child: Text(
                                        'CREPE COMPANY',
                                        style: _textStyle.copyWith(fontSize: size * 0.14)
                                      )
                                    )
                                  )
                                )
                              )
                            ),
                            SizedBox(
                              height: line,
                              child: const ColoredBox(color: Colors.black)
                            )
                          ]
                        )
                      ),
                      // The top line, with its gap sized to fit "The" exactly.
                      Positioned(
                        left: 0.0,
                        right: 0.0,
                        top: (line - labelHeight * 1.5) / 2,
                        height: labelHeight * 1.5,
                        child: ClipRect(
                          clipper: _WipeClipper(banner),
                          child: Row(
                            children: <Widget>[
                              SizedBox(
                                width: size * 0.2,
                                height: line,
                                child: const ColoredBox(color: Colors.black)
                              ),
                              Padding(
                                padding: .symmetric(horizontal: size * 0.02),
                                child: ClipRect(
                                  clipper: _WipeClipper(_theInterval.transform(_progress)),
                                  child: Text(
                                    'The',
                                    style: _textStyle.copyWith(fontSize: size * 0.12)
                                  )
                                )
                              ),
                              Expanded(
                                child: SizedBox(
                                  height: line,
                                  child: const ColoredBox(color: Colors.black)
                                )
                              )
                            ]
                          )
                        )
                      ),
                      Positioned(
                        left: 0.0,
                        right: 0.0,
                        top: bannerHeight,
                        height: labelHeight,
                        child: Center(
                          child: ClipRect(
                            clipper: _WipeClipper(_sloganInterval.transform(_progress)),
                            child: Text.rich(
                              TextSpan(
                                text: 'A One Of A Kind',
                                children: <InlineSpan>[
                                  WidgetSpan(
                                    alignment: .top,
                                    child: Text(
                                      '®',
                                      style: _textStyle.copyWith(fontSize: size * 0.035)
                                    )
                                  )
                                ]
                              ),
                              style: _textStyle.copyWith(
                                fontSize: size * 0.08,
                                fontWeight: .w800
                              )
                            )
                          )
                        )
                      )
                    ]
                  )
                )
              )
            )
          ]
        )
      )
    );
  }
}

/// One layer of the ring, drawn clockwise from 12 o'clock up to [_value].
final class const _RingStroke({
  required final double _diameter,
  required final double _strokeWidth,
  required final Color _color,
  required final double _value
}) extends StatelessWidget {

  @override
  SizedBox build(BuildContext context)
  => SizedBox.square(
    dimension: _diameter,
    child: CircularProgressIndicator(
      value: _value,
      color: _color,
      backgroundColor: Colors.transparent,
      strokeWidth: _strokeWidth,
      strokeAlign: CircularProgressIndicator.strokeAlignInside,
      strokeCap: .butt,
      padding: .zero
    )
  );
}

/// Reveals its child from left to right as [_progress] goes from 0 to 1.
final class const _WipeClipper(final double _progress) extends CustomClipper<Rect> {

  @override
  Rect getClip(Size size) => Rect.fromLTWH(0.0, -size.height, size.width * _progress, size.height * 3.0);

  @override
  bool shouldReclip(_WipeClipper oldClipper) => oldClipper._progress != _progress;
}
