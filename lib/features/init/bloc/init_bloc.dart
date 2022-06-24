import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quiz_app/core/dependency_injection.dart';

part 'init_event.dart';
part 'init_state.dart';

class InitBloc extends Bloc<InitEvent, InitState> {
  InitBloc() : super(InitInitial()) {
    on<InitEvent>((event, emit) async {
      if (event is InitApp) {
        // await DiContainer().init();
        await Future.delayed(const Duration(seconds: 2));
        emit(InitSuccess());
      }
    });
  }
}
