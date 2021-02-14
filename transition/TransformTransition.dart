import 'package:flutter/widgets.dart';

typedef TransformFuntion<I, E> = E Function(I input);
typedef Build<I> = Widget Function(BuildContext context, I value, Widget child);

class TransformTransition<T, O> extends AnimatedWidget {
  const TransformTransition({
    Key key,
    @required Animation<T> turns,
    @required this.transformFuntion,
    @required this.buildChild,
    this.child,
  }) : super(key: key, listenable: turns);

  Animation<T> get turns => listenable;
  final TransformFuntion<T, O> transformFuntion;
  final Build<O> buildChild;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return buildChild.call(
        context,
        transformFuntion.call(
          turns?.value,
        ),
        this.child);
  }
}
