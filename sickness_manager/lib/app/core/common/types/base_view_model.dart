import 'package:flutter/foundation.dart';

abstract class BaseViewModel<T> {
  void init();

  void clear();

  ValueListenable<T> get state;
}
