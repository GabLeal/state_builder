abstract class StateType {}

class InitialState extends StateType {}

class LoadingState extends StateType {}

class SuccessState<T> extends StateType {
  final T result;

  SuccessState(this.result)
      : assert(result.runtimeType != dynamic, 'add type param');
}

class ErrorState extends StateType {
  final String message;

  ErrorState(this.message);
}
