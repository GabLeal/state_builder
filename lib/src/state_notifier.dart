import 'package:flutter/material.dart';
import 'state_type.dart';

class StateNotifier<T> extends ValueNotifier<StateType> {
  StateNotifier() : super(InitialState());

  T get result => (value as SuccessState<T>).result;
}
