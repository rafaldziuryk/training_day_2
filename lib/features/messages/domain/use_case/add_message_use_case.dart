import 'package:dartz/dartz.dart';

import 'package:quiz_app/core/error.dart';
import 'package:quiz_app/features/messages/domain/repository/message_repository.dart';

import '../../../../core/use_case.dart';
import '../entity/message.dart';

class AddMessageUseCase extends UseCase<void, AddMessageUseCaseParams> {
  AddMessageUseCase({required this.repository});

  final MessageRepository repository;

  @override
  Future<Either<Failure, void>> call(AddMessageUseCaseParams params) {
    return repository.addMessage(params.message);
  }
}

class AddMessageUseCaseParams {
  final Message message;

  const AddMessageUseCaseParams({
    required this.message,
  });
}