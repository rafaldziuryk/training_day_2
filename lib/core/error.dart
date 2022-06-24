import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object> get props => [];
}

//Failure classes
class ServerFailure extends Failure {}

class UnkownFailure extends Failure {}