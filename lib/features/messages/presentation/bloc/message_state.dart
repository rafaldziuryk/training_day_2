part of 'message_bloc.dart';

abstract class MessageState extends Equatable {
  const MessageState();
}

class MessageInitial extends MessageState {
  @override
  List<Object> get props => [];
}

class MessageData extends MessageState {
  final List<Message> messages;

  const MessageData({
    required this.messages,
  });

  @override
  List<Object?> get props => [messages, DateTime.now()];
}
