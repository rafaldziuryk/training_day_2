import 'package:get_it/get_it.dart';
import 'package:quiz_app/features/messages/data/data_source/local_message_data_source.dart';
import 'package:quiz_app/features/messages/data/repository/message_repository_impl.dart';
import 'package:quiz_app/features/messages/domain/repository/message_repository.dart';
import 'package:quiz_app/features/messages/domain/use_case/add_message_use_case.dart';
import 'package:quiz_app/features/messages/domain/use_case/fetch_messages_use_case.dart';
import 'package:quiz_app/features/messages/domain/use_case/remove_message_use_case.dart';
import 'package:quiz_app/features/messages/domain/use_case/remove_messages_use_case.dart';
import 'package:quiz_app/features/messages/presentation/bloc/message_bloc.dart';

import '../features/messages/domain/entity/message.dart';
import '../features/shared/data/data_source/app_database.dart';

final di = GetIt.instance;

class DiContainer {
  Future init() async {
    //Database init's
    di.registerSingleton(AppDatabase());
    di.registerSingleton(LocalMessageDataSource(database: di.get()));
    di.registerSingleton<MessageRepository>(MessageRepositoryImpl(localMessageDataSource: di.get()));

    //Use Case init's
    di.registerSingleton(AddMessageUseCase(repository: di.get()));
    di.registerSingleton(FetchMessagesUseCase(repository: di.get()));
    di.registerSingleton(RemoveMessageUseCase(repository: di.get()));
    di.registerSingleton(RemoveMessagesUseCase(repository: di.get()));

    //BLoC init's
    di.registerFactory(() => MessageBloc(
        fetchMessagesUseCase: di.get(),
        addMessageUseCase: di.get(),
        removeMessageUseCase: di.get(),
        removeMessagesUseCase: di.get()));
  }
}
