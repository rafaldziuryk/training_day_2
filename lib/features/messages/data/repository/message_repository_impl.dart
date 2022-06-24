import 'package:dartz/dartz.dart';
import 'package:quiz_app/core/error.dart';
import 'package:quiz_app/features/messages/data/data_source/local_message_data_source.dart';
import 'package:quiz_app/features/messages/domain/entity/message.dart';
import 'package:quiz_app/features/messages/domain/repository/message_repository.dart';

class MessageRepositoryImpl implements MessageRepository {
  const MessageRepositoryImpl({
    required this.localMessageDataSource,
  });

  final LocalMessageDataSource localMessageDataSource;

  @override
  Future<Either<Failure, void>> addMessage(Message message) async {
    try {
      await localMessageDataSource.addMessageToLocalStorage(message);
      return const Right(null);
    } catch (e) {
      return Left(UnkownFailure());
    }
  }

  @override
  Future<Either<Failure, List<Message>>> fetchMessages() async {
    try {
      final data = await localMessageDataSource.fetchMessagesFromLocalStorage();
      return Right(data);
    } catch (e) {
      return Left(UnkownFailure());
    }
    ;
  }

  @override
  Future<Either<Failure, void>> removeAllMessages() async {
    try {
      await localMessageDataSource.removeAllMessagesInLocalStorage();
      return const Right(null);
    } catch (e) {
      return Left(UnkownFailure());
    }
  }

  @override
  Future<Either<Failure, void>> removeMessage(int index) async {
    try {
      await localMessageDataSource.removeMessageFromLocalStorage(index);
      return const Right(null);
    } catch (e) {
      return Left(UnkownFailure());
    }
  }

  @override
  Future<Either<Failure, void>> updateMessage(
      int index, Message message) async {
    try {
      await localMessageDataSource.updateMessageInLocalStorage(index, message);
      return const Right(null);
    } catch (e) {
      return Left(UnkownFailure());
    }
  }
}
