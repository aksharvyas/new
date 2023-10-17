import 'dart:html';

import 'package:bloc/blocs/internet_bloc/internet_event.dart';
import 'package:bloc/blocs/internet_bloc/internet_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InternetBloc extends Bloc<InternetEvent, InternetState> {
  InternetBloc() : super(InternetInitialState());

  @override
  Stream<InternetState> mapEventToState(InternetEvent event) async* {
    // TODO: implement mapEventToState
  }
}