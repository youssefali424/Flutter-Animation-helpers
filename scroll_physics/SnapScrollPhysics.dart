import 'dart:math';

import 'package:flutter/material.dart';

enum DummyChangePhysics { L, H }

class SnapScrollPhysics extends ScrollPhysics {
  final double mainAxisStartPadding;
  final double itemExtent;
  // final double centerPadding;

  const SnapScrollPhysics({
    ScrollPhysics parent,
    this.mainAxisStartPadding = 0.0,
    @required this.itemExtent,
    // @required this.centerPadding,
  }) : super(
          parent: parent,
        );

  @override
  SnapScrollPhysics applyTo(ScrollPhysics ancestor) {
    return SnapScrollPhysics(
      parent: buildParent(ancestor),
      mainAxisStartPadding: mainAxisStartPadding,
      itemExtent: itemExtent,
      // centerPadding: centerPadding
    );
  }

  double _getItem(ScrollPosition position) {
    return ((position.pixels) / itemExtent);
  }

  double _getPixels(ScrollPosition position, double item) {
    return min((item * itemExtent), position.maxScrollExtent);
  }

  double _getTargetPixels(
      ScrollPosition position, Tolerance tolerance, double velocity) {
    double item = _getItem(position);
    // print(item.toString() + " item before");
    if (velocity < -tolerance.velocity)
      item -= 0.5;
    else if (velocity > tolerance.velocity) item += 0.5;
    // print(item.toString() + " item");
    return _getPixels(position, item.roundToDouble());
  }

  @override
  Simulation createBallisticSimulation(
      ScrollMetrics position, double velocity) {
    // If we're out of range and not headed back in range, defer to the parent
    // ballistics, which should put us back in range at a page boundary.
    if ((velocity <= 0.0 && position.pixels <= position.minScrollExtent) ||
        (velocity >= 0.0 && position.pixels >= position.maxScrollExtent))
      return super.createBallisticSimulation(position, velocity);
    final Tolerance tolerance = this.tolerance;
    final double target = _getTargetPixels(position, tolerance, velocity);
    if (target != position.pixels)
      return ScrollSpringSimulation(spring, position.pixels, target, velocity,
          tolerance: tolerance);
    return null;
  }

  @override
  bool get allowImplicitScrolling => false;
}