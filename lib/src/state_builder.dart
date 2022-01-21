import 'package:flutter/material.dart';

import 'state_notifier.dart';
import 'state_type.dart';

class StateBuilder<T> extends StatelessWidget {
  final StateNotifier<T> stateNotifier;

  final Widget initialState;

  final Widget onLoading;
  final Widget Function(String message) onError;
  final Widget Function(T result) onSuccess;

  /// The StateBuilder create a widget to control the base states of a VIEW
  ///
  /// This constructor receive five params
  /// * The param `stateNotifier` must receive a variable type
  /// ```
  /// StateNotifier<T>.
  /// ```
  /// {@end-tool}
  /// `T` must be the expected type for the success state case (SuccessState)
  ///
  ///* The parameters `initialState`,`onLoading`,
  ///must receive a widget that will be shown in the VIEW when its respective state is active
  ///
  /// P.S: The same goes for the params `onError`,`onSuccess`. Yet:
  ///
  /// *`onError`: receive callback Widget function(String message)
  ///
  /// *`onSuccess`:  receive callback Widget function(T result)
  ///
  ///
  /// This example shows how to create [StateBuilder]
  ///
  ///`Exemple VIEWMODEL`
  /// ```dart
  /// class NameViewModel{
  ///   final eventState = StateNotifier<List<EventModel>>();
  ///
  ///   Future<void> fetchEvents() async {
  ///     eventState.value = LoadingState();
  ///
  ///     Future.delay(Duration(seconds: 2),{
  ///         List<EventModel>> listEvents = [
  ///           EventModel(id: '001', name: 'event one')
  ///           EventModel(id: '001', name: 'event two')
  ///         ];
  ///         eventState.value = SuccessState(listEvents);
  ///     });
  ///
  ///     Future.delay(Duration(seconds: 4),{
  ///        eventState.value = ErrorState('Parece que sua conexao com a internet caiu. Tente mais tarde.');
  ///     });
  ///
  ///   }
  /// }
  /// ```
  ///{@end-tool}

  ///`Exemple VIEW`
  ///```dart
  ///
  /// //[define variable viewModel]
  /// NameViewModel nameviewmodel = NameViewModel()
  ///
  ///
  /// //[call the function inside initstate or in another place that makes more sense]
  /// @override
  /// void initState() {
  ///   Future.delayed(Duration.zero, () {
  ///     nameviewmodel.fetchEvents();
  ///   });
  ///   super.initState();
  /// }
  ///
  ///
  /// //[Create Widget inside the method build]
  ///
  /// return StateBuilder<List<EventModel>>(
  ///   stateNotifier: nameviewmodel.eventState,
  ///   initialState: Container(),
  ///   onLoading: CircularProgressIndicator(),
  ///   onError: (errorMessage){
  ///     return Contaier(
  ///       child: Text(errorMessage)
  ///     );
  ///   },
  ///   onSuccess: (result){
  ///     return ListView.builder(
  ///       itemCount: result.length,
  ///       itemBuilder: (context, index) {
  ///         return Contaier(
  ///           color: Colors.blue
  ///           child: Text(result.nameEvent)
  ///        );
  ///       },
  ///     );
  /// ```
  /// {@end-tool}
  ///
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
