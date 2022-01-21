import 'package:flutter/material.dart';

import 'state_notifier.dart';
import 'state_type.dart';

class StateBuilder<T> extends StatelessWidget {
  final StateNotifier<T> stateNotifier;
  final Widget initialState;
  final Widget onLoading;
  final Widget Function(String message) onError;
  final Widget Function(T result) onSuccess;

  const StateBuilder({
    required this.stateNotifier,
    required this.initialState,
    required this.onLoading,
    required this.onError,
    required this.onSuccess,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<StateType>(
      valueListenable: stateNotifier,
      builder: (context, state, child) {
        if (state is LoadingState) {
          return onLoading;
        } else if (state is SuccessState<T>) {
          return onSuccess(state.result);
        } else if (state is ErrorState) {
          return onError(state.message);
        } else {
          return initialState;
        }
      },
    );
  }
}
