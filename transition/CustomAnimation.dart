import 'package:flutter/material.dart';

typedef ChangeFunction<R, I> = R Function(Animation<I> animation);

class CustomAnimation<O, T> extends Animation<T> {
  Animation<O> animation;
  ChangeFunction<T, O> changeFunction;
  CustomAnimation(this.animation, this.changeFunction);

  @override
  void addListener(void Function() listener) {
    this.animation.addListener(listener);
  }

  @override
  void addStatusListener(void Function(AnimationStatus status) listener) {
    this.animation.addStatusListener(listener);
  }

  @override
  void removeListener(void Function() listener) {
    this.animation.removeListener(listener);
  }

  @override
  void removeStatusListener(void Function(AnimationStatus status) listener) {
    this.animation.removeStatusListener(listener);
  }

  @override
  // TODO: implement status
  AnimationStatus get status => this.animation.status;

  @override
  // TODO: implement value
  get value => changeFunction(this.animation);
}
