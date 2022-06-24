part of 'message_bloc.dart';

abstract class MessageEvent extends Equatable {
  const MessageEvent();
}

class MessageInit extends MessageEvent {
  @override
  List<Object?> get props => [];
}

class MessageAdd extends MessageEvent {
  final Message message;

  @override
  List<Object?> get props => [];

  const MessageAdd({
    required this.message,
  });
}

class MessageRemove extends MessageEvent {
  final int index;

  @override
  List<Object?> get props => [];

  const MessageRemove({
    required this.index,
  });
}

class MessagesRemove extends MessageEvent {
  @override
  List<Object?> get props => [];
}