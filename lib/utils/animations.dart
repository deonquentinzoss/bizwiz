import 'package:flutter/material.dart';

class Animations {
  static const Duration defaultDuration = Duration(milliseconds: 300);
  static const Duration shortDuration = Duration(milliseconds: 150);
  static const Duration longDuration = Duration(milliseconds: 500);

  static const Curve defaultCurve = Curves.easeInOut;
  static const Curve bounceCurve = Curves.bounceOut;
  static const Curve elasticCurve = Curves.elasticOut;

  static Widget fadeIn({
    required Widget child,
    Duration duration = defaultDuration,
    Curve curve = defaultCurve,
  }) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: duration,
      curve: curve,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: child,
        );
      },
      child: child,
    );
  }

  static Widget slideIn({
    required Widget child,
    Duration duration = defaultDuration,
    Curve curve = defaultCurve,
    Offset offset = const Offset(0, 20),
  }) {
    return TweenAnimationBuilder<Offset>(
      tween: Tween(begin: offset, end: Offset.zero),
      duration: duration,
      curve: curve,
      builder: (context, value, child) {
        return Transform.translate(
          offset: value,
          child: child,
        );
      },
      child: child,
    );
  }

  static Widget scaleIn({
    required Widget child,
    Duration duration = defaultDuration,
    Curve curve = defaultCurve,
    double begin = 0.8,
  }) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: begin, end: 1.0),
      duration: duration,
      curve: curve,
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: child,
        );
      },
      child: child,
    );
  }

  static Widget fadeSlideIn({
    required Widget child,
    Duration duration = defaultDuration,
    Curve curve = defaultCurve,
    Offset offset = const Offset(0, 20),
  }) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: duration,
      curve: curve,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: offset * (1 - value),
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}
