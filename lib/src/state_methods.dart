import 'package:flutter/material.dart';

abstract class StateMethods<T> {
  Widget initialState();
  Widget onLoading();
  Widget onError(String message);
  Widget onSuccess(T result);
}
