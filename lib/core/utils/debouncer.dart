import 'dart:async';

import 'package:flutter/material.dart';

final class Debouncer {
  final Duration delay;
  Timer? _timer;

  Debouncer({required this.delay});

  void run(VoidCallback action) {
    cancel();
    _timer = Timer(delay, action);
  }

  void cancel() => _timer?.cancel();
}