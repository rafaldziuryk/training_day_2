part of 'init_bloc.dart';

abstract class InitState extends Equatable {
  const InitState();
}

class InitInitial extends InitState {
  @override
  List<Object> get props => [];
}

class InitSuccess extends InitState {
  @override
  // TODO: implement props
  List<Object?> get props => [];

}
