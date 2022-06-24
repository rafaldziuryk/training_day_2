import 'package:dartz/dartz.dart';

import 'package:quiz_app/core/error.dart';
import 'package:quiz_app/features/messages/domain/repository/message_repository.dart';

import '../../../../core/use_case.dart';
import '../entity/message.dart';

class RemoveMessageUseCase extends UseCase<void, RemoveMessageUseCaseParams> {
  RemoveMessageUseCase({required this.repository});

  final MessageRepository repository;

  @override
  Future<Either<Failure, void>> call(RemoveMessageUseCaseParams params) {
    return repository.removeMessage(params.index);
  }
}

class RemoveMessageUseCaseParams {
  final int index;

  const RemoveMessageUseCaseParams({
    required this.index,
  });
}