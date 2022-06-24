part of 'init_bloc.dart';

abstract class InitEvent extends Equatable {
  const InitEvent();
}

class InitApp extends InitEvent {
  @override
  List<Object?> get props => [];
}
