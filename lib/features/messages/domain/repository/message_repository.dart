import 'package:quiz_app/core/error.dart';
import 'package:quiz_app/features/messages/domain/entity/message.dart';
import 'package:dartz/dartz.dart';

abstract class MessageRepository {
  Future<Either<Failure, List<Message>>> fetchMessages();
  Future<Either<Failure, void>> addMessage(Message message);
  Future<Either<Failure, void>> removeMessage(int index);
  Future<Either<Failure, void>> updateMessage(int index, Message message);
  Future<Either<Failure, void>> removeAllMessages();
}