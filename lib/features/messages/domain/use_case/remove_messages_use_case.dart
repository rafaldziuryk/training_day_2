import 'package:dartz/dartz.dart';

import 'package:quiz_app/core/error.dart';
import 'package:quiz_app/features/messages/domain/repository/message_repository.dart';

import '../../../../core/use_case.dart';

class RemoveMessagesUseCase extends UseCase<void, NoParams> {
  RemoveMessagesUseCase({required this.repository});

  final MessageRepository repository;

  @override
  Future<Either<Failure, void>> call(NoParams params) {
    return repository.removeAllMessages();
  }
}
