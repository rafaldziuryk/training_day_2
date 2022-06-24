import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quiz_app/core/use_case.dart';
import '../../domain/entity/message.dart';
import '../../domain/use_case/add_message_use_case.dart';
import '../../domain/use_case/fetch_messages_use_case.dart';
import '../../domain/use_case/remove_message_use_case.dart';
import '../../domain/use_case/remove_messages_use_case.dart';

part 'message_event.dart';

part 'message_state.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  final FetchMessagesUseCase fetchMessagesUseCase;
  final AddMessageUseCase addMessageUseCase;
  final RemoveMessageUseCase removeMessageUseCase;
  final RemoveMessagesUseCase removeMessagesUseCase;

  MessageBloc({
    required this.fetchMessagesUseCase,
    required this.addMessageUseCase,
    required this.removeMessageUseCase,
    required this.removeMessagesUseCase,
  }) : super(MessageInitial()) {
    on<MessageEvent>((event, emit) async {
      if (event is MessageInit) {
        await fetchData(emit);
      } else if (event is MessageAdd) {
        final result = await addMessageUseCase(AddMessageUseCaseParams(message: event.message));
        await result.fold(
                (error) => null,
                (data) async {
              await fetchData(emit);
            }
        );
      } else if (event is MessageRemove) {
        final result = await removeMessageUseCase(RemoveMessageUseCaseParams(index: event.index));
        await result.fold(
                (l) {},
                (r) async {
                  await fetchData(emit);
                }
        );
      } else if(event is MessagesRemove) {
        final result = await removeMessagesUseCase(NoParams());
        await result.fold(
                (l) {},
                (r) async {
                  await fetchData(emit);
                });
      } else {
        return;
      }
    });
  }

  Future<void> fetchData(Emitter<MessageState> emit) async {
    final fetchResult = await fetchMessagesUseCase(NoParams());
    await fetchResult.fold(
            (error) {},
            (data) async {
          final dataState = MessageData(messages: data);
          print("Ilość: ${data.length}");
          emit(dataState);
        }
    );
  }
}
