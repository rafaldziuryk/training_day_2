import 'package:dartz/dartz.dart';
import 'package:quiz_app/core/error.dart';
import 'package:quiz_app/features/messages/domain/entity/message.dart';
import 'package:quiz_app/features/messages/domain/repository/message_repository.dart';

import '../../../../core/use_case.dart';

class FetchMessagesUseCase extends UseCase<List<Message>, NoParams> {
  FetchMessagesUseCase({required this.repository});

  final MessageRepository repository;

  @override
  Future<Either<Failure, List<Message>>> call(NoParams params) {
    return repository.fetchMessages();
  }
}