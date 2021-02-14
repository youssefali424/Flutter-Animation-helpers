import 'dart:math';

snapPoint(
  double value,
  double velocity,
  List<double> points,
) {
  var point = value + 0.2 * velocity;
  var deltas = points.map((p) => (point - p).abs()).toList();
  var minDelta = deltas.reduce(min);
  return points.where((p) => (point - p).abs() == minDelta).toList()[0];
}
